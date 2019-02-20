//
//  MAPRecommendView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/20.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^btnBlock)(NSInteger tag);

@interface MAPRecommendView : UIView

@property (strong, nonatomic) UIView *transparentView;
@property (strong, nonatomic) UIView *recommendView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subheadLabel;//副标题
@property (nonatomic, strong) UIButton *firstLineButton;
@property (nonatomic, strong) UIButton *secondLineButton;
@property (nonatomic, strong) UIButton *thridLineButton;
@property (nonatomic, strong) UIButton *backButton;//返回按钮
//点击按钮后的回调方法
@property (nonatomic,strong) btnBlock btnAction;
@end

NS_ASSUME_NONNULL_END
