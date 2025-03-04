import { Timestamp } from '@google-cloud/firestore';

export class Cate_IncomeDocument {
	static collectionName = 'cate_income';

	id: string;
	name: string;
	createdAt?: Timestamp | null;
	updatedAt?: Timestamp | null;
}
