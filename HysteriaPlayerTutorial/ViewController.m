//
//  ViewController.m
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/4.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import "ViewController.h"
#import "HysteriaPlayerManager.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)getPreviews:(NSString *)itunesAPI
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:itunesAPI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[HysteriaPlayerManager sharedInstance] setupNewSourceGetter:responseObject];
        
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
