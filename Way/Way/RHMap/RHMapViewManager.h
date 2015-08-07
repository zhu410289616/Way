//
//  RHMapViewManager.h
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHMapView.h"

@protocol RHMapViewManagerDelegate <NSObject>

- (void)didSingleTapAction:(UIGestureRecognizer *)gesture;

@end

@interface RHMapViewManager : NSObject <MAMapViewDelegate>

@property (nonatomic, strong, readonly) RHMapView *mapView;

@property (nonatomic, weak) id<RHMapViewManagerDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)installGestureListener;
- (void)uninstallGestureListener;

- (void)onDoubleTapAction:(UIGestureRecognizer *)gesture;
- (void)doSingleTapAction:(UIGestureRecognizer *)gesture;

@end
