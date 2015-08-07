//
//  RHCacheLocationManager.h
//  Way
//
//  Created by zhuruhong on 15/8/5.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHLocationManager.h"

#define _CacheLocationManager [RHCacheLocationManager sharedInstance]

@interface RHCacheLocationManager : RHLocationManager

@property (nonatomic, strong, readonly) NSMutableArray *locationArray;

@property (nonatomic, assign, readonly) CLLocation *cacheLocation;

- (void)startUpdatingLocationUseCache;

@end
