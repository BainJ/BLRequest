//
//  BLPassthroughRequest.m
//  JiYinSmart
//
//  Created by Bain on 2017/8/12.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import "BLPassthroughRequest.h"
#import "BLTransmissionPrivate.h"

@interface BLPassthroughRequest ()
{
    NSInteger _passthroughChecksum; //透传数据校验
    NSInteger _passthroughLength; //透传数据长度
    
    NSString *_finalPassthroughDataString; //透传数据长度
}

@end

@implementation BLPassthroughRequest

/// 请求数据域的第一字节
- (NSInteger)passthroughDataFieldFirstBuffer {
    return 0x00;
}

/// 透传类型: 搜索/控制
- (BLRequestCommandType)passthroughRequestCommandType {
    return BLCommandTypeSearch;
}

/// 透传协议版本
- (NSInteger)passthroughRequestProtocolVersion {
    return 0;
}

- (NSData *)passthroughDataFieldData {
    return nil;
}

- (NSDictionary *)finalRequestArgument {
    NSMutableDictionary * sendRequestArgument = [[self requestArgument] mutableCopy];
    if (!sendRequestArgument) {
        sendRequestArgument = [NSMutableDictionary dictionary];
    }
    
    _finalPassthroughDataString = [BLTransmissionUtils passthroughStringFromData:[self passthroughDataFieldData] protocolVersion:[self passthroughRequestProtocolVersion] commandType:[self passthroughRequestCommandType]];
    
    [sendRequestArgument setObject:@(9000) forKey:@"api_id"];
    [sendRequestArgument setObject:@"passthrough" forKey:@"command"];
    [sendRequestArgument setObject:@"string" forKey:@"format"];
    [sendRequestArgument setObject:SafeDicObj(self.mac) forKey:@"mac"];
    [sendRequestArgument setObject:SafeDicObj(_finalPassthroughDataString) forKey:@"data"];
    if ([self isTimerOperation]) {
        [sendRequestArgument setObject:@(1) forKey:@"timertask"];
    }
    return sendRequestArgument;
}

// 验证发送数据的格式是否正确
- (BOOL)requestArgumentValidatorWithError:(NSError * _Nullable __autoreleasing *)error {
    if (!self.mac) {
        *error = [NSError errorWithDomain:BLRequestValidationErrorDomain code:-1000 userInfo:@{NSLocalizedDescriptionKey : @"数据错误, mac 地址为空"}];
        return NO;
    }
    
    return YES;
}

// 验证收到的数据格式是否正确
- (BOOL)responseArgumentValidatorWithError:(NSError * _Nullable __autoreleasing *)error {
    if (!_responsePassthroughString) {
        *error = [NSError errorWithDomain:BLRequestValidationErrorDomain code:-1000 userInfo:@{NSLocalizedDescriptionKey : @"数据错误, 返回的数据中没有透传数据"}];
        return NO;
    }
    
    if (_responsePassthroughString.length < 24) {
        *error = [NSError errorWithDomain:BLRequestValidationErrorDomain code:-1000 userInfo:@{NSLocalizedDescriptionKey : @"数据错误, 返回的数据长度不够12个字节"}];
        return NO;
    }
    return YES;
}

- (void)handleRequestResultWithError:(NSError * _Nullable __autoreleasing *)error {
    _responsePassthroughString = [self.responseObject objectForKey:@"data"];
    
    if (![self responseArgumentValidatorWithError:error]) {
        return;
    }
    
    self.responsePassthroughData = [BLTransmissionUtils dataFromString:_responsePassthroughString];
}

@end
