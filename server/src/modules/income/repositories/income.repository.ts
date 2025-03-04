import { CollectionReference, Timestamp } from '@google-cloud/firestore';
import { Inject, Injectable, Logger } from '@nestjs/common';

import { getUniqueId } from '@/common/utils';

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

	async find(): Promise<IncomeDocument[]> {
		const list: IncomeDocument[] = [];

		const incomeList = await this.collection.get();
		incomeList.forEach((doc) => {
			list.push(doc.data() as IncomeDocument);
		});

		return list;
	}

	async create(
		payload: Omit<IncomeDocument, 'id'> & {
			id?: string;
		},
	) {
		const validPayload = this.getValidProperties(payload);
		const document = this.collection.doc(validPayload.id);
		await document.set(validPayload);

		return validPayload;
	}

	public getValidProperties(
		document: Omit<IncomeDocument, 'id'> & {
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
