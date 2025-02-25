import { Module } from '@nestjs/common';
import { VisionService } from './vision.service';
import { VisionController } from '@/providers/vision_api/vision.controller';
import { ConfigModule, ConfigService } from '@nestjs/config';
import * as vision from '@google-cloud/vision';
import * as path from 'path';

@Module({
	imports: [ConfigModule],
	controllers: [VisionController],
	providers: [
		{
			provide: vision.ImageAnnotatorClient,
			useFactory: (configService: ConfigService) => {
				return new vision.ImageAnnotatorClient({
					keyFilename: configService.get('VISION_API'),
				});
			},
			inject: [ConfigService],
		},
		VisionService,
	],
	exports: [VisionService],
})
export class VisionModule {}
