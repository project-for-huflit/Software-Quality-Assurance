import { BadRequestException } from '@nestjs/common';
import { diskStorage } from 'multer';
import { extname } from 'path';

export const storage = diskStorage({
	destination: './uploads',
	filename: (_, file, cb) => {
		const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1e9)}`;
		cb(null, `${uniqueSuffix}${extname(file.originalname)}`);
	},
});

export const fileFilter =  (
	_req: Request, 
	file: Express.Multer.File, 
	cb: (error: Error | null, acceptFile: boolean) => void
) => {
	// console.log('File type received:', file.mimetype); // Debug

	if (!file.mimetype.match(/\/(jpg|jpeg|png)$/)) {
		console.log('❌ Invalid file type:', file.mimetype);
	    return cb(new BadRequestException('Invalid file type. Only JPG, JPEG, PNG, and GIF are allowed!'), false);
	}
	// console.log('✅ File accepted:', file.originalname);
	cb(null, true);
};
