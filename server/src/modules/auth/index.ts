import { Module } from '@nestjs/common';
import { AuthService } from './services';
import { AuthController } from './controllers';

@Module({
	controllers: [AuthController],
	providers: [AuthService],
	exports: [AuthService],
})
export class AuthModule {}
