import { IsString } from 'class-validator';

export class LogoutDTO {
	@IsString()
	keyStore: string;

	constructor(keyStore: string) {
		this.keyStore = keyStore;
	}
}
