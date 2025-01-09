// Add a type for typing the module arguments
import { Settings } from '@google-cloud/firestore';

export type FirestoreModuleOptions = {
	imports: any[];
	useFactory: (...args: any[]) => Settings;
	inject: any[];
};
