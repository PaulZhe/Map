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
        _mapView = [[UIView alloc] init];
        _mapView.backgroundColor = [UIColor redColor];
        [self addSubview:_mapView];
        _addDynamicStateView = [[UIView alloc] init];
        _addDynamicStateView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addDynamicStateView];
        if ([typeString isEqualToString:@"101"]) {
            //添加评论界面
            _addCommentView = [[MAPAddCommentView alloc] init];
            [_addDynamicStateView addSubview:_addCommentView];
            [_addCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self->_addDynamicStateView.mas_top);
                make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
                make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
                make.bottom.mas_equalTo(self->_addDynamicStateView.mas_bottom);
            }];
        } else if ([typeString isEqualToString:@"102"]) {
            //添加图片界面
            
        } else if ([typeString isEqualToString:@"103"]) {
            //添加语音界面
            
        } else {
            //添加视频界面
            
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
}

@end
