//
//  MAPLoginManager.h
//  Map
//
//  Created by 小哲的DELL on 2019/2/20.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAPGetUserMessageModel.h"

typedef void(^MAPGetUserMessage)(MAPGetUserMessageModel *messageModel);
typedef void(^MAPGetUserMessageFailure)(NSError *error);

@interface MAPLoginManager : NSObject

+ (instancetype)sharedManager;
- (void)requestUserMessageWith:(NSString *)ID
                       Success:(MAPGetUserMessage)succeedBlock
                       Failure:(MAPGetUserMessageFailure)failBlock;

@end
