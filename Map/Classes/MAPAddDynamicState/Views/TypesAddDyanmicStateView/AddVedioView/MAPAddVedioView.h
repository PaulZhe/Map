//
//  MAPAddVedioView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/7.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MAPAddVedioViewDelegate <NSObject>
//键盘的弹出与消失
- (void) keyboardWillAppearOrWillDisappear:(NSString *) appearOrDisappearString AndKeykeyboardHeight:(CGFloat) keyboardHeight;
@end

@interface MAPAddVedioView : UIView <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *hintLabel;//提示添加标题
@property (nonatomic, strong) UITextField *addTitleTextField;//添加标题输入框
@property (nonatomic, strong) UILabel *countLabel;//输入框字数限制
@property (nonatomic, strong) UIView *addVedioView;//添加视频
@property (nonatomic, strong) UIButton *addVedioButton;//选择视频按钮
@property (nonatomic, weak) id<MAPAddVedioViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
