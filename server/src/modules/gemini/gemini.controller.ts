import { Body, Controller, Post } from '@nestjs/common';
import { GeminiService } from '@/modules/gemini/gemini.service';

@Controller('gemini')
export class GeminiController {
	constructor(private readonly geminiService: GeminiService) {}

	@Post('generate-text')
	async generateText(@Body() body: { type: string; prompt: string }): Promise<string> {
		const { type, prompt } = body;
		return this.geminiService.generateText(type, prompt);
	}
}
