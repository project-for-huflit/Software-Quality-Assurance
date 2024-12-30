import { IsEmail, IsNumber, IsString, MinLength } from 'class-validator';

export class RegisterDTO {
	@IsString()
	name: string;
	@IsString()
	@IsEmail()
	email: string;
	@IsNumber()
	phone: number;
	@IsString()
	@MinLength(1)
	password: string;

	constructor(name: string, email: string, phone: number, password: string) {
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.password = password;
	}
}
