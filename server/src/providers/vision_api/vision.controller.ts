import { Body, Controller, Post } from '@nestjs/common';
import { VisionService } from './vision.service';

@Controller('vision')
export class VisionController {
	constructor(private readonly visionService: VisionService) {}

	@Post('detect-text')
	async detectText(@Body('image') image: string) {
		const texts = await this.visionService.detectText(image);
		return { texts };
	}
}
