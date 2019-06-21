//
//  MAPShowReplyViewController.h
//  Map
//
//  Created by _祀梦 on 2019/6/14.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPDynamicStateView.h"
#import "MAPHomePageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPShowReplyViewController : UIViewController
@property (nonatomic, strong) MAPDynamicStateView *dynamicStateView;
//接收主页传来的类型值，并传给View
@property (nonatomic, strong) NSString *typeMotiveString;
@property (nonatomic, copy) void (^callBlock)(void);
@end

NS_ASSUME_NONNULL_END
