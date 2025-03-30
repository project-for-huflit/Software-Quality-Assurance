import { Module } from '@nestjs/common';
import { InvoiceController } from './controllers';
import { InvoiceService } from './services';
import { InvoiceRepository } from './repositories';
import { WalletModule } from '@/modules';

@Module({
	imports: [WalletModule],
	controllers: [InvoiceController],
	providers: [InvoiceService, InvoiceRepository],
	exports: [InvoiceService],
})
export class InvoiceModule {}
