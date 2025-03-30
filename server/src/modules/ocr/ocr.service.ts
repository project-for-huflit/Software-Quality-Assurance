import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { VisionService } from '@/providers/vision_api/vision.service';
import { GeminiService } from '@/modules/gemini/gemini.service';

@Injectable()
export class OcrService {
	constructor(
		private readonly visionService: VisionService,
		private readonly geminiService: GeminiService,
	) {}

	async processImage(type: string, imageBase64: string) {
		try {
			const extractedTexts = await this.visionService.detectText(imageBase64);
			if (!extractedTexts.length) {
				throw new HttpException('Không phát hiện được chữ trong ảnh', HttpStatus.UNPROCESSABLE_ENTITY);
			}

			const textContent = extractedTexts.join(' ');
			return await this.geminiService.generateText(type, textContent);
		} catch (error) {
			throw new HttpException('Lỗi xử lý ảnh', HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
