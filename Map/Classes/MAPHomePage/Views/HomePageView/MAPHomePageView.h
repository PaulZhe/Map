//
//  MAPHomePageView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^NavigationButtonClick)(UIButton *sender);
typedef void (^AddButtonClick)(UIButton *sender);

@interface MAPHomePageView : UIView <BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *navigationButton;

@property (nonatomic, copy) NavigationButtonClick navigationAction;
@property (nonatomic, copy) AddButtonClick addButtonAction;

@end

NS_ASSUME_NONNULL_END
