//
//  MAPHomePageView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPHomePageView.h"

@implementation MAPHomePageView 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mapView = [[BMKMapView alloc] init];
        [self addSubview:_mapView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.mapView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc] init];
    //定位图标样式
//    displayParam.locationViewImgName = 
    //精度圈不显示
    displayParam.isAccuracyCircleShow = NO;
    //显示我的位置，我的位置图标会旋转，地图不会旋转
    self.mapView.userTrackingMode = BMKUserTrackingModeHeading;
    //根据配置参数更新定位图层样式
    [self.mapView updateLocationViewWithParam:displayParam];
    //将当前地图显示缩放等级设置为17级
    [self.mapView setZoomLevel:17];
    //显示定位图层
    [self.mapView showsUserLocation];
}

@end
