//
//  BLRequest.h
//  JiYinSmart
//
//  Created by Bain on 2017/8/11.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const BLRequestValidationErrorDomain;

@interface BLRequest : NSObject

@property (nonatomic, strong, nullable) NSString *mac;

/// 命令
- (NSString *)requestCommand;

/// 命令 ID
- (NSInteger)requestApiId;

/// 是否是定时操作
- (BOOL)isTimerOperation;

/// 添加请求时的参数
- (NSDictionary *)requestArgument;

/// 请求失败时, 该值为 nil
@property (nonatomic, strong, nullable) NSError *error;

@property (nonatomic, assign) BOOL isSuccess;;

/// raw 类型的 response. 请求失败时, 该值为空.
@property (nonatomic, strong, readonly, nullable) NSData *responseData;

/// response 解析为字典类型
@property (nonatomic, strong, readonly, nullable) NSDictionary *responseObject;

// 发送请求
- (void)start;

// 验证发送数据的格式是否正确
- (BOOL)requestArgumentValidatorWithError:(NSError * _Nullable __autoreleasing *)error;

// 验证返回数据格式
- (BOOL)responseArgumentValidatorWithError:(NSError * _Nullable __autoreleasing *)error;


- (void)handleRequestResultWithError:(NSError * _Nullable __autoreleasing *)error;


@end

NS_ASSUME_NONNULL_END
