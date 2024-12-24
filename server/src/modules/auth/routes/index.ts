import express from 'express';

const authController = require('../controllers/account.controller')
const asyncHandler = require('../../../middlewares/asyncHandler.middeware')
const { authenticationUser } = require('../../../services/auth/utils')

export const routerAccount = express.Router();

