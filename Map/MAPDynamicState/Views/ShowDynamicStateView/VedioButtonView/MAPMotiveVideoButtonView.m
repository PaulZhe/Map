//
//  MAPMotiveVideoButtonView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/30.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPMotiveVideoButtonView.h"
#import <Masonry.h>

@implementation MAPMotiveVideoButtonView

- (instancetype) init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.54f green:0.54f blue:0.54f alpha:0.50f];
        _playButton = [[UIButton alloc] init];
        [self addSubview:_playButton];
        _videoSlider = [[UISlider alloc] init];
        [self addSubview:_videoSlider];
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-10);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-20);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(20);
    }];
    _timeLabel.text = @"00:00";
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:15];
    
    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.timeLabel.mas_top);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-10);
        make.height.mas_equalTo(20.0);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}

@end
