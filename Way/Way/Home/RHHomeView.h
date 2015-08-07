//
//  RHHomeView.h
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHMapView.h"

@protocol RHHomeViewDelegate <NSObject>

@required

- (void)didLocateAction;
- (void)didRefreshAction;

@optional

- (void)didSingleTapAction:(CLLocationCoordinate2D)coordinate;

//测试方法，发布时需要把入口隐藏
- (void)didTestLogicAction;

@end

@interface RHHomeView : UIView

@property (nonatomic, strong, readonly) RHMapView *mapView;
@property (nonatomic, weak) id<RHHomeViewDelegate> delegate;

- (void)resetMapView;

- (void)addAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
