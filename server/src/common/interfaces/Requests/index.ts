import { NextFunction, Request, Response } from 'express';

export interface IRequest {
	req: Request;
	res: Response;
	next: NextFunction;
}
