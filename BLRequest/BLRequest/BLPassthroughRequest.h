//
//  BLPassthroughRequest.h
//  JiYinSmart
//
//  Created by Bain on 2017/8/12.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import "BLRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BLPassthroughRequest : BLRequest

@property (nonatomic, strong, nullable) NSString *responsePassthroughString;
@property (nonatomic, strong, nullable) NSData *responsePassthroughData;

/// 请求数据域的第一字节
- (NSInteger)passthroughDataFieldFirstBuffer;

/// 透传时的参数
- (NSData *)passthroughDataFieldData;

@end

NS_ASSUME_NONNULL_END
