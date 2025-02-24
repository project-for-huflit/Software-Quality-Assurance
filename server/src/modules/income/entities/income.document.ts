import { Timestamp } from '@google-cloud/firestore';

export class IncomeDocument {
	static collectionName = 'income';

	id: string;
	amount: number;
	category: string;
	isPublished: boolean;
	imageUrl?: string | null;
	incomeAt: Timestamp;
	createdAt?: Timestamp | null;
	updatedAt?: Timestamp | null;
}
