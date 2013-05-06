//
//  IGSpecHelper.m
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGSpecHelper.h"

@implementation IGSpecHelper

+(NSData*) dataWithFixtureFile:(NSString*)filename type:(NSString*)type {
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    NSString* path = [bundle pathForResource:filename ofType:type];
    return [NSData dataWithContentsOfFile:path];
}

@end
