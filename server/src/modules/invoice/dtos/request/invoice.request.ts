import { Timestamp } from "@google-cloud/firestore";

export class InvoiceRequestBody {
	id: string;
	amount: number;
	category: string;
	isPublished: boolean;
	imageUrl: string;
	invoiceAt: Timestamp;
}
