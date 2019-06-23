//
//  MAPMotiveReplyView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/11.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPMotiveReplyView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *replyLable1;
@property (nonatomic, strong) UILabel *replyLable2;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UITableView *replyTableView;

@end

NS_ASSUME_NONNULL_END
