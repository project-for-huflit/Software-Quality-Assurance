import { TypeWallet } from '@/common/constants';
import { IsEnum, IsString } from 'class-validator';

export class WalletCreationDTO {
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

    constructor(name: string, type: string) {
        this.name = name;
        this.type = type;
    }
}