import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

import { _PORT } from '../venv';

export const corsOptions: CorsOptions = {
  origin: [`http://localhost:${_PORT}`, `http://10.0.2.2:${_PORT}`, `http://10.0.2.2:5554`],
	// origin: [
	// 	'*'
	// ],
	methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS', 'HEAD'],
	credentials: true,
};
