//
//  MAPPaopaoButton.m
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPPaopaoButton.h"

@implementation MAPPaopaoButton

- (instancetype) init {
    self = [super init];
    if (self) {
        _countLabel = [[UILabel alloc] init];
        [self addSubview:_countLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _countLabel.frame = CGRectMake(32, -13, 26, 26);
    _countLabel.backgroundColor = [UIColor colorWithRed:0.76f green:0.22f blue:0.15f alpha:1.00f];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.layer.masksToBounds = YES;
    _countLabel.layer.cornerRadius = 13;
    _countLabel.textAlignment = NSTextAlignmentCenter;
}

@end
