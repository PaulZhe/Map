//
//  MAPPhotoSelectViewController.h
//  Map
//
//  Created by 涂强尧 on 2019/3/5.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "MAPPhotoSelectCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^getSubmitDictonary) (NSMutableDictionary *submitDictionary);

@interface MAPPhotoSelectViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, selectDelegate>
@property (nonatomic, copy) PHFetchResult *PHFetchResult;
@property (nonatomic, assign) NSInteger maxcount;
@property (nonatomic, copy) NSString *isOriginal;
@property (nonatomic, strong) NSDictionary *mySubmitDictionary;
@property (nonatomic, strong) NSDictionary *imageDictionary;
@property (nonatomic, copy) NSString *albumIdentifier;
@property (nonatomic, copy) getSubmitDictonary getSubmitDictionary;
@property (nonatomic, assign) NSInteger haveCount;
@property (nonatomic, assign) BOOL ifNeed;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (NSData *) resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger) maxSize;
NS_ASSUME_NONNULL_END
@end
