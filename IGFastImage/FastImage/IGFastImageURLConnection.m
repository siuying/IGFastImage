//
//  IGFastImageURLConnectionOperation.m
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGFastImageURLConnection.h"
#import "IGFastImageHelper.h"

@implementation IGFastImageURLConnection

-(id) initWithRequest:(NSURLRequest*)request {
    self = [super initWithRequest:request];
    if (self) {
        self.size = CGSizeZero;
        self.type = IGFastImageTypeUnknown;
    }
    return self;
}

- (void)connection:(NSURLConnection __unused *)connection
    didReceiveData:(NSData *)data {
    [self checkType];
    [super connection:connection didReceiveData:data];
}

-(void) checkType {
    NSData* data = [self.outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    if ([data length] < 2) {
        return;
    }

    self.type = [IGFastImageHelper parseTypeWithData:data];
    if (self.type == IGFastImageTypeUnknown) {
        [self cancel];
    }
    
    self.size = [IGFastImageHelper parseSizeWithData:data];
    if (self.size.width != 0.0 && self.size.height != 0.0) {
        [self cancel];
    }
}

@end