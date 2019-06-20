//
//  BNaviModel.h
//  NaviDemo
//
//  Created by ssh on 16/12/20.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRoutePlanModel.h"
#import "BNNaviProtocol.h"

@interface BNaviModel : NSObject

/**
 *  当前的导航controller
 */
@property (nonatomic, weak, readonly) UIViewController *naviViewController;

@property (nonatomic, assign, readonly) BNaviStatus status; /**< 底图状态 */

@property (nonatomic, assign, readonly) BNRoadType mapRoadType; /**< 主辅路桥上下当前可执行的操作 */

<<<<<<< Updated upstream
@property (nonatomic, assign) BOOL playDingVoice;   /**< 是否播放偏航叮的声音，使用内部TTS播报时有效，否则返回NO */
=======
@property (nonatomic, assign) BOOL playDingVoice;   /**< 是否播放偏航叮的声音 */
>>>>>>> Stashed changes

/**
 *  获取导航Model单例，该单例不可以释放
 */
+ (BNaviModel*)getInstance;

/**
 *  添加BNaviModel监听
 *  @param listener 监听者
 */
- (void)addNaviModelListener:(id<BNaviModelDelegate>)listener;

/**
 *  移除BNaviModel监听
 *  @param listener 监听者
 */
- (void)removeNaviModelListener:(id<BNaviModelDelegate>)listener;

/**
 *  添加BNaviView监听
 *  @param listener 监听者
 */
- (void)addNaviViewListener:(id<BNaviViewDelegate>)listener;

/**
 *  移除BNaviView监听
 *  @param listener 监听者
 */
- (void)removeNaviViewListener:(id<BNaviViewDelegate>)listener;

/**
 *  退出导航
 */
-(void)exitNavi;

/**
 *  导航中改变终点
 *
 *  @param endNode  要切换的终点
 */
- (void)resetNaviEndPoint:(BNRoutePlanNode *)endNode;

/**
 *  导航中添加途经点
 *
 *  @param viaNode 要添加的途经点
 */
- (void)addViaPoint:(BNRoutePlanNode *)viaNode;

/**
 *  导航中添加途经点
 *
 *  @param viaNodes 要添加的途经点
 */
- (void)addViaPoints:(NSArray<BNRoutePlanNode *> *)viaNodes;

/**
 * 导航中发起重新算路
 *
 * @param eMode 算路方式，定义见BNRoutePlanMode
 * @param naviNodes 算路节点数组，起点、途经点、终点按顺序排列，节点信息为BNRoutePlanNode结构
 * @param userInfo 用户需要传入的参数
 */
- (void)reCalculateRoutePlan:(BNRoutePlanMode)eMode
                   naviNodes:(NSArray<BNRoutePlanNode *> *)naviNodes
                    userInfo:(NSDictionary *)userInfo;

/**
 * 进入一键全览模式
 */
- (void)mapEnterViewAllMode;

/**
 * 退出一键全览模式
 */
- (void)mapExitViewAllMode;

/**
 * 更换路线偏好
 */
- (void)mapReRoutePlanWithNewRoutePlanMode:(BNRoutePlanMode)eMode;

/**
 * 主辅路切换（桥上桥下切换)
 * @param type 切换类型，只能传入 BNRoadType_MainRoad、BNRoadType_SideRoad、BNRoadType_OnBridge、BNRoadType_UnderBridge
 * @return 是否切换成功
 */
- (BOOL)mapMainSlaveViaductChangeTo:(BNRoadType)type;

/**
 * 导航视角模式切换 (跟随车头/正北)
 * @param status 视角模式，这里只能传BNaviStatus2D和BNaviStatus3D，传其他值无效
 */
- (void)setViewModel:(BNaviStatus)status;

/**
 * 沿途搜索
 * @param keyWord 沿途搜索关键字
 */
- (void)viaSearchWithKeyWord:(NSString *)keyWord;

/**
 * 添加沿途搜索得到的途经点
 * @param poiInfo 途经点信息
 */
- (void)addViaSearchPoint:(BMSearchPoiInfo *)poiInfo;

/**
 * 清空沿途搜索的结果
 */
- (void)clearViaSearchPoint;

@end
