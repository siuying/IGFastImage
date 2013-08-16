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

struct FastImageBmpSize
{
    uint32_t width;
    uint32_t height;
};

struct FastImageJpgSize
{
    uint16_t height;
    uint16_t width;
};

struct FastImageJpgSkip
{
    uint16_t length;
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


+(CGSize) parseSizeWithData:(NSData*)data {
    switch ([self parseTypeWithData:data]) {
        case IGFastImageTypeBMP:
            return [self parseSizeForBmpWithData:data];
            break;
        case IGFastImageTypeJPEG:
            return [self parseSizeForJpegWithData:data];
            break;
        case IGFastImageTypePNG:
            return [self parseSizeForPngWithData:data];
            break;
        case IGFastImageTypeGIF:
            return [self parseSizeForGifWithData:data];
            break;            
        default:
            return CGSizeZero;
    }
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

+(CGSize) parseSizeForJpegWithData:(NSData*)data {
    IGFastImageJPGParseState state = IGFastImageJPGParseStateBegin;
    NSUInteger offset = 0U;

    while (true) {
        if ([data length] <= offset) {
            return CGSizeZero;
        }

        switch (state) {
            case IGFastImageJPGParseStateBegin:
            {
                if ([data length] < 2) {
                    return CGSizeZero;
                }

                offset += 2U;
                state = IGFastImageJPGParseStateStarted;
            }
            break;
            
            case IGFastImageJPGParseStateStarted:
            {
                if ([data length] <= offset+1) {
                    return CGSizeZero;
                }

                unsigned char buff[1];
                [data getBytes:buff range:NSMakeRange(offset++, 1)];
                if (buff[0] == 0xFF) {
                    state = IGFastImageJPGParseStateSof;
                } else {
                    state = IGFastImageJPGParseStateStarted;
                }
            }
            break;
            
            case IGFastImageJPGParseStateSof:
            {
                if ([data length] <= offset+1) {
                    return CGSizeZero;
                }

                unsigned char buff[1];
                [data getBytes:buff range:NSMakeRange(offset++, 1)];
                
                if (buff[0] >= 0xE0 && buff[0] <= 0xEF) {
                    state = IGFastImageJPGParseStateSkipFrame;
                } else if ((buff[0] >= 0xC0 && buff[0] <= 0xC3) ||
                           (buff[0] >= 0xC5 && buff[0] <= 0xC7) ||
                           (buff[0] >= 0xC9 && buff[0] <= 0xCB) ||
                           (buff[0] >= 0xCD && buff[0] <= 0xCF)) {
                    state = IGFastImageJPGParseStateReadSize;
                } else if (buff[0] == 0xFF) {
                    state = IGFastImageJPGParseStateSof;
                } else if (buff[0] == 0xD9) {
                    // EOI marker
                    return CGSizeZero;
                } else {
                    state = IGFastImageJPGParseStateSkipFrame;
                }
            }
            break;

            case IGFastImageJPGParseStateSkipFrame:
            {
                if ([data length] <= offset+2) {
                    return CGSizeZero;
                }

                unsigned char buff[2];
                [data getBytes:buff range:NSMakeRange(offset++, 2)];
                
                const struct FastImageJpgSkip* skip = (const struct FastImageJpgSkip*) buff;
                offset += (CFSwapInt16BigToHost(skip->length) - 2);
                state = IGFastImageJPGParseStateStarted;
            }
            break;
                
            case IGFastImageJPGParseStateReadSize:
            {
                if ([data length] <= offset+7) {
                    return CGSizeZero;
                }

                unsigned char buff[7];
                [data getBytes:buff range:NSMakeRange(offset+3, 4)];
                
                const struct FastImageJpgSize* size = (const struct FastImageJpgSize*) buff;
                return CGSizeMake(CFSwapInt16BigToHost(size->width), CFSwapInt16BigToHost(size->height));
            }
            break;
        }
    }
    return CGSizeZero;
}

+(CGSize) parseSizeForBmpWithData:(NSData*)data {
    if ([data length] < 29) {
        return CGSizeZero;
    }

    unsigned char buff[8];
    [data getBytes:buff range:NSMakeRange(18, 8)];

    const struct FastImageBmpSize* size = (const struct FastImageBmpSize*) buff;
    return CGSizeMake(size->width, size->height);
}

@end
