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

	async getWalletByDocumentName(
		name: string,
	): Promise<WalletDocument | null | undefined> {
		const snapshot = await this.collection.where('name', '==', name).get();
		if (snapshot.empty) {
			return null;
		} else {
			return snapshot.docs[0].data();
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

	async updateWallet(id: string, data: Partial<WalletDocument>): Promise<void> {
		try {
			const querySnapshot = await this.collection.where('id', '==', id).get();

			if (querySnapshot.empty) {
				throw new Error(`Wallet với ID ${id} không tồn tại!`);
			}

			const docRef = querySnapshot.docs[0].ref;

			await docRef.update(data);

			this.logger.log(`Wallet ${id} updated successfully`);
		} catch (error) {
			this.logger.error(`Error updating wallet ${id}:`, error);
			throw error;
		}
	}

	async find(): Promise<WalletDocument[]> {
		const list: WalletDocument[] = [];

		const walletList = await  this.collection.get();
		walletList.forEach((doc) => {
			list.push(doc.data() as WalletDocument);
		});
		return list;
	}

	async create(
		payload: Omit<WalletDocument, 'id'> & {
			id?: string;
		},
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
			amount: document.amount ?? null,
			createdAt: document.createdAt ?? createdAt,
			updatedAt: newUpdatedAt ? createdAt : (document.updatedAt ?? null),
		};
	}

	public async deleteWalletById(id: string) {
		const doc = this.collection.doc(id);
		return await doc.delete();
	}
}
