import { Timestamp } from '@google-cloud/firestore';

export class WalletDocument {
	static collectionName = 'wallet';

	id: string;
	name: string;
	type?: string | null;
	amount: number;
	createdAt?: Timestamp | null;
	updatedAt?: Timestamp | null;
}
