import { CollectionReference, Query, Timestamp } from '@google-cloud/firestore';
import { Inject, Injectable, Logger } from '@nestjs/common';

import { getUniqueId, time } from '@/common/utils';

import { InvoiceFilterDTO } from '../dtos';
import { InvoiceDocument } from '../entities';

@Injectable()
export class InvoiceRepository {
	private logger: Logger = new Logger(InvoiceRepository.name);

	constructor(
		@Inject(InvoiceDocument.collectionName)
		private collection: CollectionReference<InvoiceDocument>,
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

	private findGenerator(filter: InvoiceFilterDTO) {
		const collectionRef = this.collection;
		let query: Query<InvoiceDocument> = collectionRef;

		if (typeof filter?.isPublished === 'boolean') {
			query = query.where('isPublished', '==', filter.isPublished);
		}

		return query;
	}

	async find(filter: InvoiceFilterDTO): Promise<InvoiceDocument[]> {
		const list: InvoiceDocument[] = [];
		let query = this.findGenerator(filter);

		query = query.orderBy('createdAt', 'desc');

		const snapshot = await query.get();

		snapshot.forEach((doc) => list.push(doc.data()));

		return list;
	}

	async create(
		payload: Omit<InvoiceDocument, 'id' | 'isPublished'> & { 
			id?: string; isPublished?: boolean | null 
		},
	) {
		const validPayload = this.getValidProperties(payload);
		const document = this.collection.doc(validPayload.id);
		await document.set(validPayload);

		return validPayload;
	}

	public getValidProperties(
		document: Omit<InvoiceDocument, 'id' | 'isPublished'> & {
			id?: string;
			isPublished?: boolean | null;
		},
		newUpdatedAt = false,
	) {
		const dueDateMillis = time().valueOf();
		const createdAt = Timestamp.fromMillis(dueDateMillis);

		return {
			id: getUniqueId(),
			amount: document.amount ?? null,
			category: document.category ?? null,
			isPublished: document.isPublished ?? false,
			imageUrl: document.imageUrl ?? null,
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
