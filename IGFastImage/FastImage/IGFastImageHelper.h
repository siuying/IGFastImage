//
//  IGFastImageHelper.h
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGFastImage.h"

typedef enum {
    IGFastImageJPGParseStateBegin             = 0,
    IGFastImageJPGParseStateStarted           = 1,
    IGFastImageJPGParseStateSof               = 2,
    IGFastImageJPGParseStateSkipFrame         = 3,
    IGFastImageJPGParseStateReadSize          = 4
} IGFastImageJPGParseState;

@interface IGFastImageHelper : NSObject

+(IGFastImageType) parseTypeWithData:(NSData*)data;

+(CGSize) parseSizeWithData:(NSData*)data;

+(CGSize) parseSizeForGifWithData:(NSData*)data;
+(CGSize) parseSizeForPngWithData:(NSData*)data;
+(CGSize) parseSizeForJpegWithData:(NSData*)data;
+(CGSize) parseSizeForBmpWithData:(NSData*)data;

@end
