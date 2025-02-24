import { fileFilter, storage } from '../utils';
import { Request } from 'express';

export const multerOptions = {
  storage: storage,
  fileFilter: fileFilter
};