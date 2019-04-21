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
static NSString *token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidHlwZSI6ImFkbWluIiwiZXhwIjoxNTUyNTM1MzUzLCJpYXQiOjE1NTE5MzA1NTMsInVzZXJuYW1lIjoi5byg5ZOyIn0.gA4N8Gp4NVTNnpprNpynawYuOOiiefzZ04MzfthFmxE";

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
    NSString *URL = [NSString stringWithFormat:@"http://39.106.39.48/point/addPoint"];
    NSDictionary *param = @{@"name" : name, @"longitude" : [NSNumber numberWithDouble:longitude], @"latitude" : [NSNumber numberWithDouble:latitude]};

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

// 文字评论
- (void)addMessageWithPointId:(int)pointId Content:(NSString *)content success:(MAPResultHandle)successBlock error:(MAPErrorHandle)errorBlock {
    NSString *URL = [NSString stringWithFormat:@"http://39.106.39.48/addMessage/%d", pointId];
    NSDictionary *param = @{@"content" : content};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [manager POST:URL parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        MAPAddPointModel *result = [[MAPAddPointModel alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"%@", result);
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

// 上传多张图片
- (void)uploadPhotosWithPointId:(int)pointId Title:(NSString *)title Data:(NSArray *)fileDataArray success:(MAPResultHandle)succeedBlock error:(MAPErrorHandle)errorBlock {
    NSString *URL = [NSString stringWithFormat:@"http://39.106.39.48/uploadMangPhotos/%d", pointId];
    
    NSDictionary *param = @{@"pointId" : [NSNumber numberWithInt:pointId], @"photos" : fileDataArray, @"title" : title};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [manager POST:URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (id obj in fileDataArray) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:obj name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response : %@", responseObject);
        NSError *error;
        MAPAddPointModel *result = [[MAPAddPointModel alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"result:%@", result);
        if (result.status == 0) {
            succeedBlock(result);
        } else {
            NSLog(@"%@", result.message);
            NSError *error = [[NSError alloc] initWithDomain:result.message code:(NSInteger)result.status userInfo:nil];
            errorBlock(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        errorBlock(error);
    }];
}

// 上传文件
- (void)uploadWithPointId:(int)pointId Data:(NSData *)fileData Type:(int)type Title:(NSString *)title success:(MAPResultHandle)succeedBlock error:(MAPErrorHandle)errorBlock {
    NSString *URL = [NSString stringWithFormat:@"http://39.106.39.48/upload/%d", pointId];
    //    NSLog(@"url:%@", URL);
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"type" : [NSNumber numberWithInt:type], @"file" : fileData}];
    if (type == 3) {
        [param setObject:title forKey:@"title"];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [manager POST:URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        if (type == 2) {
            NSString *fileName = [NSString stringWithFormat:@"%@.mp3", str];
            [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"mp3"];
        } else if (type == 3) {
            NSString *fileName = [NSString stringWithFormat:@"%@.mp4", str];
            [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"MOV/mp4"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"responseJSON : %@", responseJSON);
        NSError *error;
        MAPAddPointModel *result = [[MAPAddPointModel alloc] initWithDictionary:responseJSON error:&error];
        NSLog(@"result:%@", result);
        if (result.status == 0) {
            succeedBlock(result);
        } else {
            NSLog(@"%@", result.message);
            NSError *error = [[NSError alloc] initWithDomain:result.message code:(NSInteger)result.status userInfo:nil];
            errorBlock(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        errorBlock(error);
    }];
    
}

@end
