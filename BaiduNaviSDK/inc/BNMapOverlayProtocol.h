//
//  BNMapOverlayManagerProtocol.h
//  baiduNaviSDK
//
//  Created by chenxintao on 2017/11/20.
//  Copyright © 2017年 baidu. All rights reserved.
//

#ifndef BNMapOverlayManagerProtocol_h
#define BNMapOverlayManagerProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @brief 自定义图层类
 */
@interface BNaviMapItemData : NSObject


/**
 创建BNaviMapItemData对象

 @param image 图片
 @param pos 需要展示在底图上的位置
 @param xAlign 图片的质心x方向的偏移 （0 - 1），比如，xAlign和yAlign均为0.5，表示图片的中心在pos的位置
 @param yAlign 图片的质心y方向的偏移 （0 - 1），比如，xAlign和yAlign均为0.5，表示图片的中心在pos的位置
 @param name 图片的名字，item的唯一标识符，每个item的name必须唯一
 @return BNaviMapItemData对象
 */
+ (BNaviMapItemData*)itemWithImage:(UIImage*)image
                          position:(BNPosition*)pos
                            xAlign:(CGFloat)xAlign
                            yAlign:(CGFloat)yAlign
                              name:(NSString*)name;

@property (strong, nonatomic) UIImage* image;

@property (strong, nonatomic) BNPosition* pos;

@property (assign, nonatomic) CGFloat xAlign;

@property (assign, nonatomic) CGFloat yAlign;


@end

/**
 * @brief 自定义图层管理接口，自定义icon接口
 */
@protocol BNMapOverlayProtocol

/**
 设置自定义图层数据

 @param items BNaviMapItemData数组
 */
- (void)setItemOverlayData:(NSArray<BNaviMapItemData*>*)items;

/**
 更新自定义图层数据
 
 @param items BNaviMapItemData数组
 */
- (void)updateItemOverlayData:(NSArray<BNaviMapItemData*>*)items;

/**
 清除自定义图层数据
 */
- (void)clearItemOverlay;


/**
 删除某个路线图层item

 @param item 删除的item
 */
- (void)removeOneItemOfLayer:(BNaviMapItemData*)item;


/**
 显示或隐藏自定义图层

 @param show YES表示显示，NO表示隐藏
 */
- (void)show:(BOOL)show;


@end

#endif /* BNMapOverlayManagerProtocol_h */
