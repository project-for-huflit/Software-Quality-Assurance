import { CollectionReference, Query, Timestamp } from '@google-cloud/firestore';
import { Inject, Injectable, Logger } from '@nestjs/common';

import { getUniqueId, time } from '@/common/utils';

import { IncomeFilterDTO } from '../dtos';
import { IncomeDocument } from '../entities';

@Injectable()
export class IncomeRepository {
	private logger: Logger = new Logger(IncomeRepository.name);

	constructor(
		@Inject(IncomeDocument.collectionName)
		private collection: CollectionReference<IncomeDocument>,
	) {}

	async getIncomeByDocumentId(
		id: string,
	): Promise<IncomeDocument | null | undefined> {
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

	private findGenerator(filter: IncomeFilterDTO) {
		const collectionRef = this.collection;
		let query: Query<IncomeDocument> = collectionRef;

		if (typeof filter?.isPublished === 'boolean') {
			query = query.where('isPublished', '==', filter.isPublished);
		}

		return query;
	}

	async find(filter: IncomeFilterDTO): Promise<IncomeDocument[]> {
		const list: IncomeDocument[] = [];
		let query = this.findGenerator(filter);

		query = query.orderBy('createdAt', 'desc');

		const snapshot = await query.get();

		snapshot.forEach((doc) => list.push(doc.data()));

		return list;
	}

	async create(
		payload: Omit<IncomeDocument, 'id' | 'isPublished'> & { 
			id?: string; isPublished?: boolean | null 
		}
	) {
		const validPayload = this.getValidProperties(payload);
		const document = this.collection.doc(validPayload.id);
		await document.set(validPayload);

		return validPayload;
	}

	public getValidProperties(
		document: Omit<IncomeDocument, 'id' | 'isPublished'> & {
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
			incomeAt: document.incomeAt ?? null,
			createdAt: document.createdAt ?? createdAt,
			updatedAt: newUpdatedAt ? createdAt : (document.updatedAt ?? null),
		};
	}

	public async deleteIncomeById(id: string) {
		const doc = this.collection.doc(id);
		return await doc.delete();
	}
}
