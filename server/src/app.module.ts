import { CacheModule } from '@nestjs/cache-manager';
import {
	MiddlewareConsumer,
	Module,
	NestModule,
	RequestMethod,
	ValidationPipe,
} from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_FILTER, APP_PIPE } from '@nestjs/core';
import { ThrottlerModule } from '@nestjs/throttler';

import { GlobalExceptionFilter } from '@/common/filters';
import { LoggerMiddleware } from '@/common/middlewares';
import { envSchema } from '@/common/venv';
import { getEnvFile } from '@/global/env';
import {
	FileManagementModule,
	IncomeModule,
	InvoiceModule,
	NotificationModule,
	WalletModule,
} from '@/modules';
import { Cate_expenseModule } from '@/modules/category/cate_expense/cate_expense.module';
import { Cate_incomeModule } from '@/modules/category/cate_income/cate_income.module';
import { FirestoreModule } from '@/providers/firestore';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { VisionModule } from './providers/vision_api/vision.module';

@Module({
	imports: [
		CacheModule.register({
			isGlobal: true,
		}),
		ConfigModule.forRoot({
			envFilePath: getEnvFile(),
			validationSchema: envSchema,
			validationOptions: {
				abortEarly: false,
			},
			isGlobal: true,
			cache: true,
			expandVariables: true,
		}),
		FirestoreModule.forRoot({
			imports: [ConfigModule],
			useFactory: (configService: ConfigService) => ({
				keyFilename: configService.get<string>('FIREBASE_KEY_FILE_PATH'),
			}),
			inject: [ConfigService],
		}),
		// BucketModule.forRoot({
		// 	imports: [ConfigModule],
		// 	useFactory: (configService: ConfigService) => ({
		// 		keyFilename: configService.get<string>('FIREBASE_KEY_FILE_PATH'),
		// 	}),
		// 	inject: [ConfigService],
		// }),
		// CloudinaryModule.forRoot({}),
		ThrottlerModule.forRoot([
			{
				name: 'click',
				ttl: 1000,
				limit: 1,
			},
			{
				name: 'submit',
				ttl: 1000,
				limit: 1,
			},
		]),
		VisionModule,
		NotificationModule,
		WalletModule,
		InvoiceModule,
		IncomeModule,
		FileManagementModule,
		Cate_incomeModule,
		Cate_expenseModule,
	],
	controllers: [AppController],
	providers: [
		AppService,
		{
			provide: APP_FILTER,
			useClass: GlobalExceptionFilter,
		},
		{
			provide: APP_PIPE,
			useClass: ValidationPipe,
		},
	],
	exports: [],
})
export class AppModule implements NestModule {
	configure(consumer: MiddlewareConsumer) {
		consumer
			.apply(LoggerMiddleware)
			.forRoutes({ path: '', method: RequestMethod.ALL });
	}
}
