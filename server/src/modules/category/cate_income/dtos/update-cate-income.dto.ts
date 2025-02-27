import { PartialType } from '@nestjs/swagger';
import { CreateCateIncomeDto } from '@/modules/category/cate_income/dtos/create-cate-income.dto';

//data transfer object
export class UpdateCateIncomeDto extends PartialType(CreateCateIncomeDto){
}
