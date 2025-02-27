import { IsNotEmpty, IsString } from 'class-validator';

//data transfer object
export class CreateCateIncomeDto {
	@IsString()
	@IsNotEmpty({ message: 'Name is required' })
	name: string;
}
