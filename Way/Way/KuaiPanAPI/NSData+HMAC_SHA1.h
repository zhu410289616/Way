//
//  NSData+HMAC_SHA1.h
//  Way
//
//  Created by zhuruhong on 15/8/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HMAC_SHA1)

- (NSData *)HMAC_SHA1SignatureWithKey:(NSString *)key;

@end
