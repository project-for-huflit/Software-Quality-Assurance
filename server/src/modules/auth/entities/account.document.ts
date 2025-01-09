import { Timestamp } from '@google-cloud/firestore';

export class AccountDocument {
	static collectionName = 'account';

	id: string;
	title: string;
	text?: string | null;
	isPublished: boolean;
	imageUrl?: string | null;
	createdAt?: Timestamp | null;
	updatedAt?: Timestamp | null;
}
