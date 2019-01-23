//
//  MAPDynamicStateView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/22.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPDynamicStateView : UIView <UITableViewDataSource>
@property (nonatomic, strong) UITableView *dyanmicStateTableView;
@property (nonatomic, strong) NSString *typeMotiveString; //按钮点击类别
@end

NS_ASSUME_NONNULL_END
