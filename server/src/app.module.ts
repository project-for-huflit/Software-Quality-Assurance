import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './db/database.module';

@Module({
  imports: [
    ConfigModule.forRoot({
    envFilePath: [
      '.example.env',
      '.env.development', 
      '.env'
    ], 
    isGlobal: true
  }),
  DatabaseModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
