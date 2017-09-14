//
//  BLTransmissionPrivate.h
//  JiYinSmart
//
//  Created by Bain on 2017/8/12.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT void BLLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);


#define BYTE_0(x) ((Byte)(x))
#define BYTE_1(x) BYTE_0((x)>>8)
#define BYTE_2(x) BYTE_0((x)>>16)
#define BYTE_3(x) BYTE_0((x)>>24)

typedef NS_ENUM(NSUInteger, BLRequestCommandType) {
    BLCommandTypeSearch = 0x0b01,
    BLCommandTypeControl = 0x0b02,
};

// 正常模式为：0x01；夜间模式为：0x02
typedef NS_ENUM(NSUInteger, BLRequestNightMode) {
    BLNightModeNone = 0x00,
    BLNightModeDay = 0x01,
    BLNightModeNight = 0x02,
};

//排插开关位置
typedef NS_ENUM(NSUInteger, BLRequestJackIndex) {
    BLSocketOutletIndex1 = 1 << 0,
    BLSocketOutletIndex2 = 1 << 1,
    BLSocketOutletIndex3 = 1 << 2,
    BLSocketOutletIndex4 = 1 << 3,
    BLSocketOutletIndex5 = 1 << 4,
    BLSocketOutletIndex6 = 1 << 5,
    BLSocketOutletIndexALL = 0x3F,
};

@interface BLTransmissionUtils : NSObject

+ (NSString *)stringFromData:(NSData *)data;
+ (NSData *)dataFromString:(NSString *)string;

@end

@interface BLTransmissionUtils (Passthrough)

+ (NSString *)passthroughStringFromString:(NSString *)string protocolVersion:(NSInteger)protocolVersion commandType:(BLRequestCommandType)commandType;
+ (NSString *)passthroughStringFromData:(NSData *)data protocolVersion:(NSInteger)protocolVersion commandType:(BLRequestCommandType)commandType;

@end

NS_ASSUME_NONNULL_END
