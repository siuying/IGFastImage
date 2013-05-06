//
//  IGFastImageURLConnectionOperation.h
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGFastImage.h"
#import "AFHTTPRequestOperation.h"

@interface IGFastImageRequestOperation : AFHTTPRequestOperation

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) IGFastImageType type;

-(id) initWithRequest:(NSURLRequest*)request;

@end
