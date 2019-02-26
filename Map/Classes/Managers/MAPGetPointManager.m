//
//  MAPGetPointManager.m
//  Map
//
//  Created by 小哲的DELL on 2019/2/26.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPGetPointManager.h"
#import <AFNetworking.h>

static MAPGetPointManager *manager = nil;

@implementation MAPGetPointManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[MAPGetPointManager alloc] init];
        }
    });
    return manager;
}

- (void)fetchPointWithLongitude:(double)longitude Latitude:(double)latitude Range:(int)range succeed:(MAPGetPointHandle)succeedBlock error:(ErrorHandle)errorBlock{
    NSString *URL = [NSString stringWithFormat:@"http://39.106.39.48:8080/none/getPoints"];
    
    NSDictionary *param = @{@"longitude":[NSNumber numberWithDouble:longitude],@"latitude":[NSNumber numberWithDouble:latitude],@"range":[NSNumber numberWithInt:range]};
    
    [[AFHTTPSessionManager manager] POST:URL parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"response : %@", responseObject);
        NSError *error;
        MAPGetPointModel *model = [[MAPGetPointModel alloc] initWithDictionary:responseObject error:&error];
        if (error) {
            NSLog(@"error");
            errorBlock(error);
        } else {
            if (model.status == 0) {
                succeedBlock(model);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:model.message code:(NSInteger)model.status userInfo:nil];
                errorBlock(error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
