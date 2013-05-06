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

static NSOperationQueue* _sharedQueue;

@implementation IGFastImage

+(NSOperationQueue*) sharedQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedQueue = [[NSOperationQueue alloc] init];
    });
    return _sharedQueue;
}

-(id) initWithURLString:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

-(id) initWithURL:(NSURL*)url {
    self = [super init];
    if (self) {
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        self.operation = [[IGFastImageRequestOperation alloc] initWithRequest:request];
        [[IGFastImage sharedQueue] addOperation:self.operation];
    }
    return self;
}

-(IGFastImageType) type {
    [self.operation waitUntilFinished];
    return self.operation.type;
}

-(CGSize) size {
    [self.operation waitUntilFinished];
    return self.operation.size;
}

@end
