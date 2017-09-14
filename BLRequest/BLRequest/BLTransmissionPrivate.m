//
//  BLTransmissionPrivate.m
//  JiYinSmart
//
//  Created by Bain on 2017/8/12.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import "BLTransmissionPrivate.h"
#import "BLTransmissionConfig.h"

void BLLog(NSString *format, ...) {
#ifdef DEBUG
    if (![BLTransmissionConfig sharedConfig].debugLogEnabled) {
        return;
    }
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}

@implementation BLTransmissionUtils

+ (NSString *)stringFromData:(NSData *)data
{
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%02x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    
    return hexStr;
}

+ (NSData *)dataFromString:(NSString *)string
{
    //去除空格
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //长度不为偶数则报错
    if(string.length % 2 != 0){
        return nil;
    }
    
    NSMutableData *data = [[NSMutableData alloc] init];
    
    for(int i=0;i<string.length/2;i++){
        NSRange range = NSMakeRange(i*2, 2);
        NSString *subString = [string substringWithRange:range];
        const char *p = [subString UTF8String];
        char* str;
        long i = strtol(p, &str, 16);
        [data appendBytes:&i length:1];
    }
    
    return data;
}


@end

@implementation BLTransmissionUtils (Passthrough)

+ (NSString *)passthroughStringFromString:(NSString *)string protocolVersion:(NSInteger)protocolVersion commandType:(BLRequestCommandType)commandType {
    NSData * dataFromString = [self dataFromString:string];
    NSString * sendData = [self passthroughStringFromData:dataFromString protocolVersion:protocolVersion commandType:commandType];
    
    return sendData;
}

+ (NSString *)passthroughStringFromData:(NSData *)data protocolVersion:(NSInteger)protocolVersion commandType:(BLRequestCommandType)commandType {
    Byte bytes[256] = {0x00, };
    int index = 0;
    //帧头
    bytes[index++] = 0xA5;
    bytes[index++] = 0xA5;
    bytes[index++] = 0x5A;
    bytes[index++] = 0x5A;
    
    //校验
    bytes[index++] = 0x00;
    bytes[index++] = 0x00;
    
    //命令类型
    bytes[index++] = BYTE_0(commandType);
    bytes[index++] = BYTE_1(commandType);
    //命令长度
    bytes[index++] = BYTE_0(data.length);
    bytes[index++] = BYTE_1(data.length);
    //协议版本
    bytes[index++] = BYTE_0(protocolVersion);
    bytes[index++] = BYTE_1(protocolVersion);
    
    //数据区
    for (int i = 0; i < data.length; i++) {
        bytes[index++] = ((Byte *)(data.bytes))[i];
    }
    
    //计算校验和
    int checkSum = 0xbeaf;
    for (int i = 0; i < index; i++) {
        checkSum += bytes[i];
    }
    bytes[4] = BYTE_0(checkSum);
    bytes[5] = BYTE_1(checkSum);
    
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < index; i++) {
        [str appendFormat:@"%02X", bytes[i]];
    };
    return str;
}

@end
