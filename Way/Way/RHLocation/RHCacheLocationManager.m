//
//  RHCacheLocationManager.m
//  Way
//
//  Created by zhuruhong on 15/8/5.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHCacheLocationManager.h"

@implementation RHCacheLocationManager

- (instancetype)init
{
    if (self = [super init]) {
        _locationArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)startUpdatingLocationUseCache
{
    _cacheLocation = [[NSUserDefaults sharedInstance] location];
    if ([RHCoordinateUtil isValidCoordinate:_cacheLocation.coordinate]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLocationData object:_cacheLocation userInfo:@{@"Source":@"Cache"}];
    }
    [super startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [super locationManager:manager didUpdateLocations:locations];
    
    if (locations.count > 0) {
        [_locationArray addObject:locations];
    }
}



@end
