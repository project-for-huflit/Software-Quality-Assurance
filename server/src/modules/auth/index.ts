import { Module } from '@nestjs/common';
import { authProvider } from './auth.provider';
import { } from './services';

@Module({
  providers: [AuthService, ...authProvider],
  exports: [AuthService],
})
export class AuthModule {}