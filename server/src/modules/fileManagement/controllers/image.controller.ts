import {
    Controller,
    Post,
    UploadedFile,
    UseInterceptors,
  } from '@nestjs/common';
  import { FileInterceptor } from '@nestjs/platform-express';
import { ImageService } from '../services';
import { multerOptions } from '@/common/configs';

@Controller('upload')
export class ImageController {
    constructor(private readonly imageService: ImageService) {}

    @Post('/image')
    @UseInterceptors(FileInterceptor(
        'image',
        // multerOptions
    ))
    uploadImage(@UploadedFile() file: Express.Multer.File) {
      return this.imageService.uploadImageToCloudinary(file);
    }
}