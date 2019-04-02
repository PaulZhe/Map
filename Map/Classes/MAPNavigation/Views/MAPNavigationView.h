//
//  MAPNavigationView.h
//  Map
//
//  Created by _祀梦 on 2019/4/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "MAPLocationTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPNavigationView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BMKMapView *mapView;//显示地图
@property (nonatomic, strong) UIView *navigationView;//导航界面
@property (nonatomic, strong) UITableView *loactionTableView;//多个地点
@property (nonatomic, strong) UIButton *checkButton;//导航按钮
@end

NS_ASSUME_NONNULL_END
