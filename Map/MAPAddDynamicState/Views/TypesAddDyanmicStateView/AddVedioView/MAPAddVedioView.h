//
//  MAPAddVedioView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/7.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddVedioView : UIView <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *hintLabel;//提示添加标题
@property (nonatomic, strong) UITextField *addTitleTextField;//添加标题输入框
@property (nonatomic, strong) UILabel *countLabel;//输入框字数限制
@property (nonatomic, strong) UIView *addVedioView;//添加视频
@end

NS_ASSUME_NONNULL_END
