//
//  MAPIssueAudioView.m
//  Map
//
//  Created by 小哲的DELL on 2019/5/9.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPIssueAudioView.h"
#import <Masonry.h>

static const float kMotiveAudioButtonFromLeft = 30.0;
static const float kMotiveAudioButtonFromTop = 20.0;
static const float kMotiveAudioButtonHeight = 35.0;

@implementation MAPIssueAudioView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.motiveAudioButton = [[MAPMotiveAudioButton alloc] init];
        [self addSubview:_motiveAudioButton];
        
        self.audioRecordUtils = [[MAPAudioRecordUtils alloc] init];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.motiveAudioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(kMotiveAudioButtonFromLeft);
        make.top.mas_equalTo(self.mas_top).offset(kMotiveAudioButtonFromTop);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
        make.height.mas_equalTo(kMotiveAudioButtonHeight);
    }];
}

@end
