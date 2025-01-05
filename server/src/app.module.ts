import {
	MiddlewareConsumer,
	Module,
	NestModule,
	RequestMethod,
	ValidationPipe,
} from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_FILTER, APP_GUARD, APP_PIPE } from '@nestjs/core';
import { ThrottlerModule } from '@nestjs/throttler';

import { GlobalExceptionFilter } from '@/common/filters';
import { LoggerMiddleware } from '@/common/middlewares';
import { envSchema } from '@/common/venv';
// import { DatabaseModule } from '@/db/database.module';
import { getEnvFile } from '@/global/env';
// import { BucketModule } from '@/provider/bucket';
// import { AuthModule } from '@/modules/auth';
import { FirestoreModule } from '@/provider/firestore';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CombinedGuard } from './common/guards';

@Module({
	imports: [
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
		ThrottlerModule.forRoot([
			{
				name: 'submit',
				ttl: 1000,
				limit: 3,
			},
			{
				name: 'long',
				ttl: 60000,
				limit: 100,
			},
		]),
		// DatabaseModule,
		// AuthModule,
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
		{
			provide: APP_GUARD,
			useClass: CombinedGuard,
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
