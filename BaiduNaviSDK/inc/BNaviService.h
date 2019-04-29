//
//  BNaviService.h
//  
//
//  Created by chenxintao on 2017/11/21.
//

#ifndef BNaviService_h
#define BNaviService_h

#import <Foundation/Foundation.h>
#import "BNMapManagerProtocol.h"
#import "BNRoutePlanManagerProtocol.h"
#import "BNStrategyManagerProtocol.h"
#import "BNUIManagerProtocol.h"
#import "BNLocationManagerProtocol.h"
#import "BNSoundProtocol.h"
#import "BNMapOverlayProtocol.h"

//调用者可以直接使用这部分宏
#define BNaviService_Instance           ([BNaviService getInstance])
#define BNaviService_UI                 ([BNaviService_Instance uiManager])
#define BNaviService_RoutePlan          ([BNaviService_Instance routePlanManager])
#define BNaviService_Strategy           ([BNaviService_Instance strategyManager])
#define BNaviService_Location          ([BNaviService_Instance locationManager])
#define BNaviService_Map                ([BNaviService_Instance mapManager])
#define BNaviService_Sound              ([BNaviService_Instance soundManager])
#define BNaviService_MapOverlay       ([BNaviService_Instance mapOverlayManager])

#define BNGetNaviVC ((UINavigationController*)[BNaviService_UI navigationController])
#define BNGetTopVC [BNGetNaviVC topViewController]

@interface BNaviService : NSObject

/**
 获取导航整体服务单例对象
 
 @return 导航整体服务单例对象
 */
+ (BNaviService *)getInstance;

/**
 *  释放单体
 */
+ (void)releaseInstance;

/**
 获取SDK版本号
 
 @return sdk的版本号
 */
+ (NSString*)sdkVersion;

/**
 初始化导航SDK
 
 @param params 初始化参数
 @param succes 成功回调
 @param fail 失败回调
 */
- (void)initNaviService:(NSDictionary*)params
                success:(dispatch_block_t)succes
                   fail:(dispatch_block_t)fail;

/**
 导航SDK鉴权
 
 @param appKey 地图开放平台上注册的ak
 @param completion 回调
 */
- (void)authorizeNaviAppKey:(NSString *)appKey
                 completion:(void (^)(BOOL suc))completion;

/**
 TTS SDK鉴权（需要到http://yuyin.baidu.com/app注册app）
 
 @param appId appId
 @param apiKey apiKey
 @param secretKey secretKey
 @param completion 回调
 */
- (void)authorizeTTSAppId:(NSString*)appId
                   apiKey:(NSString*)apiKey
                secretKey:(NSString*)secretKey
               completion:(void (^)(BOOL suc))completion;

/**
 *  查询引擎是否初始化完成
 *
 *  @return 是否初始化完成
 */
- (BOOL)isServicesInited;

/**
 *  停止所有服务
 */
- (void)stopServices;

#pragma mark - 获取提供各种服务的实体对象
/**
 *  获取到导航过程页管理器，用于进入退出导航过程页
 *
 *
 *  @return 导航过程页管理器
 */
- (id<BNUIManagerProtocol>)uiManager;

/**
 *  获取路径规划管理器，用于路径规划
 *
 *  @return 路径规划管理器
 */
- (id<BNRoutePlanManagerProtocol>)routePlanManager;

/**
 *  获取策略管理器，用于调整在离线策略、白天黑夜策略、横竖向切换策略等等
 *
 *  @return 策略管理器
 */
- (id<BNStrategyManagerProtocol>)strategyManager;

/**
 *  获取定位服务器，用于获取当前定位
 *
 *  @return 定位服务器
 */
- (id<BNLocationManagerProtocol>)locationManager;

/**
 获取底图服务对象
 
 @return 底图服务对象
 */
- (id<BNMapManagerProtocol>)mapManager;

/**
 获取语音播报管理对象
 
 @return 语音播报管理对象
 */
- (id<BNSoundProtocol>)soundManager;

/**
 获取图层管理实例对象
 
 @return 图层管理实例对象
 */
- (id<BNMapOverlayProtocol>)mapOverlayManager;

@end

#endif /* BNaviService_h */
