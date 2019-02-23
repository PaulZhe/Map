//
//  MAPIssueView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPIssueView.h"
#import "MAPAlertView.h"
#import <Masonry.h>
@interface MAPIssueView()

@property (strong, nonatomic) UIView *transparentView;

@end

@implementation MAPIssueView

- (instancetype) init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f];

        _commentButton = [MAPIssueButton buttonWithTitle:@"评论" image:[UIImage imageNamed:@"comment"]];
        _commentButton.layer.masksToBounds = YES;
        _commentButton.layer.cornerRadius = 50;
        _commentButton.tag = 101;
        [_commentButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentButton];
        
        _picturesButton = [MAPIssueButton buttonWithTitle:@"图片" image:[UIImage imageNamed:@"image"]];
        _picturesButton.layer.masksToBounds = YES;
        _picturesButton.layer.cornerRadius = 50;
        _picturesButton.tag = 102;
        [_picturesButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_picturesButton];
        
        _audioButton = [MAPIssueButton buttonWithTitle:@"语音" image:[UIImage imageNamed:@"voice"]];
        _audioButton.layer.masksToBounds = YES;
        _audioButton.layer.cornerRadius = 50;
        _audioButton.tag = 103;
        [_audioButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_audioButton];
        
        _vedioButton = [MAPIssueButton buttonWithTitle:@"视频" image:[UIImage imageNamed:@"video"]];
        _vedioButton.layer.masksToBounds = YES;
        _vedioButton.layer.cornerRadius = 50;
        _vedioButton.tag = 104;
        [_vedioButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_vedioButton];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(issueButtonWidth, issueButtonHeight));
    }];
    
    [_picturesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(issueButtonWidth, issueButtonHeight));
    }];
    
    [_audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_commentButton.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(issueButtonWidth, issueButtonHeight));
    }];
    
    [_vedioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_picturesButton.mas_bottom).mas_equalTo(5);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(issueButtonWidth, issueButtonHeight));
    }];
    
}

- (void) clickedButton:(UIButton *)button {
//    for (id obj in self.superview.subviews) {
//        if ([obj isMemberOfClass:[MAPAlertView class]]) {
//            [obj removeFromSuperview];
//            [self removeFromSuperview];
//        }
//    }
    _btnAction(button.tag);
}

@end
