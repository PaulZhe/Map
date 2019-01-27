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

- (instancetype) init {
    self = [super init];
    if (self) {
        _backgroudImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroudImageView];
        _playVedioImageView = [[UIImageView alloc] init];
        [_backgroudImageView addSubview:_playVedioImageView];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [_backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
    }];
    _backgroudImageView.backgroundColor = [UIColor lightGrayColor];
    _backgroudImageView.userInteractionEnabled = YES;
    
    [_playVedioImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.backgroudImageView.center);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    _playVedioImageView.image = [UIImage imageNamed:@"start"];
}

//重写button的点击事件方法
- (void) addTapBlock:(buttonBlock) block {
    _block = block;
    [self addTarget:self action:@selector(PlayVedio:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)PlayVedio:(UIButton *) button {
    _block(button);
}
@end
