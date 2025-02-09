import { Module } from '@nestjs/common';
import { WalletController } from './controllers';
import { WalletService } from './services';
import { WalletRepository } from './repositories';

@Module({
	controllers: [WalletController],
	providers: [WalletService, WalletRepository],
	exports: [WalletService],
})
export class WalletModule {}
