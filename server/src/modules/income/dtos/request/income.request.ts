import { Timestamp } from "@google-cloud/firestore";

export class IncomeRequestBody {
	id: string;
	amount: number;
	category: string;
	isPublished: boolean;
	imageUrl: string;
	incomeAt: Timestamp;
}
