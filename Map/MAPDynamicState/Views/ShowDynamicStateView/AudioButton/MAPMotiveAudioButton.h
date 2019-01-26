//
//  MAPMotiveAudioButton.h
//  Map
//
//  Created by 涂强尧 on 2019/1/26.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^buttonBlock)(UIButton *sender);

@interface MAPMotiveAudioButton : UIButton
@property (nonatomic, strong) UIImageView *audioImageView;//语音标签
@property (nonatomic, strong) UILabel *timeLabel;//语音时长
@property (nonatomic, copy) buttonBlock block;
- (void)addTapBlock:(buttonBlock)block;
@end

NS_ASSUME_NONNULL_END
