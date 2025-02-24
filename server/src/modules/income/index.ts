import { Module } from '@nestjs/common';

import { IncomeController } from './controllers';
import { IncomeRepository } from './repositories';
import { IncomeService } from './services';

@Module({
	controllers: [IncomeController],
	providers: [IncomeService, IncomeRepository],
	exports: [IncomeService],
})
export class WalletModule {}
