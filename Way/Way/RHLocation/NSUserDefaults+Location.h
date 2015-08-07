//
//  NSUserDefaults+Location.h
//  Way
//
//  Created by zhuruhong on 15/8/6.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/** 纬度 */
extern NSString *const kValueLocationCoordinateLat;
/** 精度 */
extern NSString *const kValueLocationCoordinateLng;

@interface NSUserDefaults (Location)

+ (instancetype)sharedInstance;

- (void)setLocationCoordinate:(CLLocationCoordinate2D)coordinate;
- (CLLocationCoordinate2D)locationCoordinate;

- (void)setLocation:(CLLocation *)location;
- (CLLocation *)location;

@end
