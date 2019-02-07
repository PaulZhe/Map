//
//  MAPHomePageViewController.h
//  Map
//
//  Created by 涂强尧 on 2019/1/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import "MAPHomePageView.h"
#import "MAPAnnotationView.h"
#import "MAPIssueView.h"
#import "MAPAddDynamicStateViewController.h"


#import "MAPPaopaoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPHomePageViewController : UIViewController <BMKMapViewDelegate, BMKLocationManagerDelegate>
@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置
@property (nonatomic, strong) BMKPointAnnotation *annotation;//标记点
@property (nonatomic, strong) MAPHomePageView *homePageView;//主界面
@property (nonatomic, strong) MAPAnnotationView *annotationView;//气泡界面
@property (nonatomic, strong) MAPAddDynamicStateViewController *addDyanmicStateViewController;//添加动态controller

//测试泡泡点击事件
@property (nonatomic, strong) MAPPaopaoView *paopaoView;
@property (nonatomic, strong) MAPHomePageViewController *homePageViewController;
@end

NS_ASSUME_NONNULL_END
