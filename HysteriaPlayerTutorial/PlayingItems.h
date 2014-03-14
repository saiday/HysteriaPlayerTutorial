//
//  PlayingItems.h
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/5.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Song;

@interface PlayingItems : NSObject

+ (instancetype)sharedInstance;

- (Song *)getCurrentSong;

@property (nonatomic, strong) NSMutableArray *queueItems;

@end
