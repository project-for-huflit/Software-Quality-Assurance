export interface IHandleRefreshToken {
	keyStore: string;
	user: object;
	refreshToken: string;
}

export interface IRegister {
	name: string;
	email: string;
	phone: number;
	password: string;
}

export interface ILogin {
	email: string;
	password: string;
	refreshToken: string | null;
}

export interface ILogout {
	keyStore: string;
}
