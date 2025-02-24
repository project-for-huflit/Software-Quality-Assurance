import { CloudinaryService } from "@/providers/cloudinary/services";
import { BadRequestException, Injectable } from "@nestjs/common";

@Injectable()
export class ImageService {
    constructor(private cloudinary: CloudinaryService) {}

    async uploadImageToCloudinary(file: Express.Multer.File) {
        console.log('🚀 Uploading file:', file.mimetype, file.path); // Debug

        if (!file || !file.buffer) {
            throw new BadRequestException('No file uploaded or file is empty');
        }
        
        try {
          const result = await this.cloudinary.uploadImage(file);
          console.log('✅ Cloudinary Response:', result);
          return result;
        } catch (error) {
          console.error('❌ Cloudinary Upload Error:', error);
          throw new BadRequestException('Cloudinary upload failed');
        }
    }
} 