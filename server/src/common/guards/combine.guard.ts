import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { ThrottlerGuard } from '@nestjs/throttler';

import { RolesGuard } from './role.guard';

@Injectable()
export class CombinedGuard implements CanActivate {
	constructor(
		private readonly rolesGuard: RolesGuard,
		private readonly throttlerGuard: ThrottlerGuard,
	) {}

	async canActivate(context: ExecutionContext): Promise<boolean> {
		const rolesResult = await this.rolesGuard.canActivate(context);
		const throttlerResult = await this.throttlerGuard.canActivate(context);

		return rolesResult && throttlerResult;
	}
}
