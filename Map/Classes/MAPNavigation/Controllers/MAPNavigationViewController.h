//
//  MAPNavigationViewController.h
//  Map
//
//  Created by _祀梦 on 2019/4/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPNavigationView.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPNavigationViewController : UIViewController <BMKMapViewDelegate>
@property (nonatomic, strong) MAPNavigationView *navigationView;
@property (nonatomic, assign) double Latitude;
@property (nonatomic, assign) double Longitud;//记录点的位置
@property (nonatomic, strong) NSMutableArray *dataMutableArray;//记录经纬度
@end

NS_ASSUME_NONNULL_END
