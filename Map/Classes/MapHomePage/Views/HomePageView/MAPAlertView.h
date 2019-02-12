//
//  MAPAlertView.h
//  Map
//
//  Created by 小哲的DELL on 2019/1/30.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnBlock)(NSInteger tag);

@interface MAPAlertView : UIView

//点击按钮后的回调方法
@property (nonatomic,strong) btnBlock btnAction;

@end
