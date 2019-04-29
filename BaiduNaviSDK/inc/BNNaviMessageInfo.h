//
//  BNNaviMessageInfo.h
//  NaviSDKDemo
//
//  Created by linbiao on 2018/12/25.
//  Copyright © 2018年 李择一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCommonDef.h"

/**
 *  @class 所有导航消息基类
 *  ---------------
 *  @class Object to keep current navigation message type
 */
@interface BNNaviMsgBase : NSObject

@property(nonatomic,assign)BNaviMessage_Type_Enum eMsgType; // 消息类型 - navigation message type

@end


/**
 *  剩余信息（距离、时间）
 *  -----------------
 *  Remain distance and time
 */
@interface BNaviRemainInfo : BNNaviMsgBase

@property(nonatomic,assign)BNaviMessage_Action_Enum eAction;    // 动作类型 - action type
@property(nonatomic,assign)NSInteger remainDist;                // 剩余距离 - remain distance
@property(nonatomic,assign)NSInteger remainTime;                // 剩余时间 - remain time

@end


/**
 *  @class 简易诱导消息结构体
 *  ------------------
 *  @class Object for simple guidance information
 */
@interface BNaviSimpleGuideInfo : BNNaviMsgBase
@property(nonatomic,assign)BNaviMessage_Action_Enum eAction;    // 动作类型 - action type
@property(nonatomic,copy)NSString* nextRoadName;                // 下一路口名字 - next road name
@property(nonatomic,copy)NSString* turnIconName;                // 转向标图片名称 - name for lane change information indicating diagram
@property(nonatomic,assign)NSInteger totalDist;                 // 该段路总长度，单位：米 - total length of the route, in meter
@property(nonatomic,assign)NSInteger remainDist;                // 距离下一路口剩余长度，单位：米 - remain distance to the next road, in meter
@property(nonatomic,assign)NSInteger remainTime;                // 距离下一路况大概时间，单位：秒 - remain time to the next road, in second
@property(nonatomic,assign)BOOL isStraight;                     //是否处于顺行模式
@property(nonatomic, assign)BOOL bStraightIcon;              //区分下一个路口是添加沿 还是进入
//下一转向
@property (nonatomic, assign) BNaviManeuver_Kind_Enum nextTurnKind;
//当前转向
@property (nonatomic, assign) BNaviManeuver_Kind_Enum curTurnKind;
//下一个转弯到当前转弯的距离
@property (nonatomic, assign) NSInteger distCur2NextGP;
//下一个转弯是否为高速
@property (nonatomic, assign) BOOL bHighwayExCur2NextGP;
//当前路名，顺行模式显示当前路名
@property (nonatomic, strong) NSString* curRoadName;
@property(nonatomic,assign)NSInteger GPAddDist; // 机动点距离，用于判断前后是否相同机动点

@end


/**
 *  @class 导航状态消息结构体
 *  ---------------
 *  @class BNaviStatusInfo, information of navigation status
 */
@interface BNaviStatusInfo : BNNaviMsgBase

@property(nonatomic,assign)BNaviStatus_Type_Enum eNaviStatusType; // 导航状态类型 - message type of navigation status
@property(nonatomic,assign)NSInteger eNaviSightType;              // 新增的导航状态类型

@end


/**
 *  路口放大图消息结构体
 *  ------------------
 *  @class Object for 3D-junctions real enlargement
 */
@interface BNaviRasterExpandMap : BNNaviMsgBase
@property(nonatomic,assign)BNaviMessage_Action_Enum eAction;    // 动作类型 - Action type
@property(nonatomic,copy)NSString* bgImageId;                   // 背景图片id - ID for background image
@property(nonatomic,copy)NSString* iconId;                      // icon图片id - icon id
@property(nonatomic,retain)UIImage* bgImage;                    // 背景图片,下载了资源后才有,否则为nil - Need to download the corresponding data, otherwise, it will be nil.
@property(nonatomic,assign)NSInteger totalDist;                 // 总距离，单位：米 - total length, in meter
@property(nonatomic,assign)NSInteger remainDist;                // 剩余距离，单位：米 - remain distance, in meter
@property(nonatomic,assign)NSInteger remainTime;                // 剩余时间，单位：秒, remain time, in second
@property(nonatomic,copy)NSString * nextRoadName;               // 下一路口名字, next road name
@property(nonatomic,assign)BNaviRasterExpandMap_Type_Enum eRasterType;// 路口放大图类型, type of enlargement
@property (nonatomic, assign) int gridMapKind;                  //放大图分类，用于统计，详见RG_Grid_Kind_Enum类型
@property (nonatomic, copy) NSString *statParam; //诱导统计字段
@property(nonatomic,copy)NSString * straightIcon;               // 不为空就是直行路口
@property (nonatomic, assign)NSInteger addDist;                 //积算距离

@end


/**
 *  当前路名信息
 *  -------------
 *  Information for current road name
 */
@interface BNaviCurrentRoadName : BNNaviMsgBase

@property(nonatomic,copy)NSString* curRoadName; // 当前路名, current road name

@end


/**
 *  剩余红绿灯（目的地、途经点）
 *  -----------------
 *  Remain distance and time
 */
@interface BNaviRemainTrafficlightsInfo : BNNaviMsgBase

@property(nonatomic,assign)NSInteger remainTrafficights;                // 离目的地剩余红绿灯
@property(nonatomic,assign)NSInteger viaRemainTrafficights;             // 离下个途经点剩余红绿灯

@end


/**
 *  gps连接状态变化消息
 *  -----------------
 *  Connection status for gps
 */
@interface BNaviGPSChange : BNNaviMsgBase

@property(nonatomic,assign)BNaviGPS_Change_Enum eGpsChangeType; // 状态变化 - change type for gps

@end


/**
 *  主辅路切换提示消息
 *  ----------------
 *  Information for circuit switching
 */
@interface BNaviMainSlave : BNNaviMsgBase

@property(nonatomic,assign)BNaviMessage_Action_Enum eAction;    // 动作类型,BNaviMainSlave 消息只有show和hide，没有update - action type, only support SHOW, HIDE, not support UPDATE

@end


/**
 *  矢量放大图消息
 *  -------------
 *  Information for vector diagram enlargement
 */
@interface BNaviVectorExpandMap : BNNaviMsgBase

@property(nonatomic,assign)BNaviMessage_Action_Enum eAction;    // 动作类型 - action type
@property(nonatomic,assign)NSInteger totalDist;                 // 总距离，单位：米 - total distance, in meter
@property(nonatomic,assign)NSInteger remainDist;                // 剩余距离，单位：米 - remain distance, in meter
@property(nonatomic,assign)NSInteger remainTime;                // 剩余时间，单位：秒 - remain time, in second
@property(nonatomic,assign)double carRotAngle;                  // 车标旋转角度 - rotation angle for car
@property(nonatomic,assign)NSInteger carPosX;                   // 车标位置X - X-position for car
@property(nonatomic,assign)NSInteger carPosY;                   // 车标位置Y - Y-position for car
@property(nonatomic,copy)NSString* outRoadName;                 // 驶出道路名 - the next road name
@property(nonatomic,copy)NSString* straightIcon;                 // 直行图标
@property(nonatomic,assign)NSInteger imageWidth;                // 图片宽度，单位：像素 - width of image, in pixel
@property(nonatomic,assign)NSInteger imageHeight;               // 图片高度，单位：像素 - height of image, in pixel
@property(nonatomic,retain)UIImage* juncViewImage;              // 图片 - image of vector diagram enlargement

@end


/**
 *  高速面板信息
 */
@interface BNaviHighwayBoard : BNNaviMsgBase

@property (nonatomic,assign)  BNaviMessage_Action_Enum eAction;// 动作类型 - action type
@property (nonatomic,assign) NSUInteger exitRemainDist;        // 高速出口剩余距离
@property (nonatomic,retain) NSString *exitHighwayDirectName;  // 离开高速的方向名
@property (nonatomic,retain) NSString *exitHightwayNextRoadName;//离开高速进入的道路名
@property (nonatomic,retain) NSString *exitHighwayID;          // 离开高速的编号
@property (nonatomic,assign) NSUInteger tollGateTotalDist;     // 最近的收费站的剩余距离
@property (nonatomic,copy) NSString *tollGateName;             // 最近的收费站名称
@property (nonatomic,assign) NSUInteger saRemainDist;          // 最近的服务区剩余距离
@property (nonatomic,retain) NSString *highwaySAName;          // 最近的服务区名称
@property (nonatomic,assign) NSUInteger nextSARemainDist;      // 第二近的服务区剩余距离
@property (nonatomic,retain) NSString *nextHighwaySAName;      // 第二近的服务区名称
@property (nonatomic,retain) NSString *curHighwayRoadName;     // 当前高速路名
@property (nonatomic,assign) BOOL isLessGPMin;                 // 是否在距下一机动点3km以内，3km以内退出高速模式
@property (nonatomic, assign) BNaviManeuver_Kind_Enum exitHightwayTurnKind; //离开高速的转弯类型

@end


/**
 *  高速入口信息
 */
@interface BNaviInHighwayBoard : BNNaviMsgBase

@property (nonatomic,assign)  BNaviMessage_Action_Enum eAction; // 动作类型 - action type
@property (nonatomic,copy) NSString *highwayRoadName;           // 进入高速后路名
@property (nonatomic,assign) NSUInteger startDist;              // 进入高速总距离
@property (nonatomic,assign) NSUInteger remainDist;             // 进入高速后剩余距离

@end


/**
 *  方向看板信息
 */
@interface BNaviDirectionBoard : BNNaviMsgBase

@property (nonatomic,assign)  BNaviMessage_Action_Enum eAction; // 动作类型 - action type
@property (nonatomic,copy) NSString *directionName;             // 方向名
@property (nonatomic,copy) NSString *exitID;                    // 出口编号
@property (nonatomic,assign) NSUInteger startDist;              // 总距离
@property (nonatomic,assign) NSUInteger remainDist;             // 剩余距离
@property (nonatomic,assign) NSUInteger addDist;                // 积算距离

@end


/**
 *  车点位置信息
 *  ---------------
 *  Information for car position
 */
@interface BNaviCarPosition : NSObject

@property(nonatomic,assign)double carPosX;          // 车标位置：x坐标 wgs84 - X-position in wgs84
@property(nonatomic,assign)double carPosY;          // 车标位置，y坐标 wgs84 - y-position in wgs84
@property(nonatomic,assign)double carRotateAngle;   // 车头与正北方向的夹角，单位：度 - angle between the direction of car and the due north, in degree
@property(nonatomic,assign)double carSpeed;         // 车标速度
@end


/**
 *  地图刷新操作相关的消息
 *  -----------------
 *  Information for map refresh
 */
@interface BNaviMapRefreshInfo : BNNaviMsgBase

@property(nonatomic,assign)BNaviMapRefresh_Type_Enum eMapRefreshType; // 地图刷新消息, type of message for map refresh

@property(nonatomic,retain)BNaviCarPosition* carPosInfo;            // 车标位置信息, information for car position

@property(nonatomic,retain)NSArray* roadCondition;//路况数组，它的每一个元素是 BNaviRoadConditionItem 类型

@end


/**
 *  经过途经点的消息
 */
@interface BNaviPassViaPointInfo : BNNaviMsgBase

@property(nonatomic,assign) int enType;
@property(nonatomic,assign) int viaIndex;

@end


/**
 *  车道线信息
 */
@interface BNaviLaneInfo : BNNaviMsgBase

@property (nonatomic, assign) BNaviMessage_Action_Enum eAction;

@end


/**
 *  车速信息
 */
@interface BNKMNaviSpeed : NSObject

@property (nonatomic, assign) int speed; // 单位km/h

@end


/**
 *  BNaviMessageHelper工具类
 */
@interface BNaviMessageHelper : NSObject

/**
 *  获取路线详情项转向类型描述
 */
+ (NSString *)typeNameForManeuverKind:(BNaviManeuver_Kind_Enum)type;

@end
