//
//  AppDelegate.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "AppDelegate.h"
#import "RHHomeViewController.h"
#import "RHMoreViewController.h"
#import "MMDrawerController.h"

#import <AMapNaviKit/AMapNaviKit.h>
#import "RHCacheLocationManager.h"
#import "UIImage+App.h"

@interface AppDelegate ()
{
    MMDrawerController *_drawerController;
}

@end

@implementation AppDelegate

- (void)configAMap
{
    RHLogLog(@"MAMapServices apiKey: %@, SDKVersion: %@", kMapKeyGaoDe, [MAMapServices sharedServices].SDKVersion);
    [MAMapServices sharedServices].apiKey = kMapKeyGaoDe;
    [AMapNaviServices sharedServices].apiKey = kMapKeyGaoDe;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configAMap];
    
    //导航中按钮view颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //导航背景色
    [[UINavigationBar appearance] setBarTintColor:[UIColor greenColor]];
    //导航中返回按钮尖头指示(两个要配合使用)
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageWithColor:[UIColor yellowColor] size:CGSizeMake(10, 10)]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageWithColor:[UIColor yellowColor] size:CGSizeMake(10, 10)]];
    
    RHHomeViewController *homeController = [[RHHomeViewController alloc] init];
    RHMoreViewController *moreController = [[RHMoreViewController alloc] init];
    
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeController];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController:moreController];
    
    _drawerController = [[MMDrawerController alloc] initWithCenterViewController:homeNav leftDrawerViewController:moreNav];
    [_drawerController setShowsShadow:YES];
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = _drawerController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [_CacheLocationManager startUpdatingLocationUseCache];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
