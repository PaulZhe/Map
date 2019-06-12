//
//  MAPAddDynamicStateViewController.h
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPAddDynamicStateView.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddDynamicStateViewController : UIViewController <BMKMapViewDelegate, BMKPoiSearchDelegate>
@property (nonatomic, strong, nullable) MAPAddDynamicStateView *addDynamicStateView;
@property (nonatomic, strong) NSString *typeString;//标记字符串
@property (nonatomic, assign) double Latitude;
@property (nonatomic, assign) double Longitud;//记录点的位置
@property (nonatomic, assign) bool isSelected;//记录主界面点击发布按钮跳转过来时是否有发布点
@property (nonatomic, assign) int ID;//如果没有发布点，ID为0
@property (nonatomic, copy) NSString *pointName;
@end



NS_ASSUME_NONNULL_END
