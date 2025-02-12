import { _DEV, _PROD, _STAGING, _TEST } from '@/common/constants';
import { NODE_ENV } from '@/common/venv';

export const isTest = NODE_ENV === _TEST;
export const isStaging = NODE_ENV === _STAGING;
export const isDevelop = NODE_ENV === _DEV;
export const isProduction = NODE_ENV === _PROD;

export const getEnvFile = () => (isDevelop ? '.env.development' : '.env');
