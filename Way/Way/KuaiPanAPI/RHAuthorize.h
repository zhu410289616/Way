//
//  RHAuthorize.h
//  Way
//
//  Created by zhuruhong on 15/8/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHttpGetOperation.h"

@interface RHAuthorize : RHHttpGetOperation

@property (nonatomic, copy) NSString *oauth_token;

@end
