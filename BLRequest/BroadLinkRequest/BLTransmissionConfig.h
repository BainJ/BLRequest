//
//  BLTransmissionConfig.h
//  JiYinSmart
//
//  Created by Bain on 2017/8/12.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLTransmissionConfig : NSObject

+ (BLTransmissionConfig *)sharedConfig;

@property (nonatomic) BOOL debugLogEnabled;

@end
