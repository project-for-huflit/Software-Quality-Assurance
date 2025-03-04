import {
	CollectionReference,
	Firestore,
	Timestamp,
} from '@google-cloud/firestore';
import { BadRequestException, Inject, Injectable } from '@nestjs/common';

import { getUniqueId } from '@/common/utils';
import { CreateCateExpenseDto } from '@/modules/category/cate_expense/dtos/create-cate-expense.dto';
import { Cate_ExpenseDocument } from '@/modules/category/cate_expense/entities/cate_expense.document';
import { FirestoreDatabaseProvider } from '@/providers/firestore/providers/firestore.providers';

@Injectable()
export class Cate_expenseService {
	constructor(
		@Inject(FirestoreDatabaseProvider) private firestore: Firestore,
		@Inject(Cate_ExpenseDocument.collectionName)
		private collection: CollectionReference<Cate_ExpenseDocument>,
	) {}

	public async create(createCateExpenseDto: CreateCateExpenseDto) {
		return this.firestore.runTransaction(async (transaction) => {
			const existed = await transaction.get(
				this.collection.where('name', '==', createCateExpenseDto.name).limit(1),
			);

			if (!existed.empty) {
				throw new BadRequestException('Tên danh mục chi đã tồn tại.');
			}

			const id = getUniqueId();
			const data = {
				id,
				name: createCateExpenseDto.name,
				createdAt: Timestamp.now(),
				updatedAt: Timestamp.now(),
			};

			transaction.set(this.collection.doc(id), data);

			return { message: 'Tạo danh mục chi thành công!', data };
		});
	}

	public async findAll() {
		const snapshot = await this.collection.get();
		const documents = snapshot.docs.map((doc) => doc.data());

		return {
			message: 'Lấy danh sách danh mục chi thành công!',
			data: documents,
		};
	}

	public async delete(id: string) {
		const nameRef = this.collection.doc(id);
		const res = await nameRef.get();

		if (!res.exists) {
			throw new BadRequestException('Danh mục chi không tồn tại!');
		}

		await nameRef.delete();

		return { message: 'Xóa danh mục chi thành công!' };
	}
}
