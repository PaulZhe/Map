//
//  MAPCommentModel.m
//  Map
//
//  Created by 小哲的DELL on 2019/2/13.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPCommentModel.h"

@implementation MAPContentModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation MAPCommentContentModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"ID":@"id"
                                                                  }];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return  YES;
}

@end

@implementation MAPCommentModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
