//
//  TrackInfo.m
//  Way
//
//  Created by zhuruhong on 15/8/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "TrackInfo.h"

@implementation TrackInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keys = @{
                           @"albumId":@"albumId",
                           @"albumImage":@"albumImage",
                           @"albumTitle":@"albumTitle",
                           @"coverLarge":@"coverLarge"
                           };
    return keys;
}

@end
