import { IsEmail, IsString, MinLength } from 'class-validator';

export class LoginDTO {
	@IsString()
	@IsEmail()
	email: string;
	@IsString()
	@MinLength(1)
	password: string;
	@IsString()
	refreshToken: string | null;

	constructor(email: string, password: string, refreshToken: string) {
		this.email = email;
		this.password = password;
		this.refreshToken = refreshToken;
	}
}
