//
//  MAPMotivePicturesView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/24.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPMotivePicturesView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//九宫格展示图片
@property (nonatomic, strong) UICollectionView *picturesCollectionView;
@end

NS_ASSUME_NONNULL_END
