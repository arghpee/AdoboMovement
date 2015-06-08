//
//  MyHTTPClient.m
//  AdoboMovement
//
//  Created by Rizza on 6/8/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import "MyHTTPClient.h"

static NSString * const OnlineURLString = @"http://gift.jumpdigital.asia";

@implementation MyHTTPClient

+ (MyHTTPClient *)mySharedHTTPClient
{
    static MyHTTPClient *_sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:OnlineURLString]];
    });
    
    return _sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

- (void)postToAPIWithParams:(NSMutableDictionary *)parameters andWithImageData:(NSData *)imageData {
    [self POST:@"/adobo-signature-api/registrants" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"signature" fileName:@"signature.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(myHTTPClient:didPostToAPI:)]) {
            [self.delegate myHTTPClient:self didPostToAPI:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(myHTTPClient:didFailWithError:)]) {
            [self.delegate myHTTPClient:self didFailWithError:error];
        }
    }];
}

@end
