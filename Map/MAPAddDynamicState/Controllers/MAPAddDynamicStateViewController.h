//
//  MAPAddDynamicStateViewController.h
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPAddDynamicStateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddDynamicStateViewController : UIViewController
@property (nonatomic, strong) MAPAddDynamicStateView *addDynamicStateView;
@property (nonatomic, strong) NSString *typeString;//标记字符串
@end

NS_ASSUME_NONNULL_END
