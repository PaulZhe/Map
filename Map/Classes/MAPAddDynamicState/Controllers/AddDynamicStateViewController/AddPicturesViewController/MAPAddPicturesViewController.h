//
//  MAPAddPicturesViewController.h
//  Map
//
//  Created by _祀梦 on 2019/6/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPAddPicturesView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MAPAddPicturesViewController : UIViewController <MAPAddPicturesViewDelegate>
@property (nonatomic, assign) double Latitude;
@property (nonatomic, assign) double Longitud;//记录点的位置
@property (nonatomic, copy) NSString *pointName;
@property (nonatomic, assign) int ID;//如果没有发布点，ID为0
@property (nonatomic, assign) bool isSelected;//记录主界面点击发布按钮跳转过来时是否有发布点
@end

NS_ASSUME_NONNULL_END
