import { TypeWallet } from '@/common/constants';
import { IsBoolean, IsEnum, IsString } from 'class-validator';

export class WalletCreationDTO {
    // @IsString()
    // id: string;
    @IsString()
    name: string;
    @IsString()
    @IsEnum(
        TypeWallet,
        {
            message: 'Not found in enum TypeWallet!'
        }
    )
    type: string | null;
    @IsBoolean()
    isPublished: boolean;

    constructor(name: string, type: string, isPublished: boolean) {
        // this.id = id;
        this.name = name;
        this.type = type;
        this.isPublished = isPublished;
    }
}