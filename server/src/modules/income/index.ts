import { Module } from '@nestjs/common';

import { IncomeController } from './controllers';
import { IncomeRepository } from './repositories';
import { IncomeService } from './services';
import { WalletService } from '@/modules/wallet/services';
import { WalletModule } from '@/modules';

@Module({
	imports: [WalletModule],
	controllers: [IncomeController],
	providers: [IncomeService, IncomeRepository],
	exports: [IncomeService],
})
export class IncomeModule {}
