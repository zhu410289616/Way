//
//  RHLocationManager.m
//  Way
//
//  Created by zhuruhong on 15/8/5.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHLocationManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

NSInteger const kValueLocationFilterDistance = 50;

NSString *const kNotificationLocationStateChanged = @"kNotificationLocationStateChanged";
NSString *const kNotificationLocationData = @"kNotificationLocationData";

@interface RHLocationManager ()
{
    RHLocationManagerState _locationState;
}

@end

@implementation RHLocationManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _authorizationType = RHLocationAuthorizationTypeAlways;
        _locationState = RHLocationManagerStateUnknow;
    }
    return self;
}

#pragma mark -
#pragma mark public

- (BOOL)isGPSEquippedInDevice
{
#if TARGET_IPHONE_SIMULATOR
    return YES;
#else
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    return carrier ? YES : NO;
#endif
}

- (BOOL)isLocationServiceEnabled
{
    return [CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied;
}

- (void)startUpdatingLocationWithDistance:(CGFloat)distance accuracy:(CGFloat)accuracy
{
    if ([self isLocationServiceEnabled] && [self isGPSEquippedInDevice]) {
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
        }
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = accuracy;
        _locationManager.distanceFilter = distance;
        [self startLocationWithAuthorizationType:_authorizationType];
    } else {
        [self notifyLocationStateChanged:RHLocationManagerStateDisabled];
    }
}

- (void)startUpdatingLocationWithDistance:(CGFloat)distance
{
    [self startUpdatingLocationWithDistance:distance accuracy:kCLLocationAccuracyBest];
}

- (void)startUpdatingLocation
{
    [self startUpdatingLocationWithDistance:kValueLocationFilterDistance];
}

- (void)stopUpdatingLocation
{
    if (_locationManager) {
        _locationManager.delegate = nil;
        [_locationManager stopUpdatingLocation];
        [_locationManager stopMonitoringSignificantLocationChanges];
        _locationManager = nil;
    }
    _locationState = RHLocationManagerStateUnknow;
}

- (void)startUpdatingHeadingWithHeadingFilter:(CGFloat)filter
{
    if ([CLLocationManager headingAvailable]) {
        _locationManager.headingFilter = filter;
        [_locationManager startUpdatingHeading];
    }
}

- (void)startUpdatingHeading
{
    [self startUpdatingHeadingWithHeadingFilter:1];
}

- (void)stopUpdatingHeading
{
    [_locationManager stopUpdatingHeading];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate method

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            [self startLocationWithAuthorizationType:_authorizationType];
        }
            break;
            
        default:
            break;
    }
}

/*
 This method is deprecated. If locationManager:didUpdateLocations: is implemented,
 this method will not be called.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self locationManager:manager didUpdateLocations:@[newLocation]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self notifyLocationStateChanged:RHLocationManagerStateSuccess];
    if (locations.count > 0) {
        _lastLocation = locations[0];
        [[NSUserDefaults sharedInstance] setLocation:_lastLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLocationData object:_lastLocation userInfo:@{@"Source":@"Location"}];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self notifyLocationStateChanged:RHLocationManagerStateFailed];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0) {
        return;
    }
    
    // Use the true heading if it is valid.
    CLLocationDirection theHeading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
    NSLog(@"theHeading: %f", theHeading);
}

#pragma mark -
#pragma mark private method

- (void)startLocationWithWhenInUseAuthorization
{
#ifdef __IPHONE_8_0
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
#endif
    [_locationManager startUpdatingLocation];
}

- (void)startLocationWithAlwaysAuthorization
{
    _locationManager.pausesLocationUpdatesAutomatically = NO;
#ifdef __IPHONE_8_0
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
#endif
    [_locationManager startUpdatingLocation];
}

- (void)startLocationWithAuthorizationType:(RHLocationAuthorizationType)type
{
    switch (type) {
        case RHLocationAuthorizationTypeAlways: {
            [self startLocationWithAlwaysAuthorization];
            break;
        }
        case RHLocationAuthorizationTypeWhenInUse: {
            [self startLocationWithWhenInUseAuthorization];
            break;
        }
        default: {
            break;
        }
    }//switch
}

- (void)notifyLocationStateChanged:(RHLocationManagerState)state
{
    if (state != _locationState) {
        _locationState = state;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLocationStateChanged object:@(_locationState)];
    }
}

@end
