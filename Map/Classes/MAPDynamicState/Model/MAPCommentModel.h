//
//  MAPCommentModel.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/13.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"

@protocol MAPCommentContentModel
@end

@interface MAPCommentContentModel : JSONModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pointId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *remarkCount;
@property (nonatomic, copy) NSString *clickCount;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *isClick;

@end

@interface MAPCommentModel : JSONModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSArray<MAPCommentContentModel> *data;

@end
