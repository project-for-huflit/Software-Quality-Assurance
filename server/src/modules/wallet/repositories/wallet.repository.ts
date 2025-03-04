import { CollectionReference, Timestamp } from '@google-cloud/firestore';
import { Inject, Injectable, Logger } from '@nestjs/common';

import { getUniqueId } from '@/common/utils';

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

	async find(): Promise<WalletDocument[]> {
		const list: WalletDocument[] = [];

		const walletList = await  this.collection.get();
		// (doc: { data: () => WalletDocument; }) => list.push(doc.data());
		walletList.forEach((doc) => {
			list.push(doc.data() as WalletDocument);
		});
		return list;
	}

	async create(
		payload: Pick<WalletDocument, 'name'> & Partial<WalletDocument>,
	) {
		const validPayload = this.getValidProperties(payload);
		const document = this.collection.doc(validPayload.id);
		await document.set(validPayload);
		return validPayload;
	}

	public getValidProperties(
		document: Omit<WalletDocument, 'id'> & {
			id?: string;
		},
		newUpdatedAt = false,
	) {
		const dueDateMillis = Date.now();
		const createdAt = Timestamp.fromMillis(dueDateMillis);

		return {
			id: getUniqueId(),
			name: document.name,
			type: document.type ?? null,
			createdAt: document.createdAt ?? createdAt,
			updatedAt: newUpdatedAt ? createdAt : (document.updatedAt ?? null),
		};
	}

	public async deleteWalletById(id: string) {
		const doc = this.collection.doc(id);
		return await doc.delete();
	}
}
