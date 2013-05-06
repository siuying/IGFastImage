//
//  IGFastImageURLConnectionOperation.m
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGFastImageURLConnectionOperation.h"
#import "IGFastImageHelper.h"

@implementation IGFastImageURLConnectionOperation

-(id) initWithURL:(NSURL*)url {
    self = [super initWithRequest:[NSURLRequest requestWithURL:url]];
    if (self) {
        [self setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
        }];
    }
    return self;
}

@end