import { Body, Controller, Delete, Get, Param, Post } from '@nestjs/common';

import { CreateCateIncomeDto } from '@/modules/category/cate_income/dtos/create-cate-income.dto';
import { Cate_incomeService } from '@/modules/category/cate_income/services/cate_income.service';

@Controller('cate-income')
export class Cate_incomeController {
	constructor(private readonly cateIncomeService: Cate_incomeService) {}

	@Post()
	create(@Body() createCateIncomeDto: CreateCateIncomeDto) {
		return this.cateIncomeService.create(createCateIncomeDto);
	}

	@Get()
	findAll() {
		return this.cateIncomeService.findAll();
	}

	@Delete(':id')
	delete(@Param('id') id: string) {
		return this.cateIncomeService.delete(id);
	}
}
