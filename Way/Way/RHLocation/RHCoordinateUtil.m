//
//  RHCoordinateUtil.m
//  Way
//
//  Created by zhuruhong on 15/8/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHCoordinateUtil.h"

@implementation RHCoordinateUtil

+ (BOOL)isValidCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (coordinate.latitude > 10 && coordinate.longitude > 10 && CLLocationCoordinate2DIsValid(coordinate)) {
        return YES;
    } else {
        return NO;
    }
}

@end
