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

NS_ASSUME_NONNULL_BEGIN

@interface MAPHomePageViewController : UIViewController <BMKMapViewDelegate, BMKLocationManagerDelegate>
//@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置
@property (nonatomic, strong) MAPHomePageView *homePageView;
@end

NS_ASSUME_NONNULL_END
