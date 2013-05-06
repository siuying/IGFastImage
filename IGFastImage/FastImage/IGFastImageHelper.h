//
//  IGFastImageHelper.h
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGFastImage.h"

@interface IGFastImageHelper : NSObject

+(IGFastImageType) parseTypeWithData:(NSData*)data;
+(CGSize) parseSizeForGifWithData:(NSData*)data;
+(CGSize) parseSizeForPngWithData:(NSData*)data;

@end
