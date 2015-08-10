//
//  RHCoordinateUtil.h
//  Way
//
//  Created by zhuruhong on 15/8/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RHCoordinateUtil : NSObject

+ (BOOL)isValidCoordinate:(CLLocationCoordinate2D)coordinate;

@end
