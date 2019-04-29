//
//  BNCommonDef.h
//  baiduNaviSDK
//
//  Created by Baidu on 11/12/13.
//  Copyright (c) 2013 baidu. All rights reserved.
//

#ifndef baiduNaviSDK_BNCommonDef_h
#define baiduNaviSDK_BNCommonDef_h

extern NSString * const BNLoadingTextKey;   /**> loading文案的Key */
extern NSString * const BNSuccessTextKey;   /**> 成功文案的Key */
extern NSString * const BNFailedTextKey;    /**> 失败文案的Key */

extern NSString *const kBNaviReCalculateRoutePlaning;       // 重新算路中
extern NSString *const kBNaviReCalculateRoutePlanSuccess;   // 重新算路成功
extern NSString *const kBNaviReCalculateRoutePlanFailed;    // 重新算路失败

typedef enum{
    //    算路相关参数错误（5000开始）
    BNAVI_ROUTEPLAN_ERROR_INVALIDSTARTENDNODE = 5000,   //请设置完整的起终点
    BNAVI_ROUTEPLAN_ERROR_INPUTERROR = 5001,    //节点输入有误
    BNAVI_ROUTEPLAN_ERROR_NODESTOONEAR = 5002,//节点之间距离太近
    
    //    检索错误（5100开始）
    BNAVI_ROUTEPLAN_ERROR_SEARCHFAILED =5100,   //检索失败
    
    //    定位错误（5200开始）
    BNAVI_ROUTEPLAN_ERROR_LOCATIONFAILED = 5200,    //获取地理位置失败
    BNAVI_ROUTEPLAN_ERROR_LOCATIONSERVICECLOSED = 5201, //定位服务未开启
    
    //    算路相关网络错误（5030开始）
    BNAVI_ROUTEPLAN_ERROR_NONETWORK = 5030, //网络不可用
    BNAVI_ROUTEPLAN_ERROR_NETWORKABNORMAL = 5031,//网络异常，尝试联网线路规划失败。自动切换到本地线路规划（客户端预留定义）
    //    算路过程错误（5050开始）
    BNAVI_ROUTEPLAN_ERROR_ROUTEPLANFAILED = 5050, //无法发起算路（客户端请求算路返回id<0）
    BNAVI_ROUTEPLAN_ERROR_SETSTARTPOSFAILED = 5051,//起点失败
    BNAVI_ROUTEPLAN_ERROR_SETENDPOSFAILED = 5052,   //设置终点失败
    BNAVI_ROUTEPLAN_ERROR_WAITAMOMENT = 5054,   //上次算路取消了，需要等一会
    BNAVI_ROUTEPLAN_ERROR_DATANOTREADY = 5055,  //行政区域数据没有
    BNAVI_ROUTEPLAN_ERROR_ENGINENOTINIT = 5056, //引擎未初始化
    BNAVI_ROUTEPLAN_ERROR_LIGHTSEARCHERROR = 5057,//light检索未成功发送
    BNAVI_ROUTEPLAN_ERROR_UNSUPPORTINTERNATIONAL = 5400, // 不支持国际算路
}BNAVI_ROUTEPLAN_ERROR;


/**
 *  路线计算类型
 */
typedef enum
{
    BNRoutePlanMode_Invalid             = 0X00000000 ,      /**<  无效值 */
    BNRoutePlanMode_Recommend           = 0X00000001 ,      /**<  推荐 */
    BNRoutePlanMode_NoHeighWay          = 0X00000004 ,      /**<  不走高速 */
    BNRoutePlanMode_LessToll            = 0X00000008 ,      /**<  少收费 */
    BNRoutePlanMode_LessJam             = 0X00000010 ,      /**<  躲避拥堵 */
    BNRoutePlanMode_SaveTime            = 0X00000100 ,      /**<  时间优先 */
    BNRoutePlanMode_MainRoad            = 0X00000200 ,      /**<  高速优先 */
}BNRoutePlanMode;


/**
 *  播报模式
 */
typedef enum {
    BN_Speak_Mode_High,                /**< 新手模式 */
    BN_Speak_Mode_Mid,                 /**< 专家模式 */
    BN_Speak_Mode_Low,                 /**< 静音模式 */
} BN_Speak_Mode_Enum;


/**
 *  白天，黑夜模式类型
 */
typedef enum
{
    BNDayNight_CFG_Type_Auto,   //自动
    BNDayNight_CFG_Type_Day,    //白天模式
    BNDayNight_CFG_Type_Night,  //黑夜模式
}BNDayNight_CFG_Type;

/**
 * 实际日夜模式
 */
typedef enum
{
    BNDayNight_Type_Day, // 白天
    BNDayNight_Type_Night, // 黑夜
} BNDayNight_Type;

/** 诱导面板模式 **/
typedef enum {
    BN_Simple_Guide_Mode_Classic = 0,      //经典模式（普通模式）
    BN_Simple_Guide_Mode_Concise       //简洁模式
}BN_Simple_Guide_Mode;

/**
 * 主辅路(桥上桥下)可执行的操作
 */
typedef enum {
    BNRoadType_Unable               = 0, // 不能执行切换操作
    BNRoadType_MainRoad                , // 可切换到主路
    BNRoadType_SideRoad                , // 可切换到辅路
    BNRoadType_OnBridge                , // 可切换到桥上
    BNRoadType_UnderBridge             , // 可切换到桥下
    BNRoadType_OnBridge_MainRoad       , // 可切换到桥上、主路
    BNRoadType_OnBridge_SideRoad       , // 可切换到桥上、辅路
    BNRoadType_UnderBridge_SideRoad    , // 可切换到桥下、辅路
} BNRoadType;

//搜索结果枚举
typedef enum _BNaviSearch_ResultCode_ENUM {
    BNaviSearch_ResultCode_Invalid,         // 无效值
    BNaviSearch_ResultCode_NotReady,        // 搜索没有开始
    BNaviSearch_ResultCode_ParamError,      // 搜索输入参数错误
    BNaviSearch_ResultCode_DataNotReady,    // 相应的离线数据包没有下载
    BNaviSearch_ResultCode_Canceled,        // 用户取消搜素
    BNaviSearch_ResultCode_Failed,          // 搜索失败
    BNaviSearch_ResultCode_Succeed,         // 搜索成功
    BNaviSearch_ResultCode_NetNotReachable, // 网络连接无效
    BNaviSearch_ResultCode_Timeout,         // 请求超时
}BNaviSearch_ResultCode_ENUM;

typedef enum {
    BNCalculateSourceTypeChangePreference = 1000,   // 更改偏好设置
    BNCalculateSourceTypeRefreshRoute,              // 刷新路线
    BNCalculateSourceTypeAddViaPoint,               // 添加途经点
    BNCalculateSourceTypeDeleteViaPoint,            // 删除途经点
    BNCalculateSourceTypeAddCarPark,                // 添加停车场
    BNCalculateSourceTypeChangeCarPlateLimit,       // 车牌限行
    BNCalculateSourceTypeChangeDestPoint,
    BNCalculateSourceTypeChangeDestByTeam,          //组队出行修改终点
    BNCalculateSourceTypeRecoverDestPoint,
    BNCalculateSourceTypeResetEndNode,              // 更改终点
    BNCalculateSourceTypeReCalculateRoute,          // 重新规划路线
}BNCalculateSourceType;

/** 路线详情项转向类型 */
typedef enum _BNaviManeuver_Kind_Enum
{
    BNaviManeuver_Kind_Invalid ,                        /**<  无效值 */
    BNaviManeuver_Kind_Front ,                        /**<  直行 */
    BNaviManeuver_Kind_Right_Front ,                    /**<  右前方转弯 */
    BNaviManeuver_Kind_Right ,                        /**<  右转 */
    BNaviManeuver_Kind_Right_Back ,                    /**<  右后方转弯 */
    BNaviManeuver_Kind_Back ,                            /**<  掉头 */
    BNaviManeuver_Kind_Left_Back ,                    /**<  左后方转弯 */
    BNaviManeuver_Kind_Left ,                            /**<  左转 */
    BNaviManeuver_Kind_Left_Front ,                    /**<  左前方转弯 */
    BNaviManeuver_Kind_Ring ,                            /**<  环岛 */
    BNaviManeuver_Kind_RingOut ,                        /**<  环岛出口 */
    BNaviManeuver_Kind_Left_Side ,                    /**<  普通/JCT/SAPA二分歧 靠左 */
    BNaviManeuver_Kind_Right_Side ,                    /**<  普通/JCT/SAPA二分歧 靠右 */
    BNaviManeuver_Kind_Left_Side_Main ,                /**<  左侧走本线 */
    BNaviManeuver_Kind_Branch_Left_Main ,             /**<  靠最左走本线 */
    BNaviManeuver_Kind_Right_Side_Main ,                /**<  右侧走本线 */
    BNaviManeuver_Kind_Branch_Right_Main,             /**<  靠最右走本线 */
    BNaviManeuver_Kind_Center_Main ,                  /**<  中间走本线 */
    BNaviManeuver_Kind_Left_Side_IC ,                    /**<  IC二分歧左侧走IC */
    BNaviManeuver_Kind_Right_Side_IC ,                /**<  IC二分歧右侧走IC */
    BNaviManeuver_Kind_Branch_Left ,                    /**<  普通三分歧/JCT/SAPA 靠最左 */
    BNaviManeuver_Kind_Branch_Right ,                    /**<  普通三分歧/JCT/SAPA 靠最右 */
    BNaviManeuver_Kind_Branch_Center ,                /**<  普通三分歧/JCT/SAPA 靠中间 */
    BNaviManeuver_Kind_Start ,                        /**<  起始地 */
    BNaviManeuver_Kind_Dest ,                            /**<  目的地 */
    BNaviManeuver_Kind_VIA1 ,                            /**<  途径点1 */
    BNaviManeuver_Kind_VIA2 ,                            /**<  途径点2 */
    BNaviManeuver_Kind_VIA3 ,                            /**<  途径点3 */
    BNaviManeuver_Kind_VIA4 ,                            /**<  途径点4 */
    BNaviManeuver_Kind_InFerry ,                        /**<  进入渡口 */
    BNaviManeuver_Kind_OutFerry ,                        /**<  脱出渡口 */
    BNaviManeuver_Kind_TollGate ,                     /**<  收费站 */
    BNaviManeuver_Kind_Left_Side_Straight_IC ,        /**<  IC二分歧左侧直行走IC */
    BNaviManeuver_Kind_Right_Side_Straight_IC ,       /**<  IC二分歧右侧直行走IC */
    BNaviManeuver_Kind_Left_Side_Straight ,           /**<  普通/JCT/SAPA二分歧左侧 直行 */
    BNaviManeuver_Kind_Right_Side_Straight ,          /**<  普通/JCT/SAPA二分歧右侧 直行 */
    BNaviManeuver_Kind_Branch_Left_Straight ,         /**<  普通/JCT/SAPA三分歧左侧 直行 */
    BNaviManeuver_Kind_Branch_Center_Straight ,       /**<  普通/JCT/SAPA三分歧中央 直行 */
    BNaviManeuver_Kind_Branch_Right_Straight ,        /**<  普通/JCT/SAPA三分歧右侧 直行 */
    BNaviManeuver_Kind_Branch_Left_IC ,               /**<  IC三分歧左侧走IC */
    BNaviManeuver_Kind_Branch_Center_IC ,             /**<  IC三分歧中央走IC */
    BNaviManeuver_Kind_Branch_Right_IC ,              /**<  IC三分歧右侧走IC */
    BNaviManeuver_Kind_Branch_Left_IC_Straight ,      /**<  IC三分歧左侧直行 */
    BNaviManeuver_Kind_Branch_Center_IC_Straight ,    /**<  IC三分歧中间直行 */
    BNaviManeuver_Kind_Branch_Right_IC_Straight ,     /**<  IC三分歧右侧直行 */
    BNaviManeuver_Kind_Straight_2Branch_Left_Base ,   /**<  八方向靠左直行*/
    BNaviManeuver_Kind_Straight_2Branch_Right_Base ,  /**<  八方向靠右直行*/
    BNaviManeuver_Kind_Straight_3Branch_Left_Base  ,  /**<  八方向靠最左侧直行*/
    BNaviManeuver_Kind_Straight_3Branch_Middle_Base , /**<  八方向沿中间直行 */
    BNaviManeuver_Kind_Straight_3Branch_Right_Base ,  /**<  八方向靠最右侧直行 */
    BNaviManeuver_Kind_Left_2Branch_Left_Base ,       /**<  八方向左转+随后靠左 */
    BNaviManeuver_Kind_Left_2Branch_Right_Base ,      /**<  八方向左转+随后靠右 */
    BNaviManeuver_Kind_Left_3Branch_Left_Base ,       /**<  八方向左转+随后靠最左 */
    BNaviManeuver_Kind_Left_3Branch_Middle_Base ,     /**<  八方向左转+随后沿中间 */
    BNaviManeuver_Kind_Left_3Branch_Right_Base ,      /**<  八方向左转+随后靠最右 */
    BNaviManeuver_Kind_Right_2Branch_Left_Base ,      /**<  八方向右转+随后靠左 */
    BNaviManeuver_Kind_Right_2Branch_Right_Base ,     /**<  八方向右转+随后靠右 */
    BNaviManeuver_Kind_Right_3Branch_Left_Base ,      /**<  八方向右转+随后靠最左 */
    BNaviManeuver_Kind_Right_3Branch_Middle_Base ,    /**<  八方向右转+随后沿中间 */
    BNaviManeuver_Kind_Right_3Branch_Right_Base,       /**<  八方向右转+随后靠最右 */
    BNaviManeuver_Kind_Left_Front_2Branch_Left_Base,  /**<  八方向左前方靠左侧 */
    BNaviManeuver_Kind_Left_Front_2Branch_Right_Base, /**<  八方向左前方靠右侧  */
    BNaviManeuver_Kind_Right_Front_2Branch_Left_Base, /**<  八方向右前方靠左侧 */
    BNaviManeuver_Kind_Right_Front_2Branch_Right_Base, /**<  八方向右前方靠右侧 */
    BNaviManeuver_Kind_Back_2Branch_Right_Base,        /**<  八方向掉头+随后靠右 */
    BNaviManeuver_Kind_Back_3Branch_Left_Base,           /**<  八方向掉头+随后靠最左 */
    BNaviManeuver_Kind_Back_3Branch_Middle_Base,         /**<  八方向掉头+随后沿中间 */
    BNaviManeuver_Kind_Back_3Branch_Right_Base           /**<  八方向掉头+随后靠最右 */
}BNaviManeuver_Kind_Enum;

typedef enum {
    BNaviStatusExit    = 0, // 退出
    BNaviStatusCalc    = 1, // 计算路径中
    BNaviStatusReady   = 2, // 计算成功
    BNaviStatusViewAll = 3, // 一键全览态
    BNaviStatusMap     = 4, // 游览态
    BNaviStatus2D      = 5, // 导航态：指南针2D正北向上
    BNaviStatus3D      = 6, // 导航态：3D车头向上
} BNaviStatus; // 顺序非常重要

/**
 *  导航状态枚举
 *  ----------------
 *  Status of navigation
 */
typedef enum _BNaviStatus_Type_Enum
{
    BNaviStatus_Type_Invalid,   // 无效值 - Invalid
    BNaviStatus_Type_BeginNavi, // 导航开始 - start navigation
    BNaviStatus_Type_BeginYaw,  // 开始偏航 - start yawing
    BNaviStatus_Type_RerouteEnd,// 偏航成功 - finish yawing
    BNaviStatus_Type_ReRouteCarFree,// 车标自由状态
    BNaviStatus_Type_End1,      // 接近目的地 - near the destination
    BNaviStatus_Type_End2,      // 到达目的地 - reach to the destination
    BNaviStatus_type_ExactGuide, //模糊引导绑定link
    BnaviStatus_Type_FakeYawing, //静默偏航
}BNaviStatus_Type_Enum;

/**
 *  定义导航消息的动作类型：显示、更新、隐藏
 *  --------------------------
 *  Action type of navigation message
 */
typedef enum _BNaviMessage_Action_Enum
{
    BNaviMessage_Action_Invalid,    // 无效值 - Invalid
    BNaviMessage_Action_Show,       // 显示 - Show action
    BNaviMessage_Action_Update,     // 更新 - Update action
    BNaviMessage_Action_Hide,       // 隐藏 - Hide action
}BNaviMessage_Action_Enum;

/**
 *  路口放大图类型
 *  ---------------------------
 *  Type of 3D junctions real enlargement
 */
typedef enum _BNaviRasterExpandMap_Type_Enum
{
    BNaviRasterExpandMap_Type_Normal,       // 普通路口放大图 - Normal 3D junctions real enlargement
    BNaviRasterExpandMap_Type_DirectBoard,  // 方向看板 - original direction signs
}BNaviRasterExpandMap_Type_Enum;

/**
 *  定义导航sdk对外发送的所有消息类型
 *  -------------------------
 *  The message type for navigation
 */
typedef enum  _BNaviMessage_Type_Enum
{
    BNaviMessage_Type_Invalid,           // 无效值 - Invalid
    BNaviMessage_Type_StatusChange,      // 导航状态变化 - change of navigation status
    BNaviMessage_Type_SimpleGuideInfo,   // 简易诱导信息 - Simple guidance information
    BNaviMessage_Type_AssistantGuideInfo,// 辅助诱导信息 - Assistant guidance information
    BNaviMessage_Type_RasterExpandMap,   // 路口放大图 - 3D junctions real enlargement
    BNaviMessage_Type_CurrentRoadName,   // 当前路名 - current road name
    BNaviMessage_Type_RemainInfo,        // 总的剩余时间和剩余距离 - remain distance and time
    BNaviMessage_Type_RemainTrafficlightsInfo,        // 剩余红绿灯
    BNaviMessage_Type_GPSChange,         // gps状态变化 - gps change
    BNaviMessage_Type_MainSlave,         // 主辅路消息 - circuit switch
    BNaviMessage_Type_VectorExpandMap,   // 矢量放大图 - vector diagram enlargement
    BNaviMessage_Type_MapRefresh,        // 底图刷新消息 - map refresh
    BNaviMessage_Type_HighWayBoard,      // 高速看板消息
    BNaviMessage_Type_ColladaBoard,       //collada高架桥数据
    BNaviMessage_Type_OtherRoute,        // 行进中其他路线
    BNaviMessage_Type_SwitchNavi,        // 切换导航
    BNaviMessage_Type_RC_RoadInfo_Change,        // 路况高架主辅路切换
    BNaviMessage_Type_LaneInfo,          // 车道线消息
}BNaviMessage_Type_Enum;

/**
 *  GPS状态改变情况
 *  ----------------------
 *  Status for GPS change
 */
typedef  enum  _BNaviGPS_Change_Enum
{
    BNaviGPS_Change_Invalid,        // 无效值 - Invalid
    BNaviGPS_Change_Connect,        // gps连接 - GPS is connected
    BNaviGPS_Change_Disconnect,     // gps断开连接 - GPS is disconnected
}BNaviGPS_Change_Enum;

/**
 *  地图刷新场景
 *  -----------------
 *  Scenario for map refresh
 */
typedef enum _BNaviMapRefresh_Type_Enum
{
    BNaviMapRefresh_Type_Invalid,        // 无效值 - Invalid
    BNaviMapRefresh_Type_NaviRoute,      // 刷新导航路线图层 - refresh the overlayer of navigation route
    BNaviMapRefresh_Type_NaviCar,        // 车点更新 - refresh the overlayer of car position
    BNaviMapRefresh_Type_NaviNode,       // 刷新节点图层 - refresh the overlayer of source and destination
    BNaviMapRefresh_Type_NearToCross,    // 接近路口，需要放大比例尺 - refresh for near the crossing, need to zoom in automatically
    BNaviMapRefresh_Type_AwayFromCross,  // 驶离路口 - refresh for being away from the crossing, need to zoom out automatically
    BNaviMapRefresh_Type_RoadConditon,   // 更新路况
}BNaviMapRefresh_Type_Enum;

typedef enum {
    BN_NaviTypeReal,        // 真实导航
    BN_NaviTypeSimulator,   // 模拟导航
} BN_NaviType;

typedef enum {
    BNVoiceSoundType_Ding,      // 叮
    BNVoiceSoundType_DiDiDi,    // 嘀嘀嘀
    BNVoiceSoundType_DaDaDa,    // 嗒嗒嗒
    BNVoiceSoundType_DiGu,      // 嘀咕
    BNVoiceSoundType_DangDang,  // 当当
} BNVoiceSoundType;

#endif
