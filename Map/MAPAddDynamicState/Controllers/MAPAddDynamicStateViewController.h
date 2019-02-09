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
@property (nonatomic, strong) MAPAddDynamicStateView *addDynamicStateView;
@property (nonatomic, strong) NSString *typeString;//标记字符串
@property (nonatomic, assign) double Latitude;
@property (nonatomic, assign) double Longitud;//记录点的位置
@property (nonatomic, strong) BMKPoiSearch *poiSearch;//POI城市检索对象
@end


NS_ASSUME_NONNULL_END
