//
//  IGFastImage.h
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IGFastImageTypeUnknown      = 0,
    IGFastImageTypeBMP          = 1,
    IGFastImageTypeGIF          = 2,
    IGFastImageTypeJPEG         = 3,
    IGFastImageTypePNG          = 4
} IGFastImageType;

@class IGFastImageRequestOperation;

@interface IGFastImage : NSObject

@property (nonatomic, strong) IGFastImageRequestOperation* operation;
@property (nonatomic, strong) NSData* responseData;

-(id) initWithURLString:(NSString*)urlString;
-(id) initWithURL:(NSURL*)url;

-(IGFastImageType) type;
-(CGSize) size;

@end
