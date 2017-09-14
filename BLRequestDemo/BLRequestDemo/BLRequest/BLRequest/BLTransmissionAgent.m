//
//  BLTransmissionAgent.m
//  JiYinSmart
//
//  Created by Bain on 2017/8/12.
//  Copyright © 2017年 Reewoow. All rights reserved.
//

#import "BLTransmissionAgent.h"
#import "BLRequest.h"

@interface BLTransmissionAgent ()

{
    NSMutableDictionary<NSNumber *, BLRequest *> *_requestsRecord;
    
    dispatch_queue_t _processingQueue;
    pthread_mutex_t _lock;
    NSIndexSet *_allStatusCodes;
}


@end

@implementation BLTransmissionAgent

+ (BLTransmissionAgent *)sharedAgent {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


@end
