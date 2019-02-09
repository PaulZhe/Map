//
//  MAPAddDynamicStateView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddDynamicStateView.h"
#import <Masonry.h>

@implementation MAPAddDynamicStateView

- (instancetype) initWithTypeString:(NSString *) typeString {
    self = [super init];
    if (self) {
        _mapView = [[BMKMapView alloc] init];
        [_mapView setZoomLevel:21];
        [self addSubview:_mapView];
        
        _addDynamicStateView = [[UIView alloc] init];
        _addDynamicStateView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addDynamicStateView];
        
        _locationNameLabel = [[UILabel alloc] init];
        [_addDynamicStateView addSubview:_locationNameLabel];
        _locationNameLabel.text = @"西安邮电大学";
        _locationNameLabel.font = [UIFont systemFontOfSize:23];
        
        _adjustmentButton = [[UIButton alloc] init];
        [_addDynamicStateView addSubview:_adjustmentButton];
        _adjustmentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_adjustmentButton setTitle:[NSString stringWithFormat:@"地点微调？"] forState:UIControlStateNormal];
        [_adjustmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _lineView = [[UIImageView alloc] init];
        [_addDynamicStateView addSubview:_lineView];
        _lineView.backgroundColor = [UIColor blackColor];
        
        _issueButton = [[UIButton alloc] init];
        [_addDynamicStateView addSubview:_issueButton];
        [_issueButton setTitle:[NSString stringWithFormat:@"发  布"] forState:UIControlStateNormal];
        [_issueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_issueButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        
        if ([typeString isEqualToString:@"101"]) {
            //添加评论界面
            _addCommentView = [[MAPAddCommentView alloc] init];
            [_addDynamicStateView addSubview:_addCommentView];
        } else if ([typeString isEqualToString:@"102"]) {
            //添加图片界面
            _addPicturesView = [[MAPAddPicturesView alloc] init];
            [_addDynamicStateView addSubview:_addPicturesView];
        } else if ([typeString isEqualToString:@"103"]) {
            //添加语音界面
            
        } else {
            //添加视频界面
            _addVedioView = [[MAPAddVedioView alloc] init];
            [_addDynamicStateView addSubview:_addVedioView];
        }
    }
    return self;
}

- (void) layoutSubviews {
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.35);
    }];
    
    [_addDynamicStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.65);
    }];
    
    [_locationNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [_adjustmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_locationNameLabel.mas_bottom).mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(0.8);
    }];
    
    [_issueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    [_addCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
        make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
        make.bottom.mas_equalTo(self->_issueButton.mas_top);
    }];
    
    [_addPicturesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom);
        make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
        make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
        make.bottom.mas_equalTo(self->_issueButton.mas_top);
    }];
    
    [_addVedioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom);
        make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
        make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
        make.bottom.mas_equalTo(self->_issueButton.mas_top);
    }];
}

//地点微调点击事件
- (void)addTapBlock:(buttonBlock)block {
    _block = block;
    [_adjustmentButton addTarget:self action:@selector(adjustmentLocation:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) adjustmentLocation:(UIButton *) button {
    _block(button);
}

@end
