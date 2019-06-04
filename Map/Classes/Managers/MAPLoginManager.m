//
//  MAPLoginManager.m
//  Map
//
//  Created by 小哲的DELL on 2019/2/20.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPLoginManager.h"
#import <AFNetworking.h>

static MAPLoginManager *manager = nil;
static NSString *token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidHlwZSI6ImFkbWluIiwiZXhwIjoxNTYwMjI0NjUzLCJpYXQiOjE1NTk2MTk4NTMsInVzZXJuYW1lIjoi5byg5ZOyIn0.Y-Gj0w-eM60LkDstRm8aE43wuW06tR3_r4susLak_cc";

@implementation MAPLoginManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[MAPLoginManager alloc] init];
        }
    });
    
    return manager;
}

- (void)requestUserMessageWith:(NSNumber *)ID
                       Success:(MAPGetUserMessage)succeedBlock
                       Failure:(MAPGetUserMessageFailure)failBlock {

    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager POST:@"http://39.106.39.48/user/getMessageByUserid" parameters:ID progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        MAPGetUserMessageModel *result = [[MAPGetUserMessageModel alloc] initWithDictionary:responseObject error:nil];
        succeedBlock(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        failBlock(error);
    }];
}

@end
