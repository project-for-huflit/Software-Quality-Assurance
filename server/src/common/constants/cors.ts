import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

import { _PORT } from '../venv';

export const corsOptions: CorsOptions = {
	origin: [
		'*'
	],
	methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS', 'HEAD'],
	credentials: true,
};
