import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';

@Controller('cate_income')
export class Cate_incomeController {
	constructor(private readonly cate ) {}

	@Post()
	create(@Body() createUserDto: ) {
		return this.usersService.create(createUserDto);
	}

	@Get()
	findAll() {
		return this.usersService.findAll();
	}

	@Get(':id')
	findOne(@Param('id') id: string) {
		return this.usersService.findOne(id);
	}

	@Patch()
	update(@Body() updateUserDto: UpdateUserDto) {
		return this.usersService.update(updateUserDto);
	}

	@Delete(':id')
	remove(@Param('id') id: string) {
		return this.usersService.remove(id);
	}
}
