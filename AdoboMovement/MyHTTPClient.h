//
//  MyHTTPClient.h
//  AdoboMovement
//
//  Created by Rizza on 6/8/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol MyHTTPClientDelegate;
@interface MyHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<MyHTTPClientDelegate>delegate;

+ (MyHTTPClient *)mySharedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)postToAPIWithParams:(NSMutableDictionary *)params andWithImageData:(NSData *)imageData;

@end

@protocol MyHTTPClientDelegate <NSObject>

-(void)myHTTPClient:(MyHTTPClient *)client didPostToAPI:(id)response;
-(void)myHTTPClient:(MyHTTPClient *)client didFailWithError:(NSError *)error;

@end



