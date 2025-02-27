import { Firestore } from '@google-cloud/firestore';
import { DynamicModule, Global, Module } from '@nestjs/common';

import {
	FirestoreCollectionProviders,
	FirestoreDatabaseProvider,
	FirestoreOptionsProvider,
} from './providers/firestore.providers';
import { FirestoreModuleOptions } from './types';
import { FirestoreService } from '@/providers/firestore/services';

@Global()
@Module({
	providers: [FirestoreService],
	exports: [FirestoreService],
})
export class FirestoreModule {
	static forRoot(options: FirestoreModuleOptions): DynamicModule {
		const collectionProviders = FirestoreCollectionProviders.map(
			(providerName) => ({
				provide: providerName,
				useFactory: (db: any) => db.collection(providerName),
				inject: [FirestoreDatabaseProvider],
			}),
		);

		const optionsProvider = {
			provide: FirestoreOptionsProvider,
			useFactory: options.useFactory,
			inject: options.inject,
		};

		const dbProvider = {
			provide: FirestoreDatabaseProvider,
			useFactory: (config: any) => new Firestore(config),
			inject: [FirestoreOptionsProvider],
		};

		return {
			global: true,
			module: FirestoreModule,
			imports: options.imports,
			providers: [
				FirestoreService,
				optionsProvider,
				dbProvider,
				...collectionProviders,
			],
			exports: [dbProvider, FirestoreService, ...collectionProviders],
		};
	}
}
