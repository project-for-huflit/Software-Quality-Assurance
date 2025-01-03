import { Storage } from '@google-cloud/storage';
import { DynamicModule, Module } from '@nestjs/common';
import * as fs from 'fs';

import {
	StorageBucketProviders,
	StorageBucketsProvider,
	StorageOptionsProvider,
} from './providers/bucket.providers';
import { getDefaultOptions } from './providers/defaultBucket';
import { FirestoreModuleOptions, StorageProps } from './types';

@Module({})
export class BucketModule {
	static forRoot(options: FirestoreModuleOptions): DynamicModule {
		const bucketProviders = StorageBucketProviders.map((providerName) => ({
			provide: providerName,
			useFactory: async (storage: Storage) => {
				const bucket = storage.bucket(
					providerName === 'default'
						? `${storage.projectId}.appspot.com`
						: providerName,
				);

				const [isExist] = await bucket.exists();

				if (!isExist) {
					const options = getDefaultOptions(storage.acl.WRITER_ROLE);

					await bucket
						.create()
						.catch((err) =>
							console.error(`bucket ${providerName} creation get error`, err),
						);

					console.info(`bucket ${providerName} created successfully`);

					bucket.acl.add(options, (err) => {
						if (!err) {
							console.info(`acl added successfully to ${providerName} bucket`);
						} else {
							console.error(`bucket ${providerName} error`, err);
						}
					});
				}

				return { bucket, storage };
			},
			inject: [StorageBucketsProvider],
		}));

		const optionsProvider = {
			provide: StorageOptionsProvider,
			useFactory: options.useFactory,
			inject: options.inject,
		};

		const provider = {
			provide: StorageBucketsProvider,
			useFactory: (config: StorageProps) => {
				const serviceAccount: { project_id?: string } = JSON.parse(
					fs.readFileSync(config.keyFilename, 'utf8'),
				);

				return new Storage({
					...config,
					projectId: serviceAccount.project_id ?? '',
				});
			},
			inject: [StorageOptionsProvider],
		};

		return {
			global: true,
			module: BucketModule,
			imports: options.imports,
			providers: [optionsProvider, provider, ...bucketProviders],
			exports: [provider, ...bucketProviders],
		};
	}
}

export * from './providers';
export * from './shared';
export * from './types';
