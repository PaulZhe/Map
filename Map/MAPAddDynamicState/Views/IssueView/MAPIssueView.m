//
//  MAPIssueView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPIssueView.h"
#import <Masonry.h>

@implementation MAPIssueView

- (instancetype) init {
    self = [super init];
    if (self) {
        _commentButton = [[MAPIssueButton alloc] init];
        [self addSubview:_commentButton];
        _picturesButton = [[MAPIssueButton alloc] init];
        [self addSubview:_picturesButton];
        _audioButton = [[MAPIssueButton alloc] init];
        [self addSubview:_audioButton];
        _vedioButton = [[MAPIssueButton alloc] init];
        [self addSubview:_vedioButton];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(100, 130));
    }];
    _commentButton.layer.masksToBounds = YES;
    _commentButton.layer.cornerRadius = 50;
    [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    _commentButton.nameLabel.text = @"评论";
    _commentButton.tag = 101;
    [_commentButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_picturesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(100, 130));
    }];
    _picturesButton.layer.masksToBounds = YES;
    _picturesButton.layer.cornerRadius = 50;
    [_picturesButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    _picturesButton.nameLabel.text = @"图片";
    _picturesButton.tag = 102;
    [_picturesButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_commentButton.mas_bottom).mas_equalTo(-5);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(100, 130));
    }];
    _audioButton.layer.masksToBounds = YES;
    _audioButton.layer.cornerRadius = 50;
    [_audioButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    _audioButton.nameLabel.text = @"语音";
    _audioButton.tag = 103;
    [_audioButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_vedioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_picturesButton.mas_bottom).mas_equalTo(-5);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(100, 130));
    }];
    _vedioButton.layer.masksToBounds = YES;
    _vedioButton.layer.cornerRadius = 50;
    [_vedioButton setImage:[UIImage imageNamed:@"video"] forState:UIControlStateNormal];
    _vedioButton.nameLabel.text = @"视频";
    _vedioButton.tag = 104;
    [_vedioButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickedButton:(UIButton *)button {
    _btnAction(button.tag);
}

@end
