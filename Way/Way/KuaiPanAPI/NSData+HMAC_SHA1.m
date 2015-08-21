//
//  NSData+HMAC_SHA1.m
//  Way
//
//  Created by zhuruhong on 15/8/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSData+HMAC_SHA1.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSData (HMAC_SHA1)

- (NSData *)HMAC_SHA1SignatureWithKey:(NSString *)key
{
    NSData *secretData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t bufferSize = 20;
    void *buffer = malloc(bufferSize);
    
    CCHmac(kCCHmacAlgSHA1, secretData.bytes, secretData.length, self.bytes, self.length, buffer);
    
    NSData *resultData = [NSData dataWithBytes:buffer length:bufferSize];
    return resultData;
}

@end
