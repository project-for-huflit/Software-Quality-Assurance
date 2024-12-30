import { NestFactory } from '@nestjs/core';
import { ExpressAdapter } from '@nestjs/platform-express';
import { AppModule } from './app.module';

import * as functions from 'firebase-functions';

import * as express from 'express';

const server = express();

export const createNestServer = async (expressInstance: express.Express) => {
	const app = await NestFactory.create(
		AppModule,
		new ExpressAdapter(expressInstance),
	);
	return app.init();
};

createNestServer(server)
	.then(() => console.log('nest start'))
	.catch((err) => console.error('Nest broken', err));

export const api = functions.https.onRequest(server);
