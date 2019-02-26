//
//  MAPAddPointModel.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/25.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"

@interface MAPAddPointModel : JSONModel

@property (nonatomic, assign) NSUInteger status;
@property (nonatomic, copy) NSString <Optional> *message;
@property (nonatomic, copy) NSString <Optional> *data;

@end
