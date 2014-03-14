//
//  HysteriaPlayerManager.h
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/24.
//  Copyright (c) 2014年 saiday. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface HysteriaPlayerManager : NSObject

+ (instancetype)sharedInstance;
- (void)setupNewSourceGetter:(id)responseObject;

@end
