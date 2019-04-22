//
//  MAPAddAudioView.m
//  Map
//
//  Created by 小哲的DELL on 2019/4/9.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPAddAudioView.h"
#import <masonry.h>

@implementation MAPAddAudioView

- (instancetype)init {
    self = [super init];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"长按录制语音";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:22];
        [self addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"00:00";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_timeLabel];
        
        _audioButton = [[UIButton alloc] init];
        _audioButton.tag = 102;
        [_audioButton setImage:[UIImage imageNamed:@"souRed"] forState:UIControlStateNormal];
        [self addSubview:_audioButton];
        [_audioButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_audioButton addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self->_nameLabel.mas_bottom).mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [_audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self->_timeLabel.mas_bottom).mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
}

- (void)buttonClick:(UIButton *)button {
    if (_audioButtonAction) {
        self.audioButtonAction(button);
    }
}

- (void)buttonTouchDown:(UIButton *)button {
    if (_audioTouchDownAction) {
        self.audioTouchDownAction(button);
    }
}

- (void)startRecord {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
}

- (void)startTimer {
    self.seconds++;
    if (_seconds == 60) {
        self.minutes++;
        self.seconds = 0;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d", _minutes, _seconds];
}

- (void)endRecord {
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)reset {
    self.seconds = 0;
    self.minutes = 0;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d", _minutes, _seconds];
}

@end
