import { CollectionReference, Query, Timestamp } from '@google-cloud/firestore';
import { Inject, Injectable, Logger } from '@nestjs/common';

import { getUniqueId, time } from '@/common/utils';

import { AccountFilter } from '../dtos';
import { AccountDocument } from '../entities';

@Injectable()
export class AccountRepository {
	private logger: Logger = new Logger(AccountRepository.name);

	constructor(
		@Inject(AccountDocument.collectionName)
		private collection: CollectionReference<AccountDocument>,
	) {}

	async getDataByDocumentId(
		id: string,
	): Promise<AccountDocument | null | undefined> {
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

	private findGenerator(filter: AccountFilter) {
		const collectionRef = this.collection;
		let query: Query<AccountDocument> = collectionRef;

		if (typeof filter?.isPublished === 'boolean') {
			query = query.where('isPublished', '==', filter.isPublished);
		}

		return query;
	}

	async find(filter: AccountFilter): Promise<AccountDocument[]> {
		const list: AccountDocument[] = [];
		let query = this.findGenerator(filter);

		query = query.orderBy('createdAt', 'desc');

		const snapshot = await query.get();

		snapshot.forEach((doc) => list.push(doc.data()));

		return list;
	}

	async create(
		payload: Pick<AccountDocument, 'title'> & Partial<AccountDocument>,
	) {
		const validPayload = this.getValidProperties(payload);
		const document = this.collection.doc(validPayload.id);
		await document.set(validPayload);

		return validPayload;
	}

	public getValidProperties(
		document: Omit<AccountDocument, 'id' | 'isPublished'> & {
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
