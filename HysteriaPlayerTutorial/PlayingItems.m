//
//  PlayingItems.m
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/5.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import "PlayingItems.h"
#import "Song.h"
#import <HysteriaPlayer.h>

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

- (Song *)getCurrentSong
{
    Song *item = nil;
    
    if (self.queueItems.count) {
        HysteriaPlayer *hysteriaPlayer = [HysteriaPlayer sharedInstance];
        NSUInteger index = [[hysteriaPlayer getHysteriaOrder:[hysteriaPlayer getCurrentItem]] integerValue];
        item = (Song *)[self.queueItems objectAtIndex:index];
    }
    
    return item;
}

@end
