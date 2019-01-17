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
//    显示我的位置，我的位置图标和地图都不会旋转
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    
    [self.mapView showsUserLocation];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
