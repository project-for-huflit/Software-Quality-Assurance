import { Body, Controller, HttpException, HttpStatus, Post } from '@nestjs/common';
import { OcrService } from '@/modules/ocr/ocr.service';

@Controller('ocr')
export class OcrController {
	constructor(private readonly ocrService: OcrService) {}

	@Post('process')
	async processImage(@Body() body: {type: string, imageBase64: string} ) {
		const { type, imageBase64 } = body;

		if (!imageBase64) {
			throw new HttpException('Thiếu dữ liệu ảnh', HttpStatus.BAD_REQUEST);
		}

		try {
			const result = await this.ocrService.processImage(type, imageBase64);
			return {
				statusCode: HttpStatus.CREATED, // 201
				message: 'Xử lý ảnh thành công',
				data: result,
			};
		} catch (error) {
			throw new HttpException('Lỗi xử lý ảnh', HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
