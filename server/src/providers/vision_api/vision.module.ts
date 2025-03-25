import { Module } from '@nestjs/common';
import { VisionService } from './vision.service';
import { VisionController } from '@/providers/vision_api/vision.controller';
import { ConfigModule } from '@nestjs/config';
import * as vision from '@google-cloud/vision';
import { HttpModule } from '@nestjs/axios';

@Module({
	imports: [ConfigModule, HttpModule],
	controllers: [VisionController],
	providers: [
		{
			provide: vision.ImageAnnotatorClient,
			useFactory: () => {
				return new vision.ImageAnnotatorClient();
			},
		},
		VisionService,
	],
	exports: [VisionService],
})
export class VisionModule {}
