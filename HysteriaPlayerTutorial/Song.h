//
//  Song.h
//  HysteriaPlayerTutorial
//
//  Created by MingSheng Tsai on 2014/2/5.
//  Copyright (c) 2014年 saiday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *artworkURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *album;

+ (instancetype)initWithData:(id)data;

@end
