import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_FILTER } from '@nestjs/core';

import { GlobalExceptionFilter } from '@/common/filters';
import { envSchema } from '@/common/venv';
// import { DatabaseModule } from '@/db/database.module';
import { getEnvFile } from '@/global/env';
// import { AuthModule } from '@/modules/auth';
import { FirestoreModule } from '@/provider/firestore';

import { AppController } from './app.controller';
import { AppService } from './app.service';

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
	],
	exports: [],
})
export class AppModule {}
