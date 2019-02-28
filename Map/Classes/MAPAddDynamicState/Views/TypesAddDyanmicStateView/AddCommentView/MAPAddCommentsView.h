//
//  MAPAddCommentsView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/28.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MAPAddCommentViewDelegate <NSObject>
//键盘的弹出与消失
- (void) keyboardWillAppearOrWillDisappear:(NSString *) appearOrDisappearString AndKeykeyboardHeight:(CGFloat) keyboardHeight;
@end

@interface MAPAddCommentsView : UIView <UITextViewDelegate>
@property (nonatomic, strong) UITextView *addCommentTextView;//添加评论窗口
@property (nonatomic, strong) UILabel *placeHolderLabel;//自定义文本框placehoder
@property (nonatomic, strong) UILabel *countLabel;//自定义文本框字数统计
@property (nonatomic, strong) UIView *addPicturesView;//添加图片
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, weak) id<MAPAddCommentViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
