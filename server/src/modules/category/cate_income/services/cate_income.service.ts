import { Injectable } from '@nestjs/common';

import { getUniqueId } from '@/common/utils';
import { CreateCateIncomeDto } from '@/modules/category/cate_income/dtos/create-cate-income.dto';
import { FirestoreService } from '@/providers/firestore/services';

@Injectable()
export class Cate_incomeService {
	private collection = this.firestoreService.getCollectionRef('cate_income');

	constructor(private readonly firestoreService: FirestoreService) {}

	public async create(createCateIncomeDto: CreateCateIncomeDto) {
		return await this.collection.doc(getUniqueId()).set(createCateIncomeDto);
	}
}
