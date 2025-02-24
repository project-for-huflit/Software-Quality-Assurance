import { Injectable } from '@nestjs/common';
import { ImageAnnotatorClient } from '@google-cloud/vision';

@Injectable()
export class VisionService {
	constructor(private readonly visionClient: ImageAnnotatorClient) {}

	async detectText(imagePath: string): Promise<string[]> {
		const [result] = await this.visionClient.textDetection(imagePath);
		const detections = result.textAnnotations;
		return detections ? detections.map(text => text.description ?? '') : [];
	}
}