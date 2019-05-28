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

@interface MAPContentModel : JSONModel

@property (nonatomic, copy) NSString *comm;
@property (nonatomic, assign) int audioMinutes;
@property (nonatomic, assign) int audioSecond;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<NSString *> *urls;

@end

@interface MAPCommentContentModel : JSONModel

@property (nonatomic, assign) int ID;
@property (nonatomic, assign) int pointId;
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *username;
//@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) MAPContentModel *content;
@property (nonatomic, assign) int remarkCount;
@property (nonatomic, assign) int clickCount;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, assign) int isClick;
@property (nonatomic, assign) int userId;

@end

//@interface MAPAudioContentModel : JSONModel
//
//@property (nonatomic, assign) int ID;
//@property (nonatomic, assign) int pointId;
//@property (nonatomic, assign) int type;
//@property (nonatomic, copy) NSString *username;
//@property (nonatomic, strong) MAPContentModel *content;
//@property (nonatomic, assign) int remarkCount;
//@property (nonatomic, assign) int clickCount;
//@property (nonatomic, copy) NSString *createAt;
//@property (nonatomic, assign) int isClick;
//@property (nonatomic, assign) int userId;
//
//@end

@interface MAPCommentModel : MAPAddPointModel

@property (nonatomic, copy) NSArray<Optional, MAPCommentContentModel> *data;

@end

//@interface MAPAudioModel : MAPAddPointModel
//
//@property (nonatomic, copy) NSArray<Optional, MAPCommentContentModel> *data;
//
//@end

