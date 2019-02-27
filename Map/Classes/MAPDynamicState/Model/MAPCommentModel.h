//
//  MAPCommentModel.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/13.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"
#import "MAPAddPointModel.h"

@protocol MAPCommentContentModel
@end

@interface MAPCommentContentModel : JSONModel

@property (nonatomic, assign) int ID;
@property (nonatomic, assign) NSInteger *pointId;
@property (nonatomic, assign) NSInteger *type;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger *remarkCount;
@property (nonatomic, assign) NSInteger *clickCount;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *isClick;

@end

@interface MAPCommentModel : MAPAddPointModel

@property (nonatomic, copy) NSArray<MAPCommentContentModel> *data;

@end
