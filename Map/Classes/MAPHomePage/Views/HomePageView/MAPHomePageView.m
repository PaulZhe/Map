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
        self.addButton = [[UIButton alloc] init];
        self.navigationButton = [[UIButton alloc] init];
        [self addSubview:_mapView];
        [self addSubview:_addButton];
        [self addSubview:_navigationButton];
        
        //设置底部添加按钮
        [self.addButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        [self.addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self.addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
        
        //设置导航按钮
        self.navigationButton.layer.masksToBounds = YES;
        self.navigationButton.layer.cornerRadius = 27.5;
        [self.navigationButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        [self.navigationButton setTitle:@"导航" forState:UIControlStateNormal];
        [self.navigationButton setTintColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
        self.navigationButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        //设置定位图标，模式，精度圈
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
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.mapView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 50);
    
    //设置底部添加按钮
    self.addButton.frame = CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50);
    
    //设置推荐按钮
    self.navigationButton.frame = CGRectMake(self.frame.size.width - 65, 25, 55, 55);
}

@end
