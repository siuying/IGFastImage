//
//  IGFastImageURLConnectionOperation.m
//  IGFastImage
//
//  Created by Chong Francis on 13年5月6日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGFastImageRequestOperation.h"
#import "IGFastImageHelper.h"

@interface IGFastImageRequestOperation()<NSURLSessionDelegate> {
    BOOL _finished;
    BOOL _executing;
    BOOL _cancelled;
}
@property (nonatomic, strong) NSURLRequest* request;
@property (nonatomic, strong) NSURLSessionDataTask* dataTask;
@property (nonatomic, strong) NSMutableData* buffer;
@end

@implementation IGFastImageRequestOperation

-(id) initWithRequest:(NSURLRequest*)request {
    self = [super init];
    if (self) {
        self.size = CGSizeZero;
        self.type = IGFastImageTypeUnknown;

        self.request = request;
        self.buffer = [NSMutableData new];
    }
    return self;
}

-(void) checkType {
    if ([self.buffer length] < 2) {
        return;
    }

    self.type = [IGFastImageHelper parseTypeWithData:self.buffer];
    if (self.type == IGFastImageTypeUnknown) {
        [self finish];
    }
    
    self.size = [IGFastImageHelper parseSizeWithData:self.buffer];
    if (self.size.width != 0.0 && self.size.height != 0.0) {
        [self finish];
    }
}

- (void)start
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[IGFastImage sharedQueue]];
    self.dataTask = [session dataTaskWithRequest:self.request];
    [self.dataTask resume];
    [self didChangeValueForKey:@"isExecuting"];
}

-(BOOL) isConcurrent
{
    return YES;
}

-(BOOL) isAsynchronous
{
    return YES;
}

-(BOOL) isExecuting
{
    return _executing;
}

-(BOOL) isFinished
{
    return _finished;
}

-(BOOL) isCancelled
{
    return _cancelled;
}

-(void) cancel
{
    [self willChangeValueForKey:@"isCancelled"];
    [self willChangeValueForKey:@"isExecuting"];
    [_dataTask cancel];
    _dataTask = nil;

    _cancelled = YES;
    _executing = NO;
    [self didChangeValueForKey:@"isCancelled"];
    [self didChangeValueForKey:@"isExecuting"];
}

-(void) finish
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    [_dataTask cancel];
    _dataTask = nil;

    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [self.buffer appendData:data];
    [self checkType];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    [self finish];
}

@end