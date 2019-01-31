//
//  MAPIssueView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPIssueButton.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^btnBlock)(NSInteger tag);

@interface MAPIssueView : UIView
@property (nonatomic, strong) MAPIssueButton *commentButton;
@property (nonatomic, strong) MAPIssueButton *picturesButton;
@property (nonatomic, strong) MAPIssueButton *audioButton;
@property (nonatomic, strong) MAPIssueButton *vedioButton;
//点击按钮后的回调方法
@property (nonatomic,strong) btnBlock btnAction;
@end

NS_ASSUME_NONNULL_END
