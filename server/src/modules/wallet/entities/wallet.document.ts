import { Timestamp } from '@google-cloud/firestore';

export class WalletDocument {
	static collectionName = 'wallet';

	id: string;
	name: string;
	type?: string | null;
	isPublished: boolean;
	createdAt?: Timestamp | null;
	updatedAt?: Timestamp | null;
}
