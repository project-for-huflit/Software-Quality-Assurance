import {
    Controller,
    Post,
    UploadedFile,
    UseInterceptors,
  } from '@nestjs/common';
  import { FileInterceptor } from '@nestjs/platform-express';
import { ImageService } from '../services';

@Controller('upload')
export class ImageController {
    constructor(private readonly imageService: ImageService) {}

    @Post('/image')
    @UseInterceptors(FileInterceptor(
        'file'
    ))
    uploadImage(@UploadedFile() file: Express.Multer.File) {
      return this.imageService.uploadImageToCloudinary(file);
    }
}