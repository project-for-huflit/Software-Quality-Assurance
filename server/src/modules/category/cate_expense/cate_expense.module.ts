import { Module } from '@nestjs/common';

import { Cate_expenseController } from '@/modules/category/cate_expense/controllers/cate_expense.controller';
import { Cate_expenseService } from '@/modules/category/cate_expense/services/cate_expense.service';

@Module({
	controllers: [Cate_expenseController],
	providers: [Cate_expenseService],
})
export class Cate_expenseModule {}
