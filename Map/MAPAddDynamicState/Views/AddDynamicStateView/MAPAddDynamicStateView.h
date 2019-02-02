//
//  MAPAddDynamicStateView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPAddCommentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddDynamicStateView : UIView
@property (nonatomic, strong) UIView *mapView;//显示地图
@property (nonatomic, strong) UIView *addDynamicStateView;//添加动态
@property (nonatomic, strong) MAPAddCommentView *addCommentView; //添加评论界面
@property (nonatomic, strong) UIView *addPicturesView; //添加图片界面
@property (nonatomic, strong) UIView *addAndioView;//添加语音界面
@property (nonatomic, strong) UIView *addVedioView;//添加视频界面

//重写view的init方法
- (instancetype) initWithTypeString:(NSString *) typeString;
@end

NS_ASSUME_NONNULL_END
