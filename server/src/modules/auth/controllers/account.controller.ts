import {
	Body,
	Controller,
	FileTypeValidator,
	Get,
	MaxFileSizeValidator,
	NotFoundException,
	Param,
	ParseBoolPipe,
	ParseFilePipe,
	Patch,
	Post,
	Query,
	UploadedFile,
	UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';

import {
	IMG_MAX_1MB_SIZE_IN_BYTE,
	listPngAndJpegImageExt,
} from '@/common/constants';
import { CREATED, SuccessResponse } from '@/common/core';
import { getFileTypesRegexp } from '@/common/utils';
import { storage } from '@/common/utils/multer';

import { LoginDTO, LogoutDTO, RefreshTokenDTO, RegisterDTO } from '../dtos';
import { AccountRequestBody } from '../dtos/request';
import { AccountDocument } from '../entities';
import { AccountService, AuthService } from '../services';

@Controller('auth')
export class AuthController {
	constructor(private readonly authService: AuthService) {}
	//region JWT
	@Post()
	async register(@Body() body: RegisterDTO) {
		const result = await this.authService.register(body);
		new CREATED({
			message: 'Register OK!',
			metadata: result,
		});
	}
	@Post()
	async login(@Body() body: LoginDTO) {
		new SuccessResponse({
			metadata: await this.authService.login(body),
		});
	}
	@Post()
	async logout(@Body() body: LogoutDTO) {
		new SuccessResponse({
			message: 'Logout success!',
			metadata: await this.authService.logout(body),
		});
	}
	@Get()
	async handlerRefreshTokenUser(@Body() body: RefreshTokenDTO) {
		const { refreshToken, user, keyStore } = body;
		new SuccessResponse({
			message: 'Get token success!',
			metadata: await this.authService.handleRefreshToken({
				refreshToken: refreshToken,
				user: user,
				keyStore: keyStore,
			}),
		});
	}
}

@Controller('account')
export class AccountController {
	constructor(private readonly accountService: AccountService) {}

	@Get('/')
	async getList(
		@Query('isPublished', ParseBoolPipe) isPublished?: boolean,
	): Promise<AccountDocument[]> {
		const response = await this.accountService.getList({ isPublished });

		if (!response?.length) {
			throw new NotFoundException('Accounts are not exist');
		}

		return response;
	}

	@Get('/:id')
	async get(@Param('id') id: string): Promise<AccountDocument> {
		const response = await this.accountService.getItem(id);

		if (!response) {
			throw new NotFoundException('Account does not exist');
		}

		return response;
	}

	@Post('/')
	async create(@Body() body: AccountRequestBody): Promise<AccountDocument> {
		return this.accountService.create(body);
	}

	@Patch('/:id')
	async update(
		@Param('id') id: string,
		@Body() body: AccountRequestBody,
	): Promise<AccountDocument> {
		return this.accountService.update(id, body);
	}

	@Patch('/publish/:id')
	async togglePublish(@Param('id') id: string): Promise<AccountDocument> {
		return this.accountService.togglePublish(id);
	}

	@Post('/:id/image')
	@UseInterceptors(FileInterceptor('file', { storage, limits: { files: 1 } }))
	async updateAccountImage(
		@UploadedFile(
			new ParseFilePipe({
				validators: [
					new MaxFileSizeValidator({ maxSize: IMG_MAX_1MB_SIZE_IN_BYTE }),
					new FileTypeValidator({
						fileType: getFileTypesRegexp(listPngAndJpegImageExt),
					}),
				],
			}),
		)
		file: Express.Multer.File,
		@Param('id') id: string,
	): Promise<AccountDocument> {
		return this.accountService.updateImage(id, file);
	}
}
