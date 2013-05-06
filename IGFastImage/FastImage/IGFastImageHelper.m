//
//  IGFastImageHelper.m
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGFastImageHelper.h"

struct FastImageGifSize
{
    uint16_t width;
    uint16_t height;
};

struct FastImagePngSize
{
    uint32_t width;
    uint32_t height;
};

@implementation IGFastImageHelper

+(IGFastImageType) parseTypeWithData:(NSData*)data {
    if ([data length] < 2) {
        return IGFastImageTypeUnknown;
    }
    
    unsigned char buff[2];
    [data getBytes:buff length:2];
    
    if (buff[0] == 0xFF && buff[1] == 0xD8) {
        return IGFastImageTypeJPEG;
    }
    
    if (buff[0] == 0x89 && buff[1] == 'P') {
        return IGFastImageTypePNG;
    }
    
    if (buff[0] == 'G' && buff[1] == 'I') {
        return IGFastImageTypeGIF;
    }
    
    if (buff[0] == 'B' && buff[1] == 'M') {
        return IGFastImageTypeBMP;
    }
    
    return IGFastImageTypeUnknown;
}

+(CGSize) parseSizeForGifWithData:(NSData*)data {
    if ([data length] < 11) {
        return CGSizeZero;
    }
    
    unsigned char buff[4];
    [data getBytes:buff range:NSMakeRange(6, 4)];
    
    const struct FastImageGifSize* size = (const struct FastImageGifSize*) buff;
    return CGSizeMake(size->width, size->height);
}

+(CGSize) parseSizeForPngWithData:(NSData*)data {
    if ([data length] < 25) {
        return CGSizeZero;
    }
    
    unsigned char buff[8];
    [data getBytes:buff range:NSMakeRange(16, 8)];
    
    const struct FastImagePngSize* size = (const struct FastImagePngSize*) buff;
    return CGSizeMake(CFSwapInt32BigToHost(size->width), CFSwapInt32BigToHost(size->height));
}

@end
