//
//  MAPGetUserMessageModel.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/20.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"

@protocol MAPGetUserMessageDataModel
@end

@interface MAPGetUserMessageDataModel : JSONModel

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *account;

@end

@interface MAPGetUserMessageModel : JSONModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSArray<MAPGetUserMessageDataModel> *data;

@end

@interface MAPGetUserMessageFailureModel : JSONModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;

@end
