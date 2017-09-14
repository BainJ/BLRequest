//
//  BLTestApi.h
//  JiYinSmart
//
//  Created by Bain on 2017/8/15.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import "BLPassthroughRequest.h"
#import "BLTransmissionPrivate.h"

@interface BLTestApi : BLPassthroughRequest

@property (nonatomic, assign) BLRequestNightMode responseNightMode;
@property (nonatomic, assign) BLRequestJackIndex responseSwitchAction;
@property (nonatomic, assign) BLRequestJackIndex responseSwitchEnable;

- (id)initWithActionIndex:(NSInteger)actionIndex;

@end
