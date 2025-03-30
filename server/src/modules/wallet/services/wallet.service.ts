import { Injectable, NotFoundException } from '@nestjs/common';

import { WalletCreationDTO, WalletFilterDTO } from '../dtos';
import { WalletRequestBody } from '../dtos/request';
import { WalletRepository } from '../repositories';
import { WalletDocument } from '@/modules/wallet/entities';

@Injectable()
export class WalletService {
	constructor(private readonly walletRepository: WalletRepository) {}

	public async getList() {
		return this.walletRepository.find();
	}

	public async getItem(id: string) {
		return this.walletRepository.getWalletByDocumentId(id);
	}

	public async getItemByName(name: string) {
		return this.walletRepository.getWalletByDocumentName(name);
	}

	public async create(body: WalletCreationDTO) {
		return this.walletRepository.create(body);
	}

	public async update(id: string, body: WalletRequestBody) {
		const { doc, data } = await this.walletRepository.getUpdate(id);

		console.log('doc::', doc);

		if (!doc || !data) {
			throw new NotFoundException('Example document does not exist');
		}

		const response = this.walletRepository.getValidProperties(
			{ ...data, ...body },
			true,
		);

		console.log('response::', response);

		await doc.update(response);

		// const changedKeys = Object.keys(body);
		// const valuesToUpdate: Partial<AccountRequestBody> = {};

		// type ResponseKeys =
		// 	| 'id'
		// 	| 'title'
		// 	| 'text'
		// 	| 'imageUrl'
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

	async updateWallet(id: string, data: Partial<WalletDocument>): Promise<void> {
		return this.walletRepository.updateWallet(id, data);
	}
	public async togglePublish(id: string) {
		const { doc, data } = await this.walletRepository.getUpdate(id);

		if (!doc || !data) {
			throw new NotFoundException('Example document does not exist');
		}

		const response = this.walletRepository.getValidProperties(
			{ ...data },
			true,
		);

		await doc.update({
			updatedAt: response?.updatedAt,
		});

		return response;
	}

	public async deleteWallet(id: string): Promise<void> {
		await this.walletRepository.deleteWalletById(id);
	}
}
