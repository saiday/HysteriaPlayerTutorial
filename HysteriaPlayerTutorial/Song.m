//
//  Song.m
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/5.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import "Song.h"

@implementation Song

+ (instancetype)initWithData:(id)data
{
    Song *object = [[Song alloc] init];
    
    object.title = [data objectForKey:@"trackName"];
    object.artist = [data objectForKey:@"artistName"];
    object.album = [data objectForKey:@"collectionName"];
    object.source = [data objectForKey:@"previewUrl"];
    object.artworkURL = [data objectForKey:@"artworkUrl100"];
    
    return object.source ? object : nil;
}

@end
