//
//  MAPMotiveAudioButton.m
//  Map
//
//  Created by 涂强尧 on 2019/1/26.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPMotiveAudioButton.h"
#import <Masonry.h>

@implementation MAPMotiveAudioButton

- (id)init {
    self = [super init];
    if (self) {
        self.audioImageView = [[UIImageView alloc] init];
        [self addSubview:_audioImageView];
        
        self.timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f];
    [_audioImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_equalTo(5);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        make.width.mas_equalTo(self.frame.size.height - 10);
        make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-5);
    }];
    _audioImageView.image = [UIImage imageNamed:@"sound"];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.audioImageView.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.6);
    }];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:12];
}

//重写button的点击事件方法
- (void) addTapBlock:(buttonBlock) block {
    _block = block;
    [self addTarget:self action:@selector(PlayAudio:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)PlayAudio:(UIButton *) button {
    _block(button);
}

@end
