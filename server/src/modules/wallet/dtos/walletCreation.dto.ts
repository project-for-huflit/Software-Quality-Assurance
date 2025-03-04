import { TypeWallet } from '@/common/constants';
import { IsEnum, IsNumber, IsString } from 'class-validator';

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
    @IsNumber()
    amount: number;

    constructor(name: string, type: string, amount: number) {
        this.name = name;
        this.type = type;
        this.amount = amount;
    }
}