//
//  IGFastImage - IGFastImageSpec.m
//  Copyright 2013年 Ignition Soft. All rights reserved.
//
//  Created by: Chong Francis
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "IGFastImage.h"

SpecBegin(IGFastImageSpec)

describe(@"IGFastImageSpec", ^{
    describe(@"parse remote image", ^{
        it(@"parse smaller remote URL", ^{
            NSURL* url = [NSURL URLWithString:@"https://www.google.com.hk/images/icons/product/chrome-48.png"];
            IGFastImage* image = [[IGFastImage alloc] initWithURL:url];
            
            while(image.type == IGFastImageTypeUnknown &&
                  image.size.width == 0.0 && image.size.height == 0.0) {
                [NSThread sleepForTimeInterval:1.0];
            }
            
            expect(image.type).to.equal(IGFastImageTypePNG);
            expect(image.size).to.equal(CGSizeMake(48.0, 48.0));
        });
        
        it(@"parse large remote URL", ^{
            NSURL* url = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/b/b4/Mardin_1350660_1350692_33_images.jpg"];
            IGFastImage* image = [[IGFastImage alloc] initWithURL:url];
            
            while(image.type == IGFastImageTypeUnknown &&
                  image.size.width == 0.0 && image.size.height == 0.0) {
                [NSThread sleepForTimeInterval:1.0];
            }
            
            expect(image.type).to.equal(IGFastImageTypeJPEG);
            expect(image.size).to.equal(CGSizeMake(9545, 6623));
        });
    });
});

SpecEnd
