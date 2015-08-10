//
//  RHCacheLocationManager.h
//  Way
//
//  Created by zhuruhong on 15/8/5.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHLocationManager.h"
#import "RHCoordinateUtil.h"

#define _CacheLocationManager [RHCacheLocationManager sharedInstance]

@interface RHCacheLocationManager : RHLocationManager

@property (nonatomic, strong, readonly) NSMutableArray *locationArray;

/** 最近一次缓存的gps位置信息 */
@property (nonatomic, strong, readonly) CLLocation *cacheLocation;

- (void)startUpdatingLocationUseCache;

@end
