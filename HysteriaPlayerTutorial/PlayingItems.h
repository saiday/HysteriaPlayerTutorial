//
//  PlayingItems.h
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/5.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayingItems : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSMutableArray *queueItems;

@end
