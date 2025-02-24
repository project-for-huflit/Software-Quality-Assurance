import { Injectable, NotFoundException } from '@nestjs/common';

import { IncomeFilterDTO } from '../dtos';
import { IncomeRequestBody } from '../dtos/request';
import { IncomeRepository } from '../repositories';

@Injectable()
export class IncomeService {
	constructor(private readonly incomeRepository: IncomeRepository) {}

	public async getList(filter: IncomeFilterDTO) {
		return this.incomeRepository.find(filter);
	}

	public async getItem(id: string) {
		return this.incomeRepository.getIncomeByDocumentId(id);
	}

	public async create(body: IncomeRequestBody) {
		return this.incomeRepository.create(body);
	}

	// public async update(id: string, body: IncomeRequestBody) {
	// 	const { doc, data } = await this.incomeRepository.getUpdate(id);

	// 	if (!doc || !data) {
	// 		throw new NotFoundException('Example document does not exist');
	// 	}

	// 	const response = this.incomeRepository.getValidProperties(
	// 		{ ...data, ...body },
	// 		true,
	// 	);

	// 	console.log('response::', response);

	// 	// const changedKeys = Object.keys(body);
	// 	// const valuesToUpdate: Partial<AccountRequestBody> = {};

	// 	// type ResponseKeys =
	// 	// 	| 'id'
	// 	// 	| 'title'
	// 	// 	| 'text'
	// 	// 	| 'imageUrl'
	// 	// 	| 'isPublished'
	// 	// 	| 'createdAt'
	// 	// 	| 'updatedAt';

	// 	// for (const key of changedKeys) {
	// 	// 	const newValue = response?.[key];
	// 	// 	const currentValue = doc?.[key];

	// 	// 	if (newValue !== currentValue) {
	// 	// 		valuesToUpdate[key] = newValue;
	// 	// 	}
	// 	// }

	// 	// if (Object.keys(valuesToUpdate).length > 0) {
	// 	// 	await doc.update({ ...valuesToUpdate, updatedAt: response?.updatedAt });
	// 	// }

	// 	// return response;
	// 	return response;
	// }

	// public async togglePublish(id: string) {
	// 	const { doc, data } = await this.incomeRepository.getUpdate(id);

	// 	if (!doc || !data) {
	// 		throw new NotFoundException('Example document does not exist');
	// 	}

	// 	const newPublishedState = !data?.isPublished;

	// 	const response = this.incomeRepository.getValidProperties(
	// 		{ ...data, isPublished: newPublishedState },
	// 		true,
	// 	);

	// 	await doc.update({
	// 		isPublished: newPublishedState,
	// 		updatedAt: response?.updatedAt,
	// 	});

	// 	return response;
	// }

	public async deleteIncome(id: string): Promise<void> {
		await this.incomeRepository.deleteIncomeById(id);
	}
}
