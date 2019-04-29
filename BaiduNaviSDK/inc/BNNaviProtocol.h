//
//  BNNaviProtocol.h
//  NaviDemo
//
//  Created by linbiao on 2019/3/20.
//  Copyright © 2019年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNNaviMessageInfo.h"

NS_ASSUME_NONNULL_BEGIN

@class BNaviModel;

@protocol BNaviModelDelegate <NSObject>

@optional
/**
 * 导航中更改路线成功
 */
- (void)reCalculateNaviRouteDidFinished:(BNaviModel *)model sourceType:(BNCalculateSourceType)sourceType;

/**
 * 导航中更改路线失败
 */
- (void)reCalculateNaviRouteDidFailed:(BNaviModel *)model sourceType:(BNCalculateSourceType)sourceType;

/**
 * 导航中取消更改路线
 */
- (void)reCalculateNaviRouteDidCancel:(BNaviModel *)model sourceType:(BNCalculateSourceType)sourceType;

/**
 * 沿途搜索结果
 * @param code 沿途搜索结果
 * @param poiArray 当code为BNaviSearch_ResultCode_Succeed时，poiArray返回搜索结果
 */
- (void)viaSearchResult:(BNaviSearch_ResultCode_ENUM)code poiArray:(NSArray *)poiArray;

/**
 * 清空沿途搜索结果
 */
- (void)viaSearchClearResult;

/**
 *  回调规避提示
 *
 *  @param tips 规避提示
 */
- (void)onHandleNaviLocalRouteTips:(NSString *)tips;

/**
 *  导航中白天黑夜模式变化回调
 *
 *  @param dayNightType 当前白天黑夜模式
 */
- (void)onHandleDayNightTypeChange:(BNDayNight_Type)dayNightType;

/**
 *  GPS速度变化回调
 *
 *  @param speed GPS速度
 */
- (void)onHandleGPSSpeedChange:(BNKMNaviSpeed *)speed;

/**
 *  处理导航状态变化接口
 *
 *  @param naviStatusInfo 导航状态信息
 *  ------------------
 *  Interface to handle the change of navigation status
 *
 *  @param naviStatusInfo : the information of navigation status
 */
- (void)onHandleNaviStatusChange:(BNaviStatusInfo*)naviStatusInfo;

/**
 *  处理建议诱导消息接口
 *
 *  @param simpleGuideInfo 简易诱导消息
 *  -------------------
 *  Interface to handle guidance of navigation
 *
 *  @param simpleGuideInfo  Guidance information
 */
- (void)onHandleSimpleGuideInfo:(BNaviSimpleGuideInfo*)simpleGuideInfo;

/**
 *  简易诱导消息隐藏
 *
 *  @param simpleGuideInfo 简易诱导消息
 *  -------------------
 *  Interface to handle guidance of navigation
 *
 *  @param simpleGuideInfo  Guidance information
 */
- (void)onHandleSimpleGuideInfoHide:(BNaviSimpleGuideInfo*)simpleGuideInfo;

/**
 *  处理路口放大图消息
 *
 *  @param rasterExpandMap 路口放大图信息
 *  -------------------
 *  Interface to handle 3D junctions real enlargement
 *
 *  @param rasterExpandMap : Information for 3D junctions real enlargement
 */
- (void)onHandleRasterExpandMap:(BNaviRasterExpandMap*)rasterExpandMap;

/**
 *  处理当前路名变化接口
 *
 *  @param curRoadName 当前路名信息
 *  -------------------
 *  Interface to handle current road name
 *
 *  @param curRoadName : current road name
 */
- (void)onHandleCurrentRoadName:(BNaviCurrentRoadName*)curRoadName;

/**
 *  处理剩余信息
 *
 *  @param remainInfo 剩余信息
 *  -------------------
 *  Interface to handle remain distance and time
 *
 *  @param remainInfo : Information for remain distance and time
 */
- (void)onHandleRemainInfo:(BNaviRemainInfo*)remainInfo;

/**
 *  处理剩余红绿灯信息
 *
 *  @param remainInfo 剩余红绿灯信息
 *  -------------------
 *  Interface to handle remain traffic lights
 *
 *  @param remainTrafficlightsInfo : Information for remain traffic lights
 */
- (void)onHandleRemainTrafficlightsInfo:(BNaviRemainTrafficlightsInfo*)remainTrafficlightsInfo;

/**
 *  处理gps状态变化
 *
 *  @param gpsChangeInfo gps状态
 *  -------------------
 *  Interface to handle gps change
 *
 *  @param gpsChangeInfo : Information of gps change
 */
- (void)onHandleGPSChange:(BNaviGPSChange*)gpsChangeInfo;

/**
 *  处理主辅路切换提示信息
 *
 *  @param mainSlave 主辅路信息
 *  -------------------
 *  Interface to handle circuit switching (main road <--> auxiliary road)
 *
 *  @param mainSlave : Information for circuit switching
 */
- (void)onHandleMainSlave:(BNaviMainSlave*)mainSlave;

/**
 *  处理矢量放大图消息
 *
 *  @param vectorExpandMap 矢量放大图信息
 *  -------------------
 *  Interface to handle vector diagram enlargement
 *
 *  @param vectorExpandMap : Information for vector diagram enlargement
 */
- (void)onHandleVectorExpandMap:(BNaviVectorExpandMap*)vectorExpandMap;

/**
 *  处理高速面板消息
 *
 *  @param highWayBoard 高速面板消息类型
 */
- (void)onHandleHighWayBoard:(BNaviHighwayBoard*)highWayBoard;

/**
 *  处理高速入口消息
 *
 *  @param inHighWayBoard 高速入口消息
 */
- (void)onHandleInHighwayBoard:(BNaviInHighwayBoard *)inHighwayBoard;

/**
 *  处理方向看板消息
 *
 *  @param exitFastwayBoard 方向看板消息
 */
- (void)onHanldeDirectionBoard:(BNaviDirectionBoard *)directionBoard;

/**
 *  处理地图刷新相关信息
 *
 *  @param mapRefreshInfo 地图刷新消息
 *  --------------------
 *  Interface to handle refresh of map
 *
 *  @param mapRefreshInfo : Information for map refresh
 */
- (void)onHandleMapRefresh:(BNaviMapRefreshInfo*)mapRefreshInfo;

/**
 *  在线主辅路切换
 *
 *  @param param 在线主辅路切换消息
 */
- (void)onHandleMainSlaveOnline:(BNNaviMsgBase *)param;

/**
 *  高架桥，主辅路切换结果消息
 *
 *  @param msg 高架桥主辅路切换消息
 */
- (void)onHandleMainSlaveViaductInfoResult:(BNNaviMsgBase*)msg;

/**
 *  车道线显隐变化
 *
 *  @param param 车道线显隐变化消息
 */
- (void)onHandleNaviLaneInfoChanged:(BNNaviMsgBase *)param;

/**
 *  经过途经点消息
 *
 *  @param passiViaInfo 途经点消息
 */
- (void)onHandlePassViaPoint:(BNaviPassViaPointInfo *)passViaInfo;

@end


@protocol BNaviViewDelegate <NSObject>

@optional
/**
 *  诱导面板点击事件回调
 */
- (void)onHandleGuideViewDidTap;

/**
 *  诱导面板双击事件回调
 */
- (void)onHandleGuideViewDidDoubleTap;

/**
 *  诱导面板转向图标点击事件回调
 */
- (void)onHandleGuideViewTurnIconDidTap;

/**
 *  全览小窗点击事件回调
 */
- (void)onHandleTinyMapViewDidTap;

/**
 *  全览按钮点击事件回调
 */
- (void)onHandleViewAllButtonDidTap;

/**
 *  底部工具栏点击事件回调
 */
- (void)onHandleBottomToolBarDidTap;

/**
 *  退出按钮点击事件回调
 */
- (void)onHandleExitButtonDidTap;


@end

NS_ASSUME_NONNULL_END
