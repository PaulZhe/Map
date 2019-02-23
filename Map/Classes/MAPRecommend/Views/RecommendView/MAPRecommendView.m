//
//  MAPRecommendView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/20.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPRecommendView.h"
#import <Masonry.h>

@implementation MAPRecommendView

- (instancetype) init {
    self = [super init];
    if (self) {
        _transparentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _transparentView.backgroundColor= [UIColor colorWithWhite:0 alpha:0.25];
        [self addSubview:_transparentView];
        
        _recommendView = [[UIView alloc] init];
        _recommendView.layer.cornerRadius = 15;
        _recommendView.layer.borderWidth = 1.0f;
        _recommendView.layer.borderColor = [UIColor colorWithRed:0.94f green:0.27f blue:0.27f alpha:1.00f].CGColor;
        _recommendView.backgroundColor = [UIColor whiteColor];
        [_transparentView addSubview:_recommendView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:22];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 0;
        _nameLabel.text = @"欢迎来到西安邮电大学长安校区!";
        [_recommendView addSubview:_nameLabel];
        
        _subheadLabel = [[UILabel alloc] init];
        _subheadLabel.text = @"我们现在有3条优秀参观线路为你推荐";
        _subheadLabel.font = [UIFont systemFontOfSize:17];
        _subheadLabel.textAlignment = NSTextAlignmentCenter;
        [_recommendView addSubview:_subheadLabel];
        
        _firstLineButton = [[UIButton alloc] init];
        _firstLineButton.tag = 101;
        _firstLineButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_firstLineButton setTitle:[NSString stringWithFormat:@"路线1"] forState:UIControlStateNormal];
        [_firstLineButton setTitleColor:[UIColor colorWithRed:0.94f green:0.27f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
        [_firstLineButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_recommendView addSubview:_firstLineButton];
        
        _secondLineButton = [[UIButton alloc] init];
        _secondLineButton.tag = 102;
        _secondLineButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_secondLineButton setTitle:[NSString stringWithFormat:@"路线2"] forState:UIControlStateNormal];
        [_secondLineButton setTitleColor:[UIColor colorWithRed:0.94f green:0.27f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
        [_secondLineButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_recommendView addSubview:_secondLineButton];
        
        _thridLineButton = [[UIButton alloc] init];
        _thridLineButton.tag = 103;
        _thridLineButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_thridLineButton setTitle:[NSString stringWithFormat:@"路线3"] forState:UIControlStateNormal];
        [_thridLineButton setTitleColor:[UIColor colorWithRed:0.94f green:0.27f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
        [_thridLineButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_recommendView addSubview:_thridLineButton];
        
        _backButton = [[UIButton alloc] init];
        _backButton.tag = 104;
        _backButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_backButton setTitle:[NSString stringWithFormat:@"不了，谢谢"] forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor colorWithRed:0.94f green:0.27f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_recommendView addSubview:_backButton];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    [_recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).mas_offset(40);
        make.right.mas_equalTo(self.mas_right).mas_offset(-40);
        make.height.mas_equalTo(self->_recommendView.mas_width).multipliedBy(1.1);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_recommendView.mas_top).mas_offset(50);
        make.left.mas_equalTo(self->_recommendView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self->_recommendView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(60);
    }];

    [_subheadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_nameLabel.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self->_recommendView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self->_recommendView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(20);
    }];

    [_firstLineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_subheadLabel.mas_bottom).mas_offset(45);
        make.left.mas_equalTo(self->_recommendView.mas_left).mas_offset(60);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];

    [_secondLineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_subheadLabel.mas_bottom).mas_offset(45);
        make.right.mas_equalTo(self->_recommendView.mas_right).mas_offset(-60);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];

    [_thridLineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_firstLineButton.mas_bottom).mas_offset(50);
        make.left.mas_equalTo(self->_recommendView.mas_left).mas_offset(60);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];

    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_secondLineButton.mas_bottom).mas_offset(50);
        make.centerX.mas_equalTo(self->_secondLineButton.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
}

- (void) ClickedButton:(UIButton *) button {
    _btnAction(button.tag);
}

@end
