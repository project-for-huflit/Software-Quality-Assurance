import { Injectable, NotFoundException } from "@nestjs/common";
import { WalletRepository } from "../repositories";
import { WalletFilterDTO } from "../dtos";
import { WalletRequestBody } from "../dtos/request";

@Injectable()
export class WalletService {
    constructor(private readonly walletRepository: WalletRepository) {}

    public async getList(filter: WalletFilterDTO) {
        return this.walletRepository.find(filter);
    }

    public async getItem(id: string) {
        return this.walletRepository.getWalletByDocumentId(id);
    }

    public async create(body: WalletRequestBody) {
        return this.walletRepository.create(body);
    }

    public async update(id: string, body: WalletRequestBody) {
        const { doc, data } = await this.walletRepository.getUpdate(id);

        if (!doc || !data) {
            throw new NotFoundException('Example document does not exist');
        }

        const response = this.walletRepository.getValidProperties(
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
        const { doc, data } = await this.walletRepository.getUpdate(id);

        if (!doc || !data) {
            throw new NotFoundException('Example document does not exist');
        }

        const newPublishedState = !data?.isPublished;

        const response = this.walletRepository.getValidProperties(
            { ...data, isPublished: newPublishedState },
            true,
        );

        await doc.update({
            isPublished: newPublishedState,
            updatedAt: response?.updatedAt,
        });

        return response;
    }
}