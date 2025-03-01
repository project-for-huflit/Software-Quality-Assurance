import { Body, Controller, Delete, Get, Param, Post } from '@nestjs/common';

import { CreateCateExpenseDto } from '@/modules/category/cate_expense/dtos/create-cate-expense.dto';
import { Cate_expenseService } from '@/modules/category/cate_expense/services/cate_expense.service';

@Controller('cate-expense')
export class Cate_expenseController {
	constructor(private readonly cateExpenseService: Cate_expenseService) {}

	@Post()
	create(@Body() createCateExpenseDto: CreateCateExpenseDto) {
		return this.cateExpenseService.create(createCateExpenseDto);
	}

	@Get()
	findAll() {
		return this.cateExpenseService.findAll();
	}

	@Delete(':id')
	delete(@Param('id') id: string) {
		return this.cateExpenseService.delete(id);
	}
}
