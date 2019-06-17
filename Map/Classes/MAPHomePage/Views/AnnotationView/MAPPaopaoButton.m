//
//  MAPPaopaoButton.m
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPPaopaoButton.h"

@implementation MAPPaopaoButton

- (instancetype)init {
    self = [super init];
    if (self) {
//        __weak MAPPaopaoButton *weakSelf = self;
//        [self addTarget:weakSelf action:@selector(addingMotion:) forControlEvents:UIControlEventTouchUpInside];
        
        _countLabel = [[UILabel alloc] init];
        [self addSubview:_countLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _countLabel.frame = CGRectMake(29, -12, 22, 22);
    _countLabel.backgroundColor = [UIColor colorWithRed:0.76f green:0.22f blue:0.15f alpha:1.00f];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.layer.masksToBounds = YES;
    _countLabel.layer.cornerRadius = 11;
    _countLabel.textAlignment = NSTextAlignmentCenter;
}

//- (void)addingMotion:(UIButton *)button {
//    self.paopaoButtonAction(button);
//}

@end
