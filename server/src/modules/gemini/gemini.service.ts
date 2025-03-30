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
		const formattedPrompt  = `Hãy trích xuất thông tin hóa đơn ${type} và chỉ trả về kết quả dưới dạng JSON không giải thích gì khác
			thuộc danh mục gì nếu hóa đơn các nước khác thì hãy chuyển đổi về đơn vị tiền tệ VND vì tôi tôi làm ứng dụng quản lý chi tiêu từ dữ liệu OCR sau: \n ${prompt}
		{
			"date": "DD/MM/YYYY",
					"totalAmount": {
						"value": số tiền VND,
						"currency": "Đơn vị tiền tệ VND",
					},
			"category": "Danh mục chi tiêu/ thu nhập",
			"source": "Nguồn gốc hóa đơn"	,
			"note": "Hóa đơn về về nước nào và số tiền gốc"
		}
	`;

		const model = this.googleAI.getGenerativeModel({ model: 'gemini-2.0-flash' });
		const result = await model.generateContent(formattedPrompt );
		const response = result.response.text();

		const cleanResponse = response.replace(/```json/g, '').replace(/```/g, '').trim();
		try {
			return JSON.parse(cleanResponse); // 🟢 Parse JSON thành Object
		} catch (error) {
			console.error('Lỗi parse JSON từ Gemini:', error);
			throw new Error('Gemini API không trả về JSON hợp lệ.');
		}
	}
}
