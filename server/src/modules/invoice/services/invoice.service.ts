import { Injectable, NotFoundException } from '@nestjs/common';

import { InvoiceFilterDTO } from '../dtos';
import { InvoiceRequestBody } from '../dtos/request';
import { InvoiceRepository } from '../repositories';

@Injectable()
export class InvoiceService {
	constructor(private readonly invoiceRepository: InvoiceRepository) {}

	public async getList(filter: InvoiceFilterDTO) {
		return this.invoiceRepository.find(filter);
	}

	public async getItem(id: string) {
		return this.invoiceRepository.getInvoiceByDocumentId(id);
	}

	public async create(body: InvoiceRequestBody) {
		return this.invoiceRepository.create(body);
	}

	// public async update(id: string, body: InvoiceRequestBody) {
	// 	const { doc, data } = await this.invoiceRepository.getUpdate(id);

	// 	if (!doc || !data) {
	// 		throw new NotFoundException('Example document does not exist');
	// 	}

	// 	const response = this.invoiceRepository.getValidProperties(
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
	// 	const { doc, data } = await this.invoiceRepository.getUpdate(id);

	// 	if (!doc || !data) {
	// 		throw new NotFoundException('Example document does not exist');
	// 	}

	// 	const newPublishedState = !data?.isPublished;

	// 	const response = this.invoiceRepository.getValidProperties(
	// 		{ ...data, isPublished: newPublishedState },
	// 		true,
	// 	);

	// 	await doc.update({
	// 		isPublished: newPublishedState,
	// 		updatedAt: response?.updatedAt,
	// 	});

	// 	return response;
	// }

	public async deleteInvoice(id: string): Promise<void> {
		await this.invoiceRepository.deleteInvoiceById(id);
	}
}
