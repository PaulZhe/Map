//
//  MAPPhotoKitViewController.h
//  Map
//
//  Created by 涂强尧 on 2019/3/5.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^photoArrayBlock) (NSMutableDictionary *selectDictionary);//选择的图片字典
NS_ASSUME_NONNULL_BEGIN

@interface MAPPhotoKitViewController : UIViewController
@property (nonatomic, strong) NSDictionary *imageDictionary;//照片字典
@property (nonatomic, copy) NSString *maxCountString;//最大数量
@property (nonatomic, copy) NSString *isHaveOriginal;//原始图片
@property (nonatomic, copy) photoArrayBlock getSubmitDictionary;//获取提交图片字典
@property (nonatomic, assign) BOOL ifNeed;//是否需要请求
@property (nonatomic, strong) NSMutableArray *photoesArray;//最新选择图片数组
//此方法回掉选择图片数组
- (instancetype) initWithMaxCount:(NSString *)maxCountString andIsHaveOriginal:(NSString *)isHaveOriginal andOldImagesDictonary:(NSDictionary *)oldImagesDictionary andIfGetImageArray:(BOOL)ifNeedImageArray;
@end

NS_ASSUME_NONNULL_END
