import { Module } from '@nestjs/common';
import { VisionModule } from '@/providers/vision_api/vision.module';
import { GeminiModule } from '@/gemini/gemini.module';
import { OcrService } from '@/modules/ocr/ocr.service';
import { OcrController } from '@/modules/ocr/ocr.controller';

@Module({
	imports: [VisionModule, GeminiModule],
	controllers: [OcrController],
	providers: [OcrService],
})
export class OcrModule {}
