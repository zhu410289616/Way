//
//  RHRequestToken.m
//  Way
//
//  Created by zhuruhong on 15/8/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHRequestToken.h"
#import "RHKuaiPanConfig.h"
#import "NSString+App.h"
#import "NSData+HMAC_SHA1.h"
#import "base64.h"

@implementation RHRequestToken

- (NSString *)httpURL
{
    return KuaiPanUrl_RequestToken;
}

- (NSDictionary *)httpParameters
{
    NSDictionary *paramDic = @{
                               @"oauth_consumer_key":KuaiPan_ConsumerKey,
                               @"oauth_signature_method":@"HMAC-SHA1",
                               @"oauth_timestamp":[NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]],
                               @"oauth_nonce":[NSString stringWithFormat:@"%lu", clock()],
                               @"oauth_version":@"1.0"
                               };
    NSArray *allKeys = [paramDic allKeys];
    NSArray *sortedKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    RHLogLog(@"sortedKeys: %@", sortedKeys);
    
    NSMutableString *baseString = [NSMutableString stringWithFormat:@"%@&%@&", @"GET", [KuaiPanUrl_RequestToken stringWithUrlEncode]];
    
    NSInteger keyCount = sortedKeys.count;
    for (NSInteger i=0; i<keyCount; i++) {
        NSString *key = sortedKeys[i];
        NSString *value = paramDic[key];
        
        NSString *keyValue = [NSString stringWithFormat:@"%@=%@&", [key stringWithUrlEncode], [value stringWithUrlEncode]];
        if (i == keyCount - 1) {
            keyValue = [NSString stringWithFormat:@"%@=%@", [key stringWithUrlEncode], [value stringWithUrlEncode]];
        }
        [baseString appendString:[keyValue stringWithUrlEncode]];
    }
    
    NSData *baseData = [baseString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *signatureData = [baseData HMAC_SHA1SignatureWithKey:[NSString stringWithFormat:@"%@&", KuaiPan_ConsumerSecret]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:paramDic];
    params[@"oauth_signature"] = [signatureData base64EncodedString];
    
    return params;
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
