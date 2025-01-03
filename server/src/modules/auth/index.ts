import { Module } from '@nestjs/common';

import { AccountController, AuthController } from './controllers';
import { AccountDocument } from './entities';
import { AccountRepository } from './repositories';
import { AuthService } from './services';

@Module({
	controllers: [AuthController, AccountController],
	providers: [AuthService, AccountDocument, AccountRepository],
	exports: [AuthService, AccountRepository],
})
export class AuthModule {}
