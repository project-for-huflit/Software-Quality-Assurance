import { Body, Controller, Post } from '@nestjs/common';
import { VisionService } from './vision.service';

@Controller('vision')
export class VisionController {
	constructor(private readonly visionService: VisionService) {}

	@Post('detect-text')
	async detectText(@Body('imagePath') imagePath: string) {
		const texts = await this.visionService.detectText(imagePath);
		return { texts };
	}
}
