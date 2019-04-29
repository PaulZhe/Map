//
//  BNUtility.h
//  BNOpenKit
//
//  Created by linbiao on 2019/3/19.
//  Copyright © 2019年 Chen,Xintao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNUtility : NSObject

/**
 获取设备cuid
 
 @return  设备cuid值
 */
+ (NSString*)getLBSCuid;

/**
 coordinate conversion
 
 @param coordinate in wgs84ll standard
 @return coordinate in BD09ll standard
 */
+ (CLLocationCoordinate2D)convertToBD09MCWithWGS84ll:(CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END
