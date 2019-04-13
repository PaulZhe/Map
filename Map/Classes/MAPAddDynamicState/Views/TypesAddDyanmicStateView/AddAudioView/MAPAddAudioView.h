//
//  MAPAddAudioView.h
//  Map
//
//  Created by 小哲的DELL on 2019/4/9.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClick)(UIButton *sender);

@interface MAPAddAudioView : UIView

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *audioButton;
@property (nonatomic, copy) ButtonClick audioButtonAction;

@end