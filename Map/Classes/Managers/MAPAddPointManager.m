//
//  MAPAddPointManager.m
//  Map
//
//  Created by 小哲的DELL on 2019/2/25.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPAddPointManager.h"
#import <AFNetworking.h>

static MAPAddPointManager *manager = nil;

@implementation MAPAddPointManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[MAPAddPointManager alloc] init];
        }
    });
    return manager;
}

- (void)addPointWithName:(NSString *)name Latitude:(double)latitude Longitude:(double)longitude success:(MAPResultHandle)successBlock error:(MAPErrorHandle)errorBlock {
    NSString *URL = [NSString stringWithFormat:@"http://39.106.39.48:8080/point/addPoint"];
    NSDictionary *param = @{@"name" : name, @"longitude" : [NSNumber numberWithDouble:longitude], @"latitude" : [NSNumber numberWithDouble:latitude]};
    NSString *token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwIjoxNTUxNjc2NDk1LCJpYXQiOjE1NTEwNzE2OTUsInVzZXJuYW1lIjoi5byg5ZOyIn0.bhLIBx2OZm5YrZbCLEgesz_ad3wq0G3tpjEcGAlKSXQ";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [manager POST:URL parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        MAPAddPointModel *result = [[MAPAddPointModel alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"%@", result.data);
        if (result.status == 0) {
            successBlock(result);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:result.message code:(NSInteger)result.status userInfo:nil];
            errorBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        errorBlock(error);
    }];
}

@end
