import { IsObject, IsString } from 'class-validator';

export class RefreshTokenDTO {
	@IsString()
	keyStore: string;
	@IsObject()
	user: object;
	@IsString()
	refreshToken: string;

	constructor(name: string, user: object, refreshToken: string) {
		this.keyStore = name;
		this.user = user;
		this.refreshToken = refreshToken;
	}
}
