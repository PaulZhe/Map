//
//  MAPGetMessageCountModel.h
//  Map
//
//  Created by 小哲的dell on 2019/6/4.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"
#import "MAPAddPointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPGetMessageCountItemModel : JSONModel

@property (nonatomic, assign) long pointID;
@property (nonatomic, assign) long mesCount;
@property (nonatomic, assign) long phoCount;
@property (nonatomic, assign) long audCount;
@property (nonatomic, assign) long vidCount;

@end

@interface MAPGetMessageCountModel : MAPAddPointModel

@property (nonatomic, copy) MAPGetMessageCountItemModel *data;

@end

NS_ASSUME_NONNULL_END
