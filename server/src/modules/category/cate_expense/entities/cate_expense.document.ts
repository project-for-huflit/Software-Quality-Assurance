import { Timestamp } from '@google-cloud/firestore';

export class Cate_ExpenseDocument {
	static collectionName = 'cate_expense';

	id: string;
	name: string;
	createdAt?: Timestamp | null;
	updatedAt?: Timestamp | null;
}
