//
//  IGFastImage - IGFastImageSpec.m
//  Copyright 2013年 Ignition Soft. All rights reserved.
//
//  Created by: Chong Francis
//
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

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

            expect(image.type).to.equal(IGFastImageTypePNG);
            expect(image.size).to.equal(CGSizeMake(48.0, 48.0));
        });
        
        it(@"parse large remote URL", ^{
            NSURL* url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/b/b4/Mardin_1350660_1350692_33_images.jpg"];
            IGFastImage* image = [[IGFastImage alloc] initWithURL:url];
            expect(image.type).to.equal(IGFastImageTypeJPEG);
            expect(image.size).to.equal(CGSizeMake(9545, 6623));
            
            url = [NSURL URLWithString:@"https://farm8.staticflickr.com/7409/9523078856_516f335144_o.jpg"];
            image = [[IGFastImage alloc] initWithURL:url];
            expect(image.type).to.equal(IGFastImageTypeJPEG);
            expect(image.size).to.equal(CGSizeMake(4300, 2860));
        });
    });
});

SpecEnd
