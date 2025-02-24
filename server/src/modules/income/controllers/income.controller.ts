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

import { IncomeDocument } from '../entities';
import { IncomeService } from '../services';
import { IncomeRequestBody } from '../dtos/request';

@Controller('income')
export class IncomeController {
	constructor(private readonly incomeService: IncomeService) {}

	@Get('')
	async getList(
		@Query('isPublished', ParseBoolPipe) isPublished?: boolean,
	): Promise<IncomeDocument[]> {
		const response = await this.incomeService.getList({ isPublished });

		if (!response?.length) {
			throw new NotFoundException('Income is not exist');
		}

		return response;
	}

	@Get('/:id')
	async get(@Param('id') id: string): Promise<IncomeDocument> {
		const response = await this.incomeService.getItem(id);

		if (!response) {
			throw new NotFoundException('Income does not exist');
		}

		return response;
	}

	@Post('/')
	async create(@Body() body: IncomeRequestBody): Promise<IncomeDocument> {
		return this.incomeService.create(body);
	}

	// @Patch('/:id')
	// async update(
	// 	@Param('id') id: string,
	// 	@Body() body: AccountRequestBody,
	// ): Promise<IncomeDocument> {
	// 	return this.incomeService.update(id, body);
	// }

	// @Patch('/publish/:id')
	// async togglePublish(@Param('id') id: string): Promise<IncomeDocument> {
	// 	return this.incomeService.togglePublish(id);
	// }

	@Delete("delete/:id")
	async deleteWallet(
		@Param('id') id: string
	): Promise<void> {
		return this.incomeService.deleteIncome(id);
	}
}
