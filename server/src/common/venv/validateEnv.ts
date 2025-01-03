import * as Joi from 'joi';

import { _DEV, _PROD, _STAGING, _TEST } from '../constants';

export const envSchema = Joi.object({
	NODE_ENV: Joi.string().valid(_DEV, _PROD, _TEST, _STAGING).default(_DEV),
	_PORT: Joi.number().default(3000),
});
