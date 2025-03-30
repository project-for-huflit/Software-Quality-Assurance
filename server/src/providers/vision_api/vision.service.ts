import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';

interface TextAnnotation {
	description: string;
	// Các thuộc tính khác nếu cần
}

@Injectable()
export class VisionService {
	constructor(private readonly httpService: HttpService) {}

	async detectText(imageBase64: string): Promise<string[]> {
		const apiKey = process.env.GOOGLE_VISION_API_KEY;
		if (!apiKey) {
			throw new Error('Google Vision API Key is missing!');
		}

		const url = `https://vision.googleapis.com/v1/images:annotate?key=${apiKey}`;

		const requestBody = {
			requests: [
				{
					image:  {"source": {"imageUri": imageBase64 }}, //nếu truyền hình ảnh sửa lại thành {"content": imageBase64}
					features: [{ type: 'TEXT_DETECTION' }],
				},
			],
		};

		try {
			const response = await firstValueFrom(this.httpService.post(url, requestBody));
			const detections: TextAnnotation[] = response.data.responses[0]?.textAnnotations || [];
			return detections.map((text) => text.description);
		} catch (error) {
			console.error('Error calling Google Vision API:', error);
			throw new Error('Failed to process image OCR');
		}
	}
}
