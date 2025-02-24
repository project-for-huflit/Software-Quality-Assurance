import { Module } from '@nestjs/common';
import { InvoiceController } from './controllers';
import { InvoiceService } from './services';
import { InvoiceRepository } from './repositories';

@Module({
	controllers: [InvoiceController],
	providers: [InvoiceService, InvoiceRepository],
	exports: [InvoiceService],
})
export class InvoiceModule {}
