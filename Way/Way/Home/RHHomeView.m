//
//  RHHomeView.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHomeView.h"
#import "RHMapViewManager.h"

static int kMapViewTag = 99999;

@interface RHHomeView () <RHMapViewManagerDelegate>
{
    UIButton *_locateButton;
    UIButton *_refreshButton;
}

@end

@implementation RHHomeView

- (instancetype)init
{
    if (self = [super init]) {
        
        //
        [self resetMapView];
        
        //刷新地图
        _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
        [_refreshButton setBackgroundColor:[UIColor grayColor]];
        [_refreshButton setBackgroundImage:[UIImage imageNamed:@"btn_home_refresh_normal"] forState:UIControlStateNormal];
        [_refreshButton setBackgroundImage:[UIImage imageNamed:@"btn_home_refresh_pressed"] forState:UIControlStateHighlighted];
        [_refreshButton addTarget:self action:@selector(doRefreshAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_refreshButton];
        [_refreshButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-kSizeFrom750(64));
            make.left.equalTo(self).offset(kSizeFrom750(20));
            make.size.mas_equalTo(CGSizeMake(kSizeFrom750(96), kSizeFrom750(96)));
        }];
        
        //重新定位
        _locateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locateButton setBackgroundImage:[UIImage imageNamed:@"btn_home_locate_normal"] forState:UIControlStateNormal];
        [_locateButton setBackgroundImage:[UIImage imageNamed:@"btn_home_locate_pressd"] forState:UIControlStateHighlighted];
        [_locateButton addTarget:self action:@selector(doLocateAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_locateButton];
        [_locateButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_refreshButton.mas_top).offset(-kSizeFrom750(24));
            make.left.equalTo(self).offset(kSizeFrom750(20));
            make.size.mas_equalTo(CGSizeMake(kSizeFrom750(96), kSizeFrom750(96)));
        }];
        
    }
    return self;
}

- (void)resetMapView
{
    UIView *oldView = [self viewWithTag:kMapViewTag];
    if (nil == oldView) {
        [RHMapViewManager sharedInstance].delegate = self;
        [[RHMapViewManager sharedInstance] installGestureListener];
        _mapView = [RHMapViewManager sharedInstance].mapView;
        _mapView.tag = kMapViewTag;
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        _mapView.showsUserLocation = YES;
        _mapView.zoomEnabled = YES;
        _mapView.scrollEnabled = YES;
        _mapView.hidden = NO;
        [self addSubview:_mapView];
        [self sendSubviewToBack:_mapView];
        [_mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self);
            make.center.equalTo(self);
        }];
    }//if
}

- (void)addAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    
    __weak typeof(annotation) weakAnno = annotation;
    [_mapView addAnnotation:annotation];
}

#pragma mark -
#pragma mark private method

- (void)didSingleTapAction:(UIGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSingleTapAction:)]) {
        CGPoint point = [gesture locationInView:_mapView];
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        [_delegate didSingleTapAction:coordinate];
    }
}

- (void)doLocateAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didLocateAction)]) {
        [_delegate didLocateAction];
    }
}

- (void)doRefreshAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didRefreshAction)]) {
        [_delegate didRefreshAction];
    }
}

#pragma mark -
#pragma mark test function

- (void)doTestLogicAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didTestLogicAction)]) {
        [_delegate didTestLogicAction];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
