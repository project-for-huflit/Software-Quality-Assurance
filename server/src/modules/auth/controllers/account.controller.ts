import { Body, Post, Controller } from '@nestjs/common';
import { AuthService } from '../services';
import { RegisterDTO } from '../dtos/register.dto';
import { CREATED, SuccessResponse } from '@/common/core';
import { IRequest } from '@/common/interfaces/Requests';

@Controller('auth')
export class AuthController {
	//region JWT
	@Post()
	async register(@Body() body: RegisterDTO) {
		const result = await AuthService.register(body);
		new CREATED({
			message: 'Register OK!',
			metadata: result,
			option: {},
		});
	}

	login = async ({ req, res }: IRequest) => {
		new SuccessResponse({
			metadata: await AuthService.login(req.body),
		}).send(res);
	};

	// logout = async ({req, res} : IRequest) => {
	//   const { keyStore } = req;
	//   new SuccessResponse({
	//     message: 'Logout success!',
	//     metadata: await AuthService.logout(keyStore),
	//   }).send(res);
	// };
	// handlerRefreshTokenUser = async ({req, res} : IRequest) => {
	//   const {
	//     refreshToken,
	//     user,
	//     keyStore
	//   } = req;
	//   new SuccessResponse({
	//     message: 'Get token success!',
	//     metadata: await AuthService.handleRefreshToken({
	//       refreshToken: refreshToken,
	//       user: user,
	//       keyStore: keyStore,
	//     }),
	//   }).send(res);
	// };
	// region POINTER SERVICE

	// loginPartner = async ({req, res} : IRequest) => {
	//   new SuccessResponse({
	//     metadata: await SSOService.login(req.body),
	//   }).send(res);
	// };
	// loginPointer = async ({req, res} : IRequest) => {
	//   new SuccessResponse({
	//     message: ' success!',
	//     metadata: await SSOService.loginWithPointer(req.body),
	//   }).send(res);
	// };

	// logoutPointer = async ({req, res} : IRequest) => {
	//   const { keyStore } = req;
	//   new SuccessResponse({
	//     message: 'Logout with partner success!',
	//     metadata: await SSOService.logout(keyStore),
	//   }).send(res);
	// };

	// registerPointer = async ({req, res} : IRequest) => {
	//   new CREATED({
	//     message: 'Register with pointer OK!',
	//     metadata: await SSOService.register(req.body),
	//     option: {}
	//   }).send(res);
	// };

	// handlerRefreshTokenPointer = async ({req, res} : IRequest) => {
	//     const {
	//       refreshToken,
	//       user,
	//       keyStore
	//     } = req;
	//   new SuccessResponse({
	//     message: 'Get token success!',
	//     metadata: await SSOService.handleRefreshToken({
	//       refreshToken: refreshToken,
	//       user: user,
	//       keyStore: keyStore,
	//     }),
	//   }).send(res);
	// };
}
