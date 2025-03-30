import { CollectionReference, Query, Timestamp } from '@google-cloud/firestore';
import { Inject, Injectable, Logger } from '@nestjs/common';

import { getUniqueId, time } from '@/common/utils';

import { InvoiceFilterDTO } from '../dtos';
import { InvoiceDocument } from '../entities';
import { WalletService } from '@/modules/wallet/services';

@Injectable()
export class InvoiceRepository {
	private logger: Logger = new Logger(InvoiceRepository.name);

	constructor(
		@Inject(InvoiceDocument.collectionName)
		private collection: CollectionReference<InvoiceDocument>,
		private readonly walletService: WalletService
	) {}

	async getInvoiceByDocumentId(
		id: string,
	): Promise<InvoiceDocument | null | undefined> {
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

	async find(): Promise<InvoiceDocument[]> {
		const list: InvoiceDocument[] = [];

		const invoiceList = await  this.collection.get();
		invoiceList.forEach((doc) => {
			list.push(doc.data() as InvoiceDocument);
		});
		return list;
	}

	async create(
		payload: Omit<InvoiceDocument, 'id' > & { 
			id?: string;
		},
	) {
		const findWallet = await this.walletService.getItemByName(payload.wallet);
		if (!findWallet) {
			throw new Error('Wallet không tồn tại!');
		}

		if (payload.amount < 0){
			throw new Error('Số tiền phải lớn hơn 0!');
		}

		findWallet.amount = Number(findWallet.amount) - Number(payload.amount);

		await this.walletService.updateWallet(findWallet.id, { amount: findWallet.amount });

		const validPayload = this.getValidProperties(payload);
		const document = this.collection.doc(validPayload.id);
		await document.set(validPayload);

		return validPayload;
	}

	public getValidProperties(
		document: Omit<InvoiceDocument, 'id' > & {
			id?: string;
		},
		newUpdatedAt = false,
	) {
		const dueDateMillis = Date.now();
		const createdAt = Timestamp.fromMillis(dueDateMillis);

		return {
			id: getUniqueId(),
			amount: document.amount ?? null,
			category: document.category ?? null,
			imageUrl: document.imageUrl ?? null,
			wallet: document.wallet ?? null,
			invoiceAt: document.invoiceAt ?? null,
			createdAt: document.createdAt ?? createdAt,
			updatedAt: newUpdatedAt ? createdAt : (document.updatedAt ?? null),
		}; 
	}

	public async deleteInvoiceById(id: string) {
		const doc = this.collection.doc(id);
		return await doc.delete();
	}
}
