//
//  IGFastImage.m
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGFastImage.h"
#import "IGFastImageHelper.h"
#import "IGFastImageRequestOperation.h"

#define kLocalFileChunkSize 256

@implementation IGFastImage

-(id) initWithURLString:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

-(id) initWithURL:(NSURL*)url {
    self = [super init];
    if (self) {
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        self.operation = [[IGFastImageRequestOperation alloc] initWithRequest:request];
        [self.operation start];
    }
    return self;
}

-(IGFastImageType) type {
    return self.operation.type;
}

-(CGSize) size {
    return self.operation.size;
}

@end
