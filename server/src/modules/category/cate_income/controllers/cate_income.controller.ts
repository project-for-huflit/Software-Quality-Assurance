import { Body, Controller, Delete,Get, Param, Patch, Post } from '@nestjs/common';

import { CreateCateIncomeDto } from '@/modules/category/cate_income/dtos/create-cate-income.dto';
import { Cate_incomeService } from '@/modules/category/cate_income/services/cate_income.service';

@Controller('cate_income')
export class Cate_incomeController {
	constructor(private readonly cateIncomeService: Cate_incomeService) {}

	@Post()
	create(@Body() createCateIncomeDto: CreateCateIncomeDto) {
		return this.cateIncomeService.create(createCateIncomeDto);
	}

	// @Get()
	// findAll() {
	// 	return this.usersService.findAll();
	// }

	// @Patch()
	// update(@Body() updateUserDto: UpdateUserDto) {
	// 	return this.usersService.update(updateUserDto);
	// }
	//
	// @Delete(':id')
	// remove(@Param('id') id: string) {
	// 	return this.usersService.remove(id);
	// }
}
