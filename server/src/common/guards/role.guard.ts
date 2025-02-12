import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';

import { ROLES_KEY } from '../decorators/roles.decorator';
import { Role } from '../enum';

function matchRoles(requiredRoles: Role[], user: any): boolean {
	return requiredRoles.some((role) => user.roles?.includes(role));
}

/**
 * @LOQ-burh
 * @default global
 */
@Injectable()
export class RolesGuard implements CanActivate {
	constructor(private reflector: Reflector) {}

	canActivate(context: ExecutionContext): boolean {
		const roles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
			context.getHandler(),
			context.getClass(),
		]);

		if (!roles) {
			return true;
		}
		const request = context.switchToHttp().getRequest();
		const user = request.user;

		return matchRoles(roles, user.roles);
	}
}

/**
 * @LOQ-burh
 * @description Only users with the <role> role should be allowed to access this route.
 */
export const RolesChoose = Reflector.createDecorator<string[]>();
