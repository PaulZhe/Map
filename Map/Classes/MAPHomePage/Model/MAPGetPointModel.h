//
//  MAPGetPointModel.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/26.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"
#import "MAPAddPointModel.h"

@protocol MAPPointItemModel

@end

@interface MAPPointItemModel : JSONModel

@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, assign) int createBy;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) long mesCount;
@property (nonatomic, assign) long phoCount;
@property (nonatomic, assign) long audCount;
@property (nonatomic, assign) long vidCount;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, copy) NSString *pointName;

@end

@interface MAPGetPointModel : MAPAddPointModel

@property (nonatomic, copy) NSArray <Optional, MAPPointItemModel>* data;

@end
