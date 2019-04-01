//
//  MAPNavigationView.m
//  Map
//
//  Created by _祀梦 on 2019/4/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPNavigationView.h"
#import <Masonry.h>

@implementation MAPNavigationView

- (instancetype) init {
    self = [super init];
    if (self) {
        _mapView = [[BMKMapView alloc] init];
        [_mapView setZoomLevel:21];
        [self addSubview:_mapView];
        
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_navigationView];
        
//        _loactionTableView = [[UITableView alloc] init];
//        _loactionTableView.dataSource = self;
//        _loactionTableView.delegate = self;
//        [_navigationView addSubview:_loactionTableView];
        
        _checkButton = [[UIButton alloc] init];
        [_checkButton setTitle:[NSString stringWithFormat:@"查看路线"] forState:UIControlStateNormal];
        [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        [_checkButton addTarget:self action:@selector(clickedCheckButton:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView addSubview:_checkButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.35);
    }];
    
    [_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.65);
    }];
    
//    [_loactionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.navigationView.mas_top).mas_offset(20);
//        make.left.mas_equalTo(self.navigationView.mas_left).mas_offset(10);
//        make.right.mas_equalTo(self.navigationView.mas_right).mas_offset(-10);
//        make.bottom.mas_equalTo(self.navigationView.mas_bottom).mas_offset(-60);
//    }];
    
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(self.navigationView.mas_left).mas_offset(0);
        make.right.mas_equalTo(self.navigationView.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(self.navigationView.mas_bottom).mas_offset(0);
    }];
}

//查看路线点击事件
- (void)clickedCheckButton:(UIButton *)button {
    
}
@end
