//
//  ViewController.m
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/4.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import "ViewController.h"
#import "PlayingItems.h"
#import "Song.h"
#import <HysteriaPlayer.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupHyseteriaPlayer];
}

- (void)setupHyseteriaPlayer
{
    HysteriaPlayer *hysteriaPlayer = [HysteriaPlayer sharedInstance];
    
    [hysteriaPlayer registerHandlerPlayerRateChanged:^{
        
    } CurrentItemChanged:^(AVPlayerItem *item) {
        
    } PlayerDidReachEnd:^{
        
    }];
    
    [hysteriaPlayer registerHandlerCurrentItemPreLoaded:^(CMTime time) {
        NSLog(@"%f", CMTimeGetSeconds(time));
    }];
    
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
    
    [hysteriaPlayer setPlayerRepeatMode:RepeatMode_off];
    [hysteriaPlayer enableMemoryCached:NO];
}

- (void)setupNewSourceGetter:(id)responseObject
{
    PlayingItems *playingItems = [PlayingItems sharedInstance];
    [playingItems setQueueItems:[NSMutableArray array]];
    
    NSArray *JSONData = [responseObject objectForKey:@"results"];
    for (NSDictionary *songData in JSONData) {
        Song *object = [Song initWithData:songData];
        if (object) {
            [[playingItems queueItems] addObject:object];
        }
    }
    
    [[HysteriaPlayer sharedInstance] setupSourceGetter:^NSString *(NSUInteger index) {
        Song *object = [[playingItems queueItems] objectAtIndex:index];
        return object.source;
    } ItemsCount:[[playingItems queueItems] count]];
    
    // play
    [[HysteriaPlayer sharedInstance] fetchAndPlayPlayerItem:0];
}

- (void)getPreviews:(NSString *)itunesAPI
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:itunesAPI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setupNewSourceGetter:responseObject];
        
    } failure:nil];
}

- (IBAction)PreviewU2:(id)sender
{
    NSString *itunesAPIU2 = @"https://itunes.apple.com/lookup?amgArtistId=5723&entity=song&limit=5&sort=recent";
    
    [self getPreviews:itunesAPIU2];
}

- (IBAction)previewJackJohnson:(id)sender
{
    NSString *itunesAPIJackJohnson = @"https://itunes.apple.com/lookup?amgArtistId=468749&entity=song&limit=5&sort=recent";
    
    [self getPreviews:itunesAPIJackJohnson];
}

@end
