//
//  MAPMotiveVideoButtonView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/30.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPMotiveVideoButtonView : UIView
@property (nonatomic, strong) UIButton *playButton;//播放按钮
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UISlider *videoSlider; //视频进度条
@end

NS_ASSUME_NONNULL_END
