//
//  MAPIssueButton.m
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPIssueButton.h"
#import <Masonry.h>

const float issueButtonWidth = 100;
const float issueButtonHeight = 130;

@implementation MAPIssueButton

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image{
    MAPIssueButton *button = [super buttonWithType:UIButtonTypeSystem];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.imageView.contentMode = UIViewContentModeCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    return button;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, issueButtonWidth, issueButtonWidth);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, issueButtonWidth + 2, issueButtonWidth, 20);
}

@end
