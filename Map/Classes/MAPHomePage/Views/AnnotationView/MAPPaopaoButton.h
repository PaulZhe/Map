//
//  MAPPaopaoButton.h
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^buttonBlock)(UIButton *sender);

@interface MAPPaopaoButton : UIButton
@property (nonatomic, strong) UILabel *countLabel;//评论数量
@property (nonatomic, copy) buttonBlock block;
- (void)addTapBlock:(buttonBlock)block;
@end

NS_ASSUME_NONNULL_END