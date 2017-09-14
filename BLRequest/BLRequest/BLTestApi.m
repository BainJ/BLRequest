//
//  BLTestApi.m
//  JiYinSmart
//
//  Created by Bain on 2017/8/15.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import "BLTestApi.h"


@implementation BLTestApi {
    BLRequestNightMode _nightMode;
    BLRequestJackIndex _switchActionIndex;
    BLRequestJackIndex _switchEnableIndex;
}

- (id)initWithActionIndex:(NSInteger)actionIndex {
    self = [super init];
    if (self) {
        _switchActionIndex = actionIndex;
        _switchEnableIndex = actionIndex;
        _nightMode = BLNightModeNone;
    }
    return self;
}

/// 请求数据域的第一字节
- (NSInteger)passthroughDataFieldFirstBuffer {
    return 0x01;
}

- (NSString *)passthroughDataFieldString {
    Byte dataBytes[] = {[self passthroughDataFieldFirstBuffer], _nightMode, _switchEnableIndex, _switchActionIndex};
    NSData *data = [NSData dataWithBytes:dataBytes length:sizeof(dataBytes)];
    NSString *dataString = [BLTransmissionUtils stringFromData:data];
    return dataString;
}

@end
