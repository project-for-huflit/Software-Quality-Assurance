import { Module } from '@nestjs/common';

import { Cate_incomeController } from '@/modules/category/cate_income/controllers/cate_income.controller';
import { Cate_incomeService } from '@/modules/category/cate_income/services/cate_income.service';

@Module({
	controllers: [Cate_incomeController],
	providers: [Cate_incomeService],
})
export class Cate_incomeModule {}
