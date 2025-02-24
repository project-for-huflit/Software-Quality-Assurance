import {
	MiddlewareConsumer,
	Module,
	NestModule,
	RequestMethod,
	ValidationPipe,
} from '@nestjs/common';
import { CacheModule } from '@nestjs/cache-manager';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_FILTER, APP_PIPE } from '@nestjs/core';
import { ThrottlerModule } from '@nestjs/throttler';

import { GlobalExceptionFilter } from '@/common/filters';
import { LoggerMiddleware } from '@/common/middlewares';
import { envSchema } from '@/common/venv';
import { getEnvFile } from '@/global/env';
import { FirestoreModule } from '@/providers/firestore';

import { 
	WalletModule,
	InvoiceModule,
	IncomeModule,
	NotificationModule, 
	FileManagementModule
} from '@/modules';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { VisionModule } from '@/provider/vision_api/vision.module';

@Module({
	imports: [
		CacheModule.register({
			isGlobal: true
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
		FileManagementModule
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
