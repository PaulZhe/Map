//
//  BNStrategyManagerProtocol.h
//  baiduNaviSDK
//
//  Created by Baidu on 11/10/13.
//  Copyright (c) 2013 baidu. All rights reserved.
//

/**
 *  导航策略管理器协议,包含导航过程中的设置项、电子狗的设置策略以及导航入口记录
 *
 */

#ifndef baiduNaviSDK_BNStrategyManagerProtocol_h
#define baiduNaviSDK_BNStrategyManagerProtocol_h

#import "BNCommonDef.h"

@protocol BNStrategyManagerProtocol

@required

/// 恢复到默认策略
- (void)reset;

/// 停车场推送
@property (nonatomic, assign) BOOL parkInfo;

/// 日夜模式
@property (nonatomic, assign) BNDayNight_CFG_Type dayNightType;

/// 实际的日夜模式 (日 or 夜)
@property (nonatomic, assign) BNDayNight_Type realDayNightType;;

/// 播报模式
@property (nonatomic, assign) BN_Speak_Mode_Enum speakMode;

/// 诱导面板模式
@property (nonatomic, assign) BN_Simple_Guide_Mode simpleGuideMode;

/// 是否显示实景放大图
@property (assign, nonatomic) BOOL showLiveExpandRoadMap;

/// 显示viaduct桥区
@property (nonatomic, assign) BOOL showViaduct;

/// 显示智能比例尺开关
@property (nonatomic, assign) BOOL autoLevelShow;

/// 显示到终点红线开关
@property (nonatomic, assign) BOOL redLineShow;

/// 小窗
@property (nonatomic, assign) BOOL showMapTinyView;

/// 横屏开启
@property (nonatomic, assign) BOOL canLandscape;

/// 是否支持手势旋转，需要在引擎初始化成功后调用，默认YES
@property (nonatomic, assign) BOOL supportRotation;

/// 对底图操作是否需要惯性，需要在引擎初始化成功后调用，默认YES
@property (nonatomic, assign) BOOL operationInertia;

/// 是否开启多路线，需要在算路前设，默认YES
@property (nonatomic, assign) BOOL enableMultiRoute;

/// 是否支持更多设置功能，默认YES
@property (nonatomic, assign) BOOL supportMoreSettings;

/// 导航设置面板是否开放路线偏好功能入口，默认YES
@property (nonatomic, assign) BOOL supportPreference;

/// 导航设置面板是否开放沿途检索功能入口，默认YES
@property (nonatomic, assign) BOOL supportPoiSearch;

/// 导航设置面板是否开放横屏导航功能入口，默认YES
@property (nonatomic, assign) BOOL supportLandscape;

/// 进入导航页面是否需要弹“已连接蓝牙...”toast，默认YES，使用内部TTS播报时有效，否则返回NO
@property (nonatomic, assign) BOOL showBluetoothToast;

/// 是否支持蓝牙设置功能，默认YES，使用内部TTS播报时有效，否则返回NO
@property (nonatomic, assign) BOOL supportBluetoothSettings;

/**
 *  设置路况是否开启，路况开启需要联网，没有网络，开启路况会失败
 *
 *  @param showTraffic 是否显示路况，默认显示
 *  @param success     成功的回调
 *  @param fail        失败的回调
 */
- (void)trySetShowTrafficInNavi:(BOOL)showTraffic success:(void (^)(void))success  fail:(void (^)(void))fail;

/**
 * 设置车牌
 * @param carNumber 车牌号, 格式如:"粤B00000"
 */
- (void)syncCarNumber:(NSString *)carNumber;

/**
 * 获取车牌
 */
- (NSString *)getCarNumber;

/**
 * 开关导航声音
 * @param turnOn 是否开启导航声音
 * @return 开关导航声音是否成功
 */
- (BOOL)soundTurnOn:(BOOL)turnOn;

@end

#endif
