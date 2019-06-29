//
//  MAPAddPointManager.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/25.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAPAddPointModel.h"
#import "MAPAddPicturesModel.h"

// 成功回调的 block
typedef void(^MAPResultHandle)(MAPAddPointModel *resultModel);
typedef void(^MAPPicturesResultHandle)(MAPAddPicturesModel *resultModel);
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
- (void)addPointWithName:(NSString *)name
                Latitude:(double)latitude
               Longitude:(double)longitude
                 success:(MAPResultHandle)successBlock
                   error:(MAPErrorHandle)errorBlock;
/**
 上传文字信息的方法
 @param pointId 点的ID
 @param content 信息内容
 */
- (void)addMessageWithPointId:(int)pointId
                      Content:(NSString *)content
                      success:(MAPResultHandle)successBlock
                        error:(MAPErrorHandle)errorBlock;
/**
 *上传图片文件
 *@param pointId       点的ID
 *@param title         图片标题
 *@param fileDataArray 图片数组
 */
- (void)uploadPhotosWithPointId:(int)pointId
                          Title:(NSString *)title
                           Data:(NSArray *)fileDataArray
                        success:(MAPPicturesResultHandle)succeedBlock
                          error:(MAPErrorHandle)errorBlock;
/**
 *上传音频，视频文件
 *@param fileData 添加的数据
 *@param type     数据类型   （2 音频，3 视频)
 *@param pointId  点的ID
 *@param title    文件标题
 */
- (void)uploadAudioWithPointId:(int)pointId
                          Data:(NSData *)fileData
                          Type:(int)type
                        Second:(int)seconds
                       Minutes:(int)minutes
                       success:(MAPResultHandle)succeedBlock
                         error:(MAPErrorHandle)errorBlock;

@end
