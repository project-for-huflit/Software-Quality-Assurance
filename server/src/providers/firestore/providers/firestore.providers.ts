import { Cate_IncomeDocument } from '@/modules/category/cate_income/entities/cate_income.document';
import { IncomeDocument } from '@/modules/income/entities';
import { InvoiceDocument } from '@/modules/invoice/entities';
import { WalletDocument } from '@/modules/wallet/entities';

export const FirestoreDatabaseProvider = 'firestoredb';
export const FirestoreOptionsProvider = 'firestoreOptions';
export const FirestoreCollectionProviders: string[] = [
	/* Next, you will need to add classes for Firestore collection documents.*/

	WalletDocument.collectionName,
	InvoiceDocument.collectionName,
	IncomeDocument.collectionName,
	Cate_IncomeDocument.collectionName,
];
