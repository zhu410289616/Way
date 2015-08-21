//
//  HttpTestAPI.m
//  Way
//
//  Created by zhuruhong on 15/8/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "HttpTestAPI.h"

@implementation HttpTestAPI

- (NSString *)httpURL
{
    return @"http://mobile.ximalaya.com/mobile/others/ca/album/track/280961/true/1/30?device=iPhone";
}

- (BOOL)shouldWriteResponseToCache
{
    return YES;
}

- (BOOL)shouldReadCacheForResponse
{
    return YES;
}

- (void)requestCache:(id<RHHttpProtocol>)request response:(id)response
{
    [super requestCache:request response:response];
    
}

- (void)requestSuccess:(id<RHHttpProtocol>)request response:(id)response
{
    [super requestSuccess:request response:response];
}

- (void)requestFailure:(id<RHHttpProtocol>)request response:(id)response
{
    [super requestFailure:request response:response];
}

@end
