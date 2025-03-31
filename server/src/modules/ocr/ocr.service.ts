import { Injectable } from '@nestjs/common';
import { VisionService } from '@/providers/vision_api/vision.service';
import { GeminiService } from '@/modules/gemini/gemini.service';

@Injectable()
export class OcrService {
	constructor(
		private readonly visionService: VisionService,
		private readonly geminiService: GeminiService,
	) {}

	async processImage(type: string, imageBase64: string) {
		const extractedTexts = await this.visionService.detectText(imageBase64);
		const textContent = extractedTexts.join(' ');

		return await this.geminiService.generateText(type, textContent);
	}
}
