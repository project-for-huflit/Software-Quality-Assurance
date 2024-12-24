import { IRequest } from '@/common/interfaces/Requests';
import { 
    authService, 
    SSOService 
} from '../services';

import {
    CREATED,
    SuccessResponse,
  } from '@/common/core'
import { IHandlerRefreshToken, THandlerRefreshToken } from '../types';

export class AuthController {
    //region JWT
    register = async ({ req, res } : IRequest) => {
      new CREATED({
        message: 'Register OK!',
        metadata: await authService.register(req.body),
        option: {}
      }).send(res);
    };
  
    login = async ({req, res} : IRequest) => {
      new SuccessResponse({
        metadata: await authService.login(req.body),
      }).send(res);
    };
  
    logout = async ({req, res} : IRequest) => {
      const { keyStore } = req;
      new SuccessResponse({
        message: 'Logout success!',
        metadata: await authService.logout(keyStore),
      }).send(res);
    };
    handlerRefreshTokenUser = async ({req, res} : IRequest) => {
      const {
        refreshToken,
        user,
        keyStore
      } = req;
      new SuccessResponse({
        message: 'Get token success!',
        metadata: await authService.handleRefreshToken({
          refreshToken: refreshToken,
          user: user,
          keyStore: keyStore,
        }),
      }).send(res);
    };
    // region POINTER SERVICE
  
    loginPartner = async ({req, res} : IRequest) => {
      new SuccessResponse({
        metadata: await SSOService.login(req.body),
      }).send(res);
    };
    loginPointer = async ({req, res} : IRequest) => {
      new SuccessResponse({
        message: ' success!',
        metadata: await SSOService.loginWithPointer(req.body),
      }).send(res);
    };
  
    logoutPointer = async ({req, res} : IRequest) => {
      const { keyStore } = req;
      new SuccessResponse({
        message: 'Logout with partner success!',
        metadata: await SSOService.logout(keyStore),
      }).send(res);
    };
  
    registerPointer = async ({req, res} : IRequest) => {
      new CREATED({
        message: 'Register with pointer OK!',
        metadata: await SSOService.register(req.body),
        option: {}
      }).send(res);
    };
  
    handlerRefreshTokenPointer = async ({req, res} : IRequest) => {
        const {
          refreshToken,
          user,
          keyStore
        } = req;
      new SuccessResponse({
        message: 'Get token success!',
        metadata: await SSOService.handleRefreshToken({
          refreshToken: refreshToken,
          user: user,
          keyStore: keyStore,
        }),
      }).send(res);
    };
}
  