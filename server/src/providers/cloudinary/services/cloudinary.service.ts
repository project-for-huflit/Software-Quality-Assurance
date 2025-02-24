import { Injectable } from '@nestjs/common';
import { UploadApiErrorResponse, UploadApiResponse, v2 } from 'cloudinary';
import toStream from 'buffer-to-stream';

@Injectable()
export class CloudinaryService {
	async uploadImage(
		file: Express.Multer.File,
	): Promise<UploadApiResponse | UploadApiErrorResponse> {
		return new Promise((resolve, reject) => {
			const upload = v2.uploader.upload_stream((error, result) => {
				if (!error && !result) 
					reject(new Error('Upload failed with no error response.'));
				if (error) 
					return reject(error);
				if (result) 
					resolve(result);
			});
			toStream(file.buffer).pipe(upload);
		});
	}
}
