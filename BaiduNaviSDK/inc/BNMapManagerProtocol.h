//
//  BNMapManagerProtocol.h
//  baiduNaviSDK
//
//  Created by Baidu on 11/11/13.
//  Copyright (c) 2013 baidu. All rights reserved.
//

#ifndef baiduNaviSDK_BNMapManagerProtocol_h
#define baiduNaviSDK_BNMapManagerProtocol_h

@protocol BNMapManagerProtocol

/// 放大地图, 返回YES表示最大比例尺，返回NO表示不是最大比例尺
-(BOOL)zoomIn;

/// 缩小地图，返回YES表示最小比例尺，返回NO表示不是最小比例尺
-(BOOL)zoomOut;

@end

#endif
