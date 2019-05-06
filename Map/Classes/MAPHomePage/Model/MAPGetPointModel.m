//
//  MAPGetPointModel.m
//  Map
//
//  Created by 小哲的DELL on 2019/2/26.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPGetPointModel.h"

@implementation MAPGetPointModel

@end

@implementation MAPPointItemModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"ID":@"id", @"pointName":@"name"}];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return  YES;
}

@end
