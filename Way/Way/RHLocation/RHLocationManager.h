//
//  RHLocationManager.h
//  Way
//
//  Created by zhuruhong on 15/8/5.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "NSUserDefaults+Location.h"

extern NSInteger const kValueLocationFilterDistance;

extern NSString *const kNotificationLocationStateChanged;
extern NSString *const kNotificationLocationData;

typedef NS_ENUM(NSInteger, RHLocationAuthorizationType) {
    RHLocationAuthorizationTypeAlways,
    RHLocationAuthorizationTypeWhenInUse
};

typedef NS_ENUM(NSInteger, RHLocationManagerState) {
    RHLocationManagerStateUnknow,       //
    RHLocationManagerStateDisabled,     //定位服务不可用
    RHLocationManagerStateSuccess,      //定位成功
    RHLocationManagerStateFailed        //定位失败
};

#define _LocationManager [RHLocationManager sharedInstance]

@interface RHLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong, readonly) CLLocationManager *locationManager;

@property (nonatomic, assign) RHLocationAuthorizationType authorizationType;

/** 最近一次gps位置信息 */
@property (nonatomic, strong, readonly) CLLocation *lastLocation;

+ (instancetype)sharedInstance;

/** 设备是否有gps模块 */
- (BOOL)isGPSEquippedInDevice;
/** 定位是否开启 */
- (BOOL)isLocationServiceEnabled;

- (void)startUpdatingLocationWithDistance:(CGFloat)distance accuracy:(CGFloat)accuracy;
- (void)startUpdatingLocationWithDistance:(CGFloat)distance;
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

- (void)startUpdatingHeading;
- (void)stopUpdatingHeading;

@end
