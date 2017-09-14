//
//  BLRequest.m
//  JiYinSmart
//
//  Created by Bain on 2017/8/11.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import "BLRequest.h"
#import "BLNetwork.h"
#import "BLTransmissionPrivate.h"

NSString *const BLRequestValidationErrorDomain = @"com.reewoow.request.validation";

@interface BLRequest ()

@property (nonatomic, strong, nullable) NSData *responseData;
@property (nonatomic, strong, nullable) NSDictionary *responseObject;

@end

@implementation BLRequest

//- (NSString *)requestCommand {
//    return nil;
//}
//
//- (NSInteger)requestApiId {
//    return 0;
//}

- (NSInteger)requestApiId
{
    return 10001;
}

- (NSString *)requestCommand
{
    return @"cancel_easyconfig";
}

- (BOOL)isTimerOperation {
    return NO;
}

- (NSDictionary *)requestArgument {
    return nil;
}

- (NSDictionary *)finalRequestArgument {
    NSMutableDictionary * sendRequestArgument = [[self requestArgument] mutableCopy];
    if (!sendRequestArgument) {
        sendRequestArgument = [NSMutableDictionary dictionary];
    }
    [sendRequestArgument setObject:@([self requestApiId]) forKey:@"api_id"];
    [sendRequestArgument setObject:SafeDicObj([self requestCommand]) forKey:@"command"];
    [sendRequestArgument setObject:SafeDicObj(self.mac) forKey:@"mac"];
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

// 验证发送数据的格式是否正确
- (BOOL)responseArgumentValidatorWithError:(NSError * _Nullable __autoreleasing *)error {
    return NO;
}

- (void)start {
    NSError * __autoreleasing requestArgumentValidatorError = nil;
    if (![self requestArgumentValidatorWithError:&requestArgumentValidatorError]) {
        self.error = requestArgumentValidatorError;
        return;
    }
    
    NSData *requestArgumentData = [NSJSONSerialization dataWithJSONObject:[self finalRequestArgument] options:0 error:NULL];
    self.responseData = [[BLNetwork sharedBLNetwork] requestDispatch:requestArgumentData];
    id responseObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:NULL];
    
    // 解析出来的数据必须为一个字典, 不是的话就报错退出
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        self.responseObject = (NSDictionary *)responseObject;
    } else {
        self.error = [NSError errorWithDomain:BLRequestValidationErrorDomain code:-1000 userInfo:@{NSLocalizedDescriptionKey : @"数据错误, 解析出的数据错误"}];
        return;
    }
    BLLog(@"BLRequest dispath %@ ==> %@", [self finalRequestArgument], self.responseObject);
    
    NSError * __autoreleasing responseParseError = nil;
    [self handleRequestResultWithError:&responseParseError];
    self.error = responseParseError;
}

- (void)handleRequestResultWithError:(NSError * _Nullable __autoreleasing *)error {
    
}

@end
