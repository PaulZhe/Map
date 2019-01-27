//
//  MAPMotiveVideoButton.h
//  Map
//
//  Created by 涂强尧 on 2019/1/27.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^buttonBlock)(UIButton *sender);

@interface MAPMotiveVideoButton : UIButton
@property (nonatomic, strong) UIImageView *backgroudImageView;//视频背景图片
@property (nonatomic, strong) UIImageView *playVedioImageView;
@property (nonatomic, copy) buttonBlock block;
- (void)addTapBlock:(buttonBlock)block;
@end

NS_ASSUME_NONNULL_END
