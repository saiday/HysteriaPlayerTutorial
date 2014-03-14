//
//  PlayerViewController.m
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/24.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import "PlayerViewController.h"

#import <SpinningDiskView.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <HysteriaPlayer.h>

#import "Song.h"
#import "PlayingItems.h"

@interface PlayerViewController ()

@property (weak, nonatomic) IBOutlet SpinningDiskView *spinningDiskView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) UIButton *playButton;

- (IBAction)close:(id)sender;

@end

@implementation PlayerViewController
@synthesize playButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCustomView];
    [self updateCurrentItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)initCustomView
{
    UIBarButtonItem *flexable = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [playButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *playButtonItem = [[UIBarButtonItem alloc] initWithCustomView:playButton];
    self.toolbar.items = @[flexable, playButtonItem,flexable];
}

- (void)updateCurrentItem
{
    Song *currentItem = [[PlayingItems sharedInstance] getCurrentSong];
    [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:currentItem.artworkURL] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        [self.spinningDiskView setImage:image];
    }];
    
    [self.spinningDiskView toggleRotation];
    [playButton setSelected:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonTapped:(id)sender
{
    NSLog(@"hi");
    if ([[HysteriaPlayer sharedInstance] isPlaying]) {
        [[HysteriaPlayer sharedInstance] pause];
        [playButton setSelected:NO];
        [self.spinningDiskView stopRotation];
    } else {
        [[HysteriaPlayer sharedInstance] play];
        [playButton setSelected:YES];
        [self.spinningDiskView startRotation];
    }
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
