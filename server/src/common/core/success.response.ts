'use strict';

import { Response } from 'express';

import { ICreated, IOK, ISuccessResponse } from '../interfaces';
import { ReasonPhrases, StatusCodes } from '../utils/httpStatusCode';

class SuccessResponse {
	message: string;
	status: number;
	metadata: object;

	constructor({
		message,
		status = StatusCodes.OK,
		reasonStatusCode = ReasonPhrases.OK,
		metadata = {},
	}: ISuccessResponse) {
		// eslint-disable-next-line @typescript-eslint/no-unused-expressions
		(this.message = message ?? reasonStatusCode), (this.status = status);
		this.metadata = metadata;
	}
	send(res: Response, headers: object = {}) {
		return res.status(this.status).json(this);
	}
}

class OK extends SuccessResponse {
	constructor({ message, metadata }: IOK) {
		super({ message, metadata });
	}
}

class CREATED extends SuccessResponse {
	option?: object;

	constructor({
		message,
		status = StatusCodes.CREATED,
		reasonStatusCode = ReasonPhrases.CREATED,
		metadata,
		option = {},
	}: ICreated) {
		super({ message, status, reasonStatusCode, metadata });
		this.option = option;
	}
}

export { CREATED, OK, SuccessResponse };
