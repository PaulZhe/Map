//
//  MAPIssueButton.m
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPIssueButton.h"
#import <Masonry.h>

@implementation MAPIssueButton

- (instancetype) init {
    self = [super init];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(110);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:15 ];
}

@end
