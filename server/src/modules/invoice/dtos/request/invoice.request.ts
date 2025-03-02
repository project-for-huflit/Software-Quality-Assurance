import { Timestamp } from "@google-cloud/firestore";

export class InvoiceRequestBody {
	id: string;
	amount: number;
	category: string;
	imageUrl: string;
	invoiceAt: Timestamp;
}
