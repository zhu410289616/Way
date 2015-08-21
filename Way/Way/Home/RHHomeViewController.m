//
//  RHHomeViewController.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHHomeViewController.h"
#import "RHHomeView.h"

#import "RHSettingsViewController.h"

#import "NSUserDefaults+Location.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "RHPolyline.h"

#import "HttpTestAPI.h"
#import "RHRequestToken.h"

@interface RHHomeViewController () <RHHomeViewDelegate, AMapNaviManagerDelegate>
{
    RHHomeView *_homeView;
    
    AMapNaviManager *_naviManager;
}

@end

@implementation RHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateNavigationBarStyle];//
    
    self.title = @"home";
    self.navigationItem.backBarButtonItem = [self backBarButtonItem];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    
    _homeView = [[RHHomeView alloc] init];
    _homeView.delegate = self;
    [self.view addSubview:_homeView];
    [_homeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    double lat = 30.28069629;
    double lng = 120.11678696;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lng);
    [_homeView.mapView setCenterCoordinate:coordinate zoomLevel:16.5f];
    
    //
    [_homeView addAnnotationWithCoordinate:CLLocationCoordinate2DMake(30.28069629, 120.11678696)];
    [_homeView addAnnotationWithCoordinate:CLLocationCoordinate2DMake(30.18069629, 120.11678696)];
    
    //
    _naviManager = [[AMapNaviManager alloc] init];
    _naviManager.delegate = self;
    
    HttpTestAPI *api = [[HttpTestAPI alloc] init];
    [api start];
    
    //构造多边形数据对象
    CLLocationCoordinate2D coordinates[4];
    coordinates[0].latitude = 39.810892;
    coordinates[0].longitude = 116.233413;
    
    coordinates[1].latitude = 39.816600;
    coordinates[1].longitude = 116.331842;
    
    coordinates[2].latitude = 39.762187;
    coordinates[2].longitude = 116.357932;
    
    coordinates[3].latitude = 39.733653;
    coordinates[3].longitude = 116.278255;
    
    MAPolygon *polygon = [MAPolygon polygonWithCoordinates:coordinates count:4];
    
    //在地图上添加折线对象
    [_homeView.mapView addOverlay: polygon];
    
}

- (void)doRightBarButtonAction
{
    RHSettingsViewController *settings = [[RHSettingsViewController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark RHHomeViewDelegate method

- (void)didLocateAction
{}

- (void)didRefreshAction
{
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:30.16069629 longitude:120.12678696];
    
    NSMutableArray *naviPoints = [[NSMutableArray alloc] init];
    
    [_homeView.mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MAPointAnnotation *annotation = obj;
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        AMapNaviPoint *point = [AMapNaviPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [naviPoints addObject:point];
    }];
    NSLog(@"_homeView.mapView.annotations: %ld", _homeView.mapView.annotations.count);
    
    if (_homeView.mapView.annotations.count < 2) {
        return;
    }
    
    [_naviManager calculateDriveRouteWithStartPoints:@[startPoint] endPoints:naviPoints wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyDefault];
    
    [_naviManager calculateWalkRouteWithStartPoints:@[startPoint] endPoints:naviPoints];
}

- (void)didSingleTapAction:(CLLocationCoordinate2D)coordinate
{
    [[NSUserDefaults sharedInstance] setLocationCoordinate:coordinate];
    [_homeView addAnnotationWithCoordinate:coordinate];
}

#pragma mark -

- (void)showRouteWithNaviRoute:(AMapNaviRoute *)naviRoute
{
    if (naviRoute == nil) {
        return;
    }
    
    NSUInteger coordianteCount = [naviRoute.routeCoordinates count];
    CLLocationCoordinate2D coordinates[coordianteCount];
    for (int i = 0; i < coordianteCount; i++) {
        AMapNaviPoint *aCoordinate = naviRoute.routeCoordinates[i];
        coordinates[i] = CLLocationCoordinate2DMake(aCoordinate.latitude, aCoordinate.longitude);
    }
    
    RHPolyline *tempPolyline = [RHPolyline polylineWithCoordinates:coordinates count:coordianteCount];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(kSizeFrom750(400), kSizeFrom750(150), kSizeFrom750(260), kSizeFrom750(150));
    [_homeView.mapView setVisibleMapRect:[tempPolyline boundingMapRect] edgePadding:edgeInsets animated:YES];
    [_homeView.mapView addOverlay:tempPolyline];
}

#pragma mark -
#pragma mark AMapNaviManagerDelegate method

/*!
 @brief AMapNaviManager发生错误时的回调函数
 @param error 错误信息
 */
- (void)naviManager:(AMapNaviManager *)naviManager error:(NSError *)error
{}

/*!
 @brief naviViewController被展示出来后的回调
 @param naviViewController 被展示出来的ViewController
 */
- (void)naviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
{}

/*!
 @brief naviViewController被取消展示后的回调
 @param naviViewController 被取消展示ViewController
 */
- (void)naviManager:(AMapNaviManager *)naviManager didDismissNaviViewController:(UIViewController *)naviViewController
{}

/*!
 @brief 驾车路径规划成功后的回调函数
 */
- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    RHLogLog(@"naviManagerOnCalculateRouteSuccess...");
    
    AMapNaviRoute *route = naviManager.naviRoute;
    RHLogLog(@"route.routeLength: %d", route.routeLength);
    
    [self showRouteWithNaviRoute:route];
}

/*!
 @brief 驾车路径规划失败后的回调函数
 @param error 计算路径的错误，error.code参照AMapNaviCalcRouteState
 */
- (void)naviManager:(AMapNaviManager *)naviManager onCalculateRouteFailure:(NSError *)error
{
    RHLogLog(@"onCalculateRouteFailure...");
}

/*!
 @brief 驾车导航时，出现偏航需要重新计算路径时的回调函数
 */
- (void)naviManagerNeedRecalculateRouteForYaw:(AMapNaviManager *)naviManager
{}

/*!
 @brief 启动导航后回调函数
 @param naviMode 导航类型，参考AMapNaviMode
 */
- (void)naviManager:(AMapNaviManager *)naviManager didStartNavi:(AMapNaviMode)naviMode
{}

/*!
 @brief 模拟导航到达目的地停止导航后的回调函数
 */
- (void)naviManagerDidEndEmulatorNavi:(AMapNaviManager *)naviManager
{}

/*!
 @brief 到达目的地后回调
 */
- (void)naviManagerOnArrivedDestination:(AMapNaviManager *)naviManager
{}

/*!
 @brief 驾车路径导航到达某个途经点的回调函数
 @param wayPointIndex 到达途径点的编号，标号从1开始
 */
- (void)naviManager:(AMapNaviManager *)naviManager onArrivedWayPoint:(int)wayPointIndex
{}

/*!
 @brief 自车位置更新后的回调函数
 @param naviLocation 当前自车位置信息
 */
- (void)naviManager:(AMapNaviManager *)naviManager didUpdateNaviLocation:(AMapNaviLocation *)naviLocation
{}

/*!
 @brief 模拟和GPS导航过程中,导航信息有更新后的回调函数
 @param naviInfo 当前的导航信息
 */
- (void)naviManager:(AMapNaviManager *)naviManager didUpdateNaviInfo:(AMapNaviInfo *)naviInfo
{}

/*!
 @brief 获取当前播报状态的回调函数
 @return 返回当前是否正在播报
 */
- (BOOL)naviManagerGetSoundPlayState:(AMapNaviManager *)naviManager
{
    return NO;
}

/*!
 @brief 导航播报信息回调函数
 @param soundString 播报文字
 @param soundStringType 播报类型，包含导航播报、前方路况播报和整体路况播报，参考AMapNaviSoundType
 */
- (void)naviManager:(AMapNaviManager *)naviManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{}

/*!
 @brief 当前方路况光柱信息更新后的回调函数
 */
- (void)naviManagerDidUpdateTrafficStatuses:(AMapNaviManager *)naviManager
{}

@end
