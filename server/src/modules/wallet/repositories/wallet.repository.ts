import { CollectionReference, Query, Timestamp } from '@google-cloud/firestore';
import { Inject, Injectable, Logger } from '@nestjs/common';

import { getUniqueId, time } from '@/common/utils';

import { WalletFilterDTO } from '../dtos';
import { WalletDocument } from '../entities';

@Injectable()
export class WalletRepository {
	private logger: Logger = new Logger(WalletRepository.name);

	constructor(
		@Inject(WalletDocument.collectionName)
		private collection: CollectionReference<WalletDocument>,
	) {}

	async getWalletByDocumentId(
		id: string,
	): Promise<WalletDocument | null | undefined> {
		const snapshot = await this.collection.doc(id).get();

		if (!snapshot.exists) {
			return null;
		} else {
			return snapshot.data();
		}
	}

	async getUpdate(id: string) {
		const doc = this.collection.doc(id);
		const snapshot = await doc.get();

		if (!snapshot.exists) {
			return { doc: null, data: null };
		} else {
			return { doc, data: snapshot.data() };
		}
	}

	private findGenerator(filter: WalletFilterDTO) {
		const collectionRef = this.collection;
		let query: Query<WalletDocument> = collectionRef;

		if (typeof filter?.isPublished === 'boolean') {
			query = query.where('isPublished', '==', filter.isPublished);
		}

		return query;
	}

	async find(filter: WalletFilterDTO): Promise<WalletDocument[]> {
		const list: WalletDocument[] = [];
		let query = this.findGenerator(filter);

		query = query.orderBy('createdAt', 'desc');

		const snapshot = await query.get();

		snapshot.forEach((doc) => list.push(doc.data()));

		return list;
	}

	async create(
		payload: Pick<WalletDocument, 'title'> & Partial<WalletDocument>,
	) {
		const validPayload = this.getValidProperties(payload);
		const document = this.collection.doc(validPayload.id);
		await document.set(validPayload);

		return validPayload;
	}

	public getValidProperties(
		document: Omit<WalletDocument, 'id' | 'isPublished'> & {
			id?: string;
			isPublished?: boolean | null;
		},
		newUpdatedAt = false,
	) {
		const dueDateMillis = time().valueOf();
		const createdAt = Timestamp.fromMillis(dueDateMillis);

		return {
			id: document.id || getUniqueId(),
			title: document.title,
			text: document.text ?? null,
			imageUrl: document.imageUrl ?? null,
			isPublished: document.isPublished ?? false,
			createdAt: document.createdAt ?? createdAt,
			updatedAt: newUpdatedAt ? createdAt : (document.updatedAt ?? null),
		};
	}
}
