//
//  IGFastImage - IGFastImageHelperSpec.m
//  Copyright 2013年 Ignition Soft. All rights reserved.
//
//  Created by: Chong Francis
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "IGFastImageHelper.h"
#import "IGSpecHelper.h"

SpecBegin(IGFastImageHelperSpec)

describe(@"IGFastImageHelperSpec", ^{
    describe(@"+parseTypeWithData:", ^{
        it(@"should parse gif", ^{
            NSData* data = [IGSpecHelper dataWithFixtureFile:@"test" type:@"gif"];
            expect([IGFastImageHelper parseTypeWithData:data]).to.equal(IGFastImageTypeGIF);
        });

        it(@"should parse png", ^{
            NSData* data = [IGSpecHelper dataWithFixtureFile:@"test" type:@"png"];
            expect([IGFastImageHelper parseTypeWithData:data]).to.equal(IGFastImageTypePNG);
        });

        it(@"should parse jpg", ^{
            NSData* data = [IGSpecHelper dataWithFixtureFile:@"test" type:@"jpg"];
            expect([IGFastImageHelper parseTypeWithData:data]).to.equal(IGFastImageTypeJPEG);

            NSData* data2 = [IGSpecHelper dataWithFixtureFile:@"test2" type:@"jpg"];
            expect([IGFastImageHelper parseTypeWithData:data2]).to.equal(IGFastImageTypeJPEG);
            
            NSData* data3 = [IGSpecHelper dataWithFixtureFile:@"test2" type:@"jpg"];
            expect([IGFastImageHelper parseTypeWithData:data3]).to.equal(IGFastImageTypeJPEG);
        });

        it(@"should parse bmp", ^{
            NSData* data = [IGSpecHelper dataWithFixtureFile:@"test" type:@"bmp"];
            expect([IGFastImageHelper parseTypeWithData:data]).to.equal(IGFastImageTypeBMP);
        });
        
        describe(@"faulty data", ^{
            it(@"should not parse ico", ^{
                NSData* data = [IGSpecHelper dataWithFixtureFile:@"test" type:@"ico"];
                expect([IGFastImageHelper parseTypeWithData:data]).to.equal(IGFastImageTypeUnknown);
            });
        });
    });

    describe(@"+parseSizeForGifWithData:", ^{
        it(@"should parse gif", ^{
            NSData* data = [IGSpecHelper dataWithFixtureFile:@"test" type:@"gif"];
            expect([IGFastImageHelper parseSizeForGifWithData:data]).to.equal(CGSizeMake(17, 32));
        });
        
        it(@"should parse png", ^{
            NSData* data = [IGSpecHelper dataWithFixtureFile:@"test" type:@"png"];
            expect([IGFastImageHelper parseSizeForPngWithData:data]).to.equal(CGSizeMake(30, 20));
        });
    });
});

SpecEnd
