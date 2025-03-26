import { Injectable } from '@nestjs/common';
import { GoogleGenerativeAI } from '@google/generative-ai';

@Injectable()
export class GeminiService {
	private readonly googleAI: GoogleGenerativeAI;
	constructor() {
		const apiKey = process.env.GEMINI_API_KEY;
		if (!apiKey) {
			throw new Error('API Key for Google Gemini is missing!');
		}
		this.googleAI = new GoogleGenerativeAI(apiKey);
	}

	async generateText(type: string, prompt: string): Promise<string> {
		const formattedPrompt  = `Lấy tổng tiền ${type} và nó phù hợp để tên danh mục gì  từ dữ liệu OCR sau: \n ${prompt}`

		const model = this.googleAI.getGenerativeModel({ model: 'gemini-2.0-flash' });
		const result = await model.generateContent(formattedPrompt );
		const response = result.response;
		return response.text();
	}
}
