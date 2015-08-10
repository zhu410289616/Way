//
//  NSUserDefaults+Location.m
//  Way
//
//  Created by zhuruhong on 15/8/6.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSUserDefaults+Location.h"

/** 纬度 */
NSString *const kValueLocationCoordinateLat = @"kValueLocationCoordinateLat";
/** 精度 */
NSString *const kValueLocationCoordinateLng = @"kValueLocationCoordinateLng";
/** 时间 */
NSString *const kValueLocationCoordinateTime = @"kValueLocationCoordinateTime";

@implementation NSUserDefaults (Location)

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)setLocationCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:coordinate.latitude forKey:kValueLocationCoordinateLat];
    [userDefaults setDouble:coordinate.longitude forKey:kValueLocationCoordinateLng];
    [userDefaults synchronize];
}

- (CLLocationCoordinate2D)locationCoordinate
{
#if TARGET_IPHONE_SIMULATOR
    double lat = 30.28069629;
    double lng = 120.11678696;
    return CLLocationCoordinate2DMake(lat, lng);
#else
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double lat = [userDefaults doubleForKey:kValueLocationCoordinateLat];
    double lng = [userDefaults doubleForKey:kValueLocationCoordinateLng];
    return CLLocationCoordinate2DMake(lat, lng);
#endif
}

- (void)setLocation:(CLLocation *)location
{
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSDate *timestamp = location.timestamp;
    NSTimeInterval timeInterval = [timestamp timeIntervalSince1970];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:timeInterval forKey:kValueLocationCoordinateTime];
    [userDefaults setDouble:coordinate.latitude forKey:kValueLocationCoordinateLat];
    [userDefaults setDouble:coordinate.longitude forKey:kValueLocationCoordinateLng];
    [userDefaults synchronize];
}

- (CLLocation *)locationWithTimeout:(NSTimeInterval)timeout
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSTimeInterval timeInterval = [userDefaults doubleForKey:kValueLocationCoordinateTime];
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    if ([timestamp timeIntervalSinceNow] > timeout) {
        return nil;
    }
    return [self location];
}

- (CLLocation *)location
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double lat = [userDefaults doubleForKey:kValueLocationCoordinateLat];
    double lng = [userDefaults doubleForKey:kValueLocationCoordinateLng];
    NSTimeInterval timeInterval = [userDefaults doubleForKey:kValueLocationCoordinateTime];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lng);
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    CLLocation *location = [[CLLocation alloc] initWithCoordinate:coordinate altitude:0 horizontalAccuracy:0 verticalAccuracy:0 timestamp:timestamp];
    return location;
}

@end
