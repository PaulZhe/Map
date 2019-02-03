//
//  MAPAddCommentView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/2.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddCommentView : UIView <UITextViewDelegate>
@property (nonatomic, strong) UITextView *addCommentTextView;//添加评论窗口
@property (nonatomic, strong) UILabel *placeHolderLabel;//自定义文本框placehoder
@property (nonatomic, strong) UILabel *countLabel;//自定义文本框字数统计
@end

NS_ASSUME_NONNULL_END
