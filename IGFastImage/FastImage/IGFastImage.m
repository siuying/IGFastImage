//
//  IGFastImage.m
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGFastImage.h"
#import "IGFastImageHelper.h"

#define kLocalFileChunkSize 256

@implementation IGFastImage

-(id) initWithURLString:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

-(id) initWithURL:(NSURL*)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

-(id) initWithFile:(NSString*)file {
    self = [super init];
    if (self) {
        self.responseData = [NSData dataWithContentsOfFile:file];
    }
    return self;
}

-(IGFastImageType) parseType {
    return [IGFastImageHelper parseTypeWithData:self.responseData];
}

@end
