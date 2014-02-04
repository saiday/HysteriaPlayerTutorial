//
//  PlayingItems.m
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/5.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import "PlayingItems.h"

@implementation PlayingItems

+ (instancetype)sharedInstance
{
    static PlayingItems *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

@end
