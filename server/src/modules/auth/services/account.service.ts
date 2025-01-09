import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import * as fs from 'fs';

import {
	BucketProvider,
	BucketSharedService,
	DefaultBucketProvider,
} from '@/provider/bucket';

import { AccountFilter } from '../dtos';
import { AccountRequestBody } from '../dtos/request';
import { AccountRepository } from '../repositories';

@Injectable()
export class AccountService {
	private bucketService: BucketSharedService;

	constructor(
		private readonly accountRepository: AccountRepository,
		@Inject(DefaultBucketProvider.bucketName)
		private readonly bucketProvider: BucketProvider,
	) {
		this.bucketService = new BucketSharedService(
			this.bucketProvider.bucket,
			AccountService.name,
		);
	}

	public async getList(filter: AccountFilter) {
		return this.accountRepository.find(filter);
	}

	public async getItem(id: string) {
		return this.accountRepository.getDataByDocumentId(id);
	}

	public async create(body: AccountRequestBody) {
		return this.accountRepository.create(body);
	}

	public async update(id: string, body: AccountRequestBody) {
		const { doc, data } = await this.accountRepository.getUpdate(id);

		if (!doc || !data) {
			throw new NotFoundException('Example document does not exist');
		}

		const response = this.accountRepository.getValidProperties(
			{ ...data, ...body },
			true,
		);

		console.log('response::', response);

		// const changedKeys = Object.keys(body);
		// const valuesToUpdate: Partial<AccountRequestBody> = {};

		// type ResponseKeys =
		// 	| 'id'
		// 	| 'title'
		// 	| 'text'
		// 	| 'imageUrl'
		// 	| 'isPublished'
		// 	| 'createdAt'
		// 	| 'updatedAt';

		// for (const key of changedKeys) {
		// 	const newValue = response?.[key];
		// 	const currentValue = doc?.[key];

		// 	if (newValue !== currentValue) {
		// 		valuesToUpdate[key] = newValue;
		// 	}
		// }

		// if (Object.keys(valuesToUpdate).length > 0) {
		// 	await doc.update({ ...valuesToUpdate, updatedAt: response?.updatedAt });
		// }

		// return response;
		return response;
	}

	public async togglePublish(id: string) {
		const { doc, data } = await this.accountRepository.getUpdate(id);

		if (!doc || !data) {
			throw new NotFoundException('Example document does not exist');
		}

		const newPublishedState = !data?.isPublished;

		const response = this.accountRepository.getValidProperties(
			{ ...data, isPublished: newPublishedState },
			true,
		);

		await doc.update({
			isPublished: newPublishedState,
			updatedAt: response?.updatedAt,
		});

		return response;
	}

	public async updateImage(id: string, file: Express.Multer.File) {
		try {
			const { doc, data } = await this.accountRepository.getUpdate(id);

			if (!doc || !data) {
				throw new NotFoundException('Example document does not exist');
			}

			const imageUrl = await this.bucketService.saveFileByUploadsFolder(
				file,
				`example/${data?.id}`,
			);

			try {
				/**
				 * Try to remove previously file
				 */
				await this.bucketService.deleteFileByName(
					data?.imageUrl || '',
					`example/${data?.id}`,
				);
			} catch {}

			const response = this.accountRepository.getValidProperties(
				{ ...data, imageUrl },
				true,
			);

			await doc.update({ imageUrl, updatedAt: response?.updatedAt });

			/**
			 * Need for deletion uploads/ file path
			 */
			fs.unlinkSync(file.path);

			return response;
		} catch (error) {
			/**
			 * Need for deletion uploads/ file path
			 */
			fs.unlinkSync(file.path);

			throw error;
		}
	}
}
