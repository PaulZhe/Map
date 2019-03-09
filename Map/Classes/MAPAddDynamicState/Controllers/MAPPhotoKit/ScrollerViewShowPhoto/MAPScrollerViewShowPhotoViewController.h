//
//  MAPScrollerViewShowPhotoViewController.h
//  Map
//
//  Created by 涂强尧 on 2019/3/9.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^selectedBlock)(NSDictionary *newSelectDictionary);
typedef void (^isOriginalBlock)(NSString *isOriginalString);
typedef void (^submitDictionaryBlock)(NSMutableDictionary *submitDictionary);

@interface MAPScrollerViewShowPhotoViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) PHFetchResult *PHFectchResult;
@property (nonatomic, copy) NSString *whichOne;
@property (nonatomic, strong) NSArray *lowQialityArray;//低分辨率图片
@property (nonatomic, strong) NSArray *selectedButtonArray;
@property (nonatomic, copy) selectedBlock selectedDictionaryBlock;
@property (nonatomic, copy) isOriginalBlock originBlock;
@property (nonatomic, strong) NSMutableDictionary *submitDictionary;
@property (nonatomic, strong) NSDictionary *lastDictionary;
@property (nonatomic, copy) NSString *alumbIdentifier;
@property (nonatomic, copy) submitDictionaryBlock getSubmitDictionary;
@property (nonatomic, assign) BOOL isNeed;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, copy) NSString *isOriginalString;
@property (nonatomic, strong) NSMutableArray *freshSelectedMutableArray;

@end

NS_ASSUME_NONNULL_END
