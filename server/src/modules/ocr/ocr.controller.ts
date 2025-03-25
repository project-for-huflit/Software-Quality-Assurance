import { Body, Controller, Post } from '@nestjs/common';
import { OcrService } from '@/modules/ocr/ocr.service';

@Controller('ocr')
export class OcrController {
	constructor(private readonly ocrService: OcrService) {}

	@Post('process')
	async processImage(@Body() body: {type: string, imageBase64: string} ) {
		const { type, imageBase64 } = body;
		return this.ocrService.processImage(type, imageBase64);
	}
}
