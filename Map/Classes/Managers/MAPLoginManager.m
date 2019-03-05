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
    NSString *token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidHlwZSI6ImFkbWluIiwiZXhwIjoxNTUyMzU5ODkzLCJpYXQiOjE1NTE3NTUwOTMsInVzZXJuYW1lIjoi5byg5ZOyIn0.PPweYfpmodOvc6nTSMGtqx_ONYS08XcjhOmtVWZR4cM";
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager POST:@"http://39.106.39.48:8080/user/getMessageByUserid" parameters:ID progress:^(NSProgress * _Nonnull downloadProgress) {
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
