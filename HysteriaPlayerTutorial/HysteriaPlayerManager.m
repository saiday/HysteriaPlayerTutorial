//
//  HysteriaPlayerManager.m
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/24.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import "HysteriaPlayerManager.h"

#import "PlayingItems.h"
#import "Song.h"
#import <HysteriaPlayer.h>

@implementation HysteriaPlayerManager

static HysteriaPlayerManager *_sharedInstance = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupHysteriaPlayer];
    }
    
    return self;
}

- (void)setupHysteriaPlayer
{
    HysteriaPlayer *hysteriaPlayer = [HysteriaPlayer sharedInstance];
    
    [hysteriaPlayer registerHandlerReadyToPlay:^(HysteriaPlayerReadyToPlay identifier) {
        switch (identifier) {
            case HysteriaPlayerReadyToPlayCurrentItem:
                if ([hysteriaPlayer getHysteriaPlayerStatus] != HysteriaPlayerStatusForcePause) {
                    [hysteriaPlayer play];
                }
                break;
            case HysteriaPlayerReadyToPlayPlayer:
                [hysteriaPlayer play];
                break;
                
            default:
                break;
        }
    }];
    
    [hysteriaPlayer registerHandlerFailed:^(HysteriaPlayerFailed identifier, NSError *error) {
        switch (identifier) {
            case HysteriaPlayerFailedCurrentItem:
                break;
                
            default:
                break;
        }
    }];
    
    [hysteriaPlayer setPlayerRepeatMode:HysteriaPlayerRepeatModeOff];
    [hysteriaPlayer enableMemoryCached:NO];
}

- (void)setupNewSourceGetter:(id)responseObject
{
    /*------------------------------*/
    // response format: https://itunes.apple.com/lookup?amgArtistId=5723&entity=song&limit=5&sort=recent
    /*------------------------------*/
    
    PlayingItems *playingItems = [PlayingItems sharedInstance];
    [playingItems setQueueItems:[NSMutableArray array]];
    
    NSArray *JSONData = [responseObject objectForKey:@"results"];
    for (NSDictionary *songData in JSONData) {
        Song *object = [Song initWithData:songData];
        if (object) {
            [[playingItems queueItems] addObject:object];
        }
    }
    
    [[HysteriaPlayer sharedInstance] setupSourceGetter:^NSURL *(NSUInteger index) {
        Song *object = [[playingItems queueItems] objectAtIndex:index];
        NSURL *url = [NSURL URLWithString:object.source];
        return url;
    } ItemsCount:[[playingItems queueItems] count]];
    
    // play
    [[HysteriaPlayer sharedInstance] fetchAndPlayPlayerItem:0];
}


@end
