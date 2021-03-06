//
//  AppDelegate.m
//  Map
//
//  Created by 小哲的DELL on 2019/1/8.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "AppDelegate.h"
#import "MAPHomePageViewController.h"
#import "BNaviService.h"

@interface AppDelegate () <BNNaviSoundDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //这里注意有可能要使用GCJ02坐标，但是我现在分不清楚了
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"luyGEHG2lHmVRDUA44DUuX83uDoKLu9H" authDelegate:self];
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_COMMON]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:@"luyGEHG2lHmVRDUA44DUuX83uDoKLu9H"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [BNaviService_Instance initNaviService:nil success:^{
        [BNaviService_Instance authorizeNaviAppKey:@"luyGEHG2lHmVRDUA44DUuX83uDoKLu9H" completion:^(BOOL suc) {
            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!authorizedNaviAppKey ret = %d", suc);
        }];
        [BNaviService_Sound setSoundDelegate:self];
    } fail:^{
        NSLog(@"initNaviSDK fail");
    }];
    
    //设置主界面导航栏
    MAPHomePageViewController *homePageViewController = [[MAPHomePageViewController alloc] init];
    UINavigationController *homePageNavigation = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
    self.window.rootViewController = homePageNavigation;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
