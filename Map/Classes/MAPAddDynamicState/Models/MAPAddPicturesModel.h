//
//  MAPAddPicturesModel.h
//  Map
//
//  Created by 小哲的dell on 2019/6/29.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"
#import "MAPAddPointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddPicturesModel : MAPAddPointModel

@property (nonatomic, copy) NSArray <Optional> *data;

@end

NS_ASSUME_NONNULL_END
