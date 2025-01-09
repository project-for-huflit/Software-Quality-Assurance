import { INestApplication } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

/**
 * @description Documents swagger
 * @param app Main server
 */
export function setupSwagger(app: INestApplication<any>) {
	const configSwagger = new DocumentBuilder()
		.setTitle('User authentication')
		.setDescription('API detail for user authen')
		.setVersion('1')
		.addTag('Authentication')
		.addBearerAuth()
		.build();

	const document = SwaggerModule.createDocument(app, configSwagger);
	SwaggerModule.setup('api', app, document);
}
