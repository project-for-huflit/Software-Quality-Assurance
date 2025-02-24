import { Module } from '@nestjs/common';

import { ImageController } from './controllers';
import { ImageService } from './services';
import { CloudinaryModule } from '@/providers/cloudinary';

@Module({
	imports: [CloudinaryModule],
	controllers: [ImageController],
	providers: [ImageService],
	exports: [ImageService],
})
export class FileManagementModule {}
