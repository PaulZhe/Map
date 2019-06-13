//
//  MAPMotiveVideoButton.m
//  Map
//
//  Created by 涂强尧 on 2019/1/27.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPMotiveVideoButton.h"
#import <Masonry.h>

@implementation MAPMotiveVideoButton

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroudImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroudImageView];
        _playVedioImageView = [[UIImageView alloc] init];
        [_backgroudImageView addSubview:_playVedioImageView];
        
        [self addTarget:self action:@selector(PlayVedio:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
    }];
    _backgroudImageView.backgroundColor = [UIColor lightGrayColor];
    
    [_playVedioImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_backgroudImageView.mas_centerX);
        make.centerY.mas_equalTo(self->_backgroudImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    _playVedioImageView.image = [UIImage imageNamed:@"start"];
}

- (void)PlayVedio:(UIButton *)button {
    if (_motiveVideoAction) {
        self.motiveVideoAction(button);
    }
}
@end
