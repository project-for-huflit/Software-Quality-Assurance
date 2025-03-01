import { IsNotEmpty, IsString } from 'class-validator';

//data transfer object
export class CreateCateExpenseDto {
	@IsString()
	@IsNotEmpty({ message: 'Name is required' })
	name: string;
}
