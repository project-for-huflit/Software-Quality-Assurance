import {
	Body,
	Controller,
	Delete,
	Get,
	NotFoundException,
	Param,
	ParseBoolPipe,
	Patch,
	Post,
	Query,
} from '@nestjs/common';

import { AccountRequestBody } from '@/modules/auth/dtos/request';

import { WalletDocument } from '../entities';
import { WalletService } from '../services';

@Controller('wallet')
export class WalletController {
	constructor(private readonly walletService: WalletService) {}

	@Get('')
	async getList(
		@Query('isPublished', ParseBoolPipe) isPublished?: boolean,
	): Promise<WalletDocument[]> {
		const response = await this.walletService.getList({ isPublished });

		if (!response?.length) {
			throw new NotFoundException('Wallet is not exist');
		}

		return response;
	}

	@Get('/:id')
	async get(@Param('id') id: string): Promise<WalletDocument> {
		const response = await this.walletService.getItem(id);

		if (!response) {
			throw new NotFoundException('Wallet does not exist');
		}

		return response;
	}

	@Post('/')
	async create(@Body() body: AccountRequestBody): Promise<WalletDocument> {
		return this.walletService.create(body);
	}

	@Patch('/:id')
	async update(
		@Param('id') id: string,
		@Body() body: AccountRequestBody,
	): Promise<WalletDocument> {
		return this.walletService.update(id, body);
	}

	@Patch('/publish/:id')
	async togglePublish(@Param('id') id: string): Promise<WalletDocument> {
		return this.walletService.togglePublish(id);
	}

	@Delete("delete/:id")
	async deleteWallet(
		@Param('id') id: string
	): Promise<void> {
		return this.walletService.deleteWallet(id);
	}
}
