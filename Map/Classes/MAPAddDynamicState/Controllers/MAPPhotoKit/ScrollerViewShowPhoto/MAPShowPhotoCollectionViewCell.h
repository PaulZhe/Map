//
//  MAPShowPhotoCollectionViewCell.h
//  Map
//
//  Created by 涂强尧 on 2019/3/11.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPShowPhotoCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;

-(void)getBigImageWithAsset:(PHAsset *)asset;
@end

NS_ASSUME_NONNULL_END
