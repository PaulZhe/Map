//
//  MAPAddPointManager.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/25.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAPAddPointModel.h"

// 成功回调的 block
typedef void(^MAPResultHandle)(MAPAddPointModel *resultModel);
// 失败回调的 block
typedef void(^MAPErrorHandle)(NSError *error);

@interface MAPAddPointManager : NSObject

+ (instancetype)sharedManager;

/**
 上传点坐标的方法
 @param name      坐标点的名字
 @param latitude  纬度
 @param longitude 经度
**/
- (void)addPointWithName:(NSString *)name Latitude:(double)latitude Longitude:(double)longitude success:(MAPResultHandle)successBlock error:(MAPErrorHandle)errorBlock;


@end
