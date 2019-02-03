//
//  MAPAddPicturesView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/3.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddPicturesView.h"
#import <Masonry.h>
#import <QuartzCore/QuartzCore.h>

@implementation MAPAddPicturesView

- (instancetype) init {
    self = [super init];
    if (self) {
        _hintLabel = [[UILabel alloc] init];
        [self addSubview:_hintLabel];
        _hintLabel.text = @"添加标题...";
        
        _addTitleTextField = [[UITextField alloc] init];
        [self addSubview:_addTitleTextField];
        _addTitleTextField.borderStyle = UITextBorderStyleNone;
        _addTitleTextField.layer.cornerRadius = 15;
        _addTitleTextField.layer.borderWidth = 2.0f;
        _addTitleTextField.layer.borderColor = [UIColor colorWithRed:0.14f green:0.14f blue:0.14f alpha:1.00f].CGColor;
//        _addTitleTextField.leftView = view;
//        _addTitleTextField.leftViewMode = UITextFieldViewModeAlways;
        
        _addPicturesView = [[UIView alloc] init];
        [self addSubview:_addPicturesView];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_equalTo(10);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];

    [_addTitleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_hintLabel.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];

    [_addPicturesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_addTitleTextField.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(0);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
}

@end
