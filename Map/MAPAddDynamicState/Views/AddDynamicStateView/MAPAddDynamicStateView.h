//
//  MAPAddDynamicStateView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPAddCommentView.h"
#import "MAPAddPicturesView.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddDynamicStateView : UIView
@property (nonatomic, strong) BMKMapView *mapView;//显示地图
@property (nonatomic, strong) UIView *addDynamicStateView;//添加动态
@property (nonatomic, strong) UILabel *locationNameLabel;//地点名称
@property (nonatomic, strong) UIButton *adjustmentButton;//地点微调按钮
@property (nonatomic, strong) UIView *lineView;//分界线
@property (nonatomic, strong) UIButton *issueButton;//发布按钮
//不同界面对应不同的view
@property (nonatomic, strong) MAPAddCommentView *addCommentView; //添加评论输入框
@property (nonatomic, strong) MAPAddPicturesView *addPicturesView; //添加图片输入框
@property (nonatomic, strong) UIView *addAndioView;//添加语音s录入框
@property (nonatomic, strong) UIView *addVedioView;//添加视频界输入框

//重写view的init方法
- (instancetype) initWithTypeString:(NSString *) typeString;
@end

NS_ASSUME_NONNULL_END
