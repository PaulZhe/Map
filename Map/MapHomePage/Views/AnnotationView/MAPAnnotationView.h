//
//  MAPAnnotationView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import "MAPPaopaoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPAnnotationView : BMKAnnotationView
@property (nonatomic, readonly) MAPPaopaoView *paopaoView;
@end

NS_ASSUME_NONNULL_END
