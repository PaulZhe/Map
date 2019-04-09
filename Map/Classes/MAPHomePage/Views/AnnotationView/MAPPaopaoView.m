//
//  MAPPaopaoView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPPaopaoView.h"
#import <Masonry.h>

@implementation MAPPaopaoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initPaopaoView];
    }
    return self;
}

- (void)initPaopaoView {
    _commentButton = [[MAPPaopaoButton alloc] init];
    _commentButton.countLabel.text = @"2";
    [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    _commentButton.tag = 101;
    [self addSubview:_commentButton];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _picturesButton = [[MAPPaopaoButton alloc] init];
    _picturesButton.countLabel.text = @"2";
    [_picturesButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    _picturesButton.tag = 102;
    [self addSubview:_picturesButton];
    [_picturesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_commentButton.mas_top).mas_equalTo(20);
        make.left.mas_equalTo(self->_commentButton.mas_right).mas_equalTo(2);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _voiceButton = [[MAPPaopaoButton alloc] init];
    _voiceButton.countLabel.text = @"2";
    [_voiceButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    _voiceButton.tag = 103;
    [self addSubview:_voiceButton];
    [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_picturesButton.mas_centerY).mas_equalTo(12);
        make.left.mas_equalTo(self->_picturesButton.mas_right).mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _vedioButton = [[MAPPaopaoButton alloc] init];
    _vedioButton.countLabel.text = @"2";
    [_vedioButton setImage:[UIImage imageNamed:@"video"] forState:UIControlStateNormal];
    _vedioButton.tag = 104;
    [self addSubview:_vedioButton];
    [_vedioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_voiceButton.mas_centerY).mas_equalTo(22);
        make.left.mas_equalTo(self->_voiceButton.mas_right).mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
}

@end
