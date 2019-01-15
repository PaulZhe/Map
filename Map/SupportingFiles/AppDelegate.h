//
//  AppDelegate.h
//  Map
//
//  Created by 小哲的DELL on 2019/1/8.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BMKLocationkit/BMKLocationComponent.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKLocationAuthDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BMKMapManager *mapManager;

@end

