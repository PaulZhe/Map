//
//  MAPGetPointManager.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/26.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAPGetPointModel.h"
#import "MAPCommentModel.h"

// 获取周边point的回调block
typedef void(^MAPGetPointHandle)(MAPGetPointModel *pointModel);
// 定位请求返回评论数据的block
typedef void(^MAPGetCommentHandle)(MAPCommentModel *resultModel);
//// 定位请求返回音频数据的block
//typedef void(^MAPGetAudioHandle)(MAPAudioModel *resultModel);
// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

@interface MAPGetPointManager : NSObject

+ (instancetype)sharedManager;

// 获取周围坐标的方法
- (void)fetchPointWithLongitude:(double)longitude Latitude:(double)latitude Range:(int)range succeed:(MAPGetPointHandle)succeedBlock error:(ErrorHandle)errorBlock;
// 获取坐标点的信息方法
- (void)fetchPointCommentWithPointID:(int)ID type:(int)type succeed:(MAPGetCommentHandle)succeedBlock error:(ErrorHandle)errorBlock;

@end
