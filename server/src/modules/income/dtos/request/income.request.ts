import { Timestamp } from "@google-cloud/firestore";

export class IncomeRequestBody {
	id: string;
	amount: number;
	category: string;
	imageUrl: string;
	wallet: string;
	incomeAt: Timestamp;
}
