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

#import <AMapNaviKit/AMapNaviKit.h>

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
    _naviManager = [[AMapNaviManager alloc] init];
    _naviManager.delegate = self;
    
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
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:30.28069629 longitude:120.11678696];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:30.18069629 longitude:120.11678696];
    
    NSMutableArray *endPoints = [[NSMutableArray alloc] init];
    [endPoints addObject:endPoint];
    
    [_homeView.mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MAPointAnnotation *annotation = obj;
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        AMapNaviPoint *point = [AMapNaviPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [endPoints addObject:point];
    }];
    
    [_naviManager calculateDriveRouteWithStartPoints:@[startPoint] endPoints:endPoints wayPoints:nil drivingStrategy:AMapNaviDrivingStrategyDefault];
}

- (void)didSingleTapAction:(CLLocationCoordinate2D)coordinate
{
    [_homeView addAnnotationWithCoordinate:coordinate];
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
