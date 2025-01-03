import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

import { _PORT } from '../venv';

export const corsOptions: CorsOptions = {
	origin: [`http://localhost:${_PORT}`],
	methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
	credentials: true,
};
