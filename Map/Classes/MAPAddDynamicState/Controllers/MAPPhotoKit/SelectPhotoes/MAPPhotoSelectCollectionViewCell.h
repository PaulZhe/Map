//
//  MAPPhotoSelectCollectionViewCell.h
//  Map
//
//  Created by 涂强尧 on 2019/3/6.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN
@protocol selectDelegate <NSObject>

-(void)selectButton:(UIButton *)sender;

@end
@interface MAPPhotoSelectCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, assign) NSInteger *which;
@property (nonatomic, strong) UIImageView *__block imageView;
@property (nonatomic, assign) id<selectDelegate> delegate;
- (void) getPhotoWithAset:(PHAsset *)myAsset andWhichOne:(NSInteger)which;
@end

NS_ASSUME_NONNULL_END
