import { CloudinaryService } from "@/providers/cloudinary/services";
import { BadRequestException, Injectable } from "@nestjs/common";

@Injectable()
export class ImageService {
    constructor(private cloudinary: CloudinaryService) {}

    async uploadImageToCloudinary(file: Express.Multer.File) {
        return await this.cloudinary.uploadImage(file).catch(() => {
            throw new BadRequestException('Invalid file type.');
        })
    }
} 