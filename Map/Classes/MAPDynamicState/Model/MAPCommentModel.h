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
@property (nonatomic, assign) int pointId;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) int remarkCount;
@property (nonatomic, assign) int clickCount;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, assign) int isClick;

@end

@interface MAPCommentModel : MAPAddPointModel

@property (nonatomic, copy) NSArray<Optional, MAPCommentContentModel> *data;

@end
