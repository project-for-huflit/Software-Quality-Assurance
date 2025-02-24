import { Timestamp } from '@google-cloud/firestore';

export class InvoiceDocument {
	static collectionName = 'invoice';

	id: string;
	amount: number;
	category: string;
	isPublished: boolean;
	imageUrl?: string | null;
	invoiceAt: Timestamp;
	createdAt?: Timestamp | null;
	updatedAt?: Timestamp | null;
}
