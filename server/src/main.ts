import { NestFactory } from '@nestjs/core';
import * as compression from 'compression';
import * as express from 'express';

import { AppModule } from '@/app.module';
import { setupFirebase, setupSwagger } from '@/common/configs';
import { corsOptions } from '@/common/constants';
import { _PORT, firebaseKeyFilePath } from '@/common/venv';

async function bootstrap() {
	const app = await NestFactory.create(AppModule);

	app.enableCors(corsOptions);

	app.use(compression());
	app.use(express.json({ limit: '20mb' }));
	app.use(express.urlencoded({ extended: true, limit: '20mb' }));

	setupSwagger(app);

	setupFirebase(firebaseKeyFilePath);

	await app.listen(_PORT);
	console.log('Server start at port::', await app.getUrl());
}
bootstrap();
