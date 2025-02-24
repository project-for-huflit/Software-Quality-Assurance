import {
	Body,
	Controller,
	Delete,
	Get,
	NotFoundException,
	Param,
	ParseBoolPipe,
	Post,
	Query,
} from '@nestjs/common';

import { InvoiceDocument } from '../entities';
import { InvoiceService } from '../services';
import { InvoiceRequestBody } from '../dtos/request';

@Controller('invoice')
export class InvoiceController {
	constructor(private readonly invoiceService: InvoiceService) {}

	@Get('')
	async getList(
		@Query('isPublished', ParseBoolPipe) isPublished?: boolean,
	): Promise<InvoiceDocument[]> {
		const response = await this.invoiceService.getList({ isPublished });

		if (!response?.length) {
			throw new NotFoundException('Invoice is not exist');
		}

		return response;
	}

	@Get('/:id')
	async get(@Param('id') id: string): Promise<InvoiceDocument> {
		const response = await this.invoiceService.getItem(id);

		if (!response) {
			throw new NotFoundException('Invoice does not exist');
		}

		return response;
	}

	@Post('/')
	async create(@Body() body: InvoiceRequestBody): Promise<InvoiceDocument> {
		return this.invoiceService.create(body);
	}

	// @Patch('/:id')
	// async update(
	// 	@Param('id') id: string,
	// 	@Body() body: InvoiceRequestBody,
	// ): Promise<InvoiceDocument> {
	// 	return this.invoiceService.update(id, body);
	// }

	// @Patch('/publish/:id')
	// async togglePublish(@Param('id') id: string): Promise<InvoiceDocument> {
	// 	return this.invoiceService.togglePublish(id);
	// }

	@Delete("delete/:id")
	async deleteInvoice(
		@Param('id') id: string
	): Promise<void> {
		return this.invoiceService.deleteInvoice(id);
	}
}
