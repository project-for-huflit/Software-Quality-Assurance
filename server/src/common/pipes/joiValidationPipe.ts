import {
	ArgumentMetadata,
	BadRequestException,
	PipeTransform,
} from '@nestjs/common';
import { Schema } from 'joi';

export class JoiValidationPipe implements PipeTransform {
	constructor(private schema: Schema) {}

	transform(value: unknown, metadata: ArgumentMetadata) {
		const { error, value: validatedValue } = this.schema.validate(value, {
			abortEarly: false,
		});

		if (error) {
			const errorMessages = error.details
				.map((detail) => detail.message)
				.join(', ');
			throw new BadRequestException(`Validation failed: ${errorMessages}`);
		}

		return validatedValue;
	}
}
