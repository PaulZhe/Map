//
//  MAPAddDynamicStateJSONModel.h
//  Map
//
//  Created by 涂强尧 on 2019/2/12.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPAddPointJSONModel : JSONModel
@property (nonatomic, strong) NSString *pointNAme;
@property (nonatomic, assign) double latitude;//经度
@property (nonatomic, assign) double longitude;//纬度
@end



@interface MAPAddDynamicStateJSONModel : JSONModel
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *data;
@end


NS_ASSUME_NONNULL_END
