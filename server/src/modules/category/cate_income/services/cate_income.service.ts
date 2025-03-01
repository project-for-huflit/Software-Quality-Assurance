import {
	CollectionReference,
	Firestore,
	Timestamp,
} from '@google-cloud/firestore';
import { BadRequestException, Inject, Injectable } from '@nestjs/common';

import { getUniqueId } from '@/common/utils';
import { CreateCateIncomeDto } from '@/modules/category/cate_income/dtos/create-cate-income.dto';
import { Cate_IncomeDocument } from '@/modules/category/cate_income/entities/cate_income.document';
import { FirestoreDatabaseProvider } from '@/providers/firestore/providers/firestore.providers';

@Injectable()
export class Cate_incomeService {
	constructor(
		@Inject(FirestoreDatabaseProvider) private firestore: Firestore,
		@Inject(Cate_IncomeDocument.collectionName)
		private collection: CollectionReference<Cate_IncomeDocument>,
	) {}

	public async create(createCateIncomeDto: CreateCateIncomeDto) {
		return this.firestore.runTransaction(async (transaction) => {
			const existed = await transaction.get(
				this.collection.where('name', '==', createCateIncomeDto.name).limit(1),
			);

			if (!existed.empty) {
				throw new BadRequestException('Tên danh mục đã tồn tại.');
			}

			const id = getUniqueId();
			const data = {
				id,
				name: createCateIncomeDto.name,
				createdAt: Timestamp.now(),
				updatedAt: Timestamp.now(),
			};

			transaction.set(this.collection.doc(id), data);

			return { message: 'Tạo danh mục thành công!', data };
		});
	}

	public async findAll() {
		const snapshot = await this.collection.get();
		const documents = snapshot.docs.map((doc) => doc.data());

		return { message: 'Lấy danh sách danh mục thành công!', data: documents };
	}

	public async delete(id: string) {
		const nameRef = this.collection.doc(id);
		const res = await nameRef.get();

		if (!res.exists) {
			throw new BadRequestException('Danh mục không tồn tại!');
		}

		await nameRef.delete();

		return { message: 'Xóa danh mục thành công!' };
	}
}
