//
//  MAPShowPhotoCollectionViewCell.m
//  Map
//
//  Created by 涂强尧 on 2019/3/11.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPShowPhotoCollectionViewCell.h"

@implementation MAPShowPhotoCollectionViewCell

#define allScreen [UIScreen mainScreen].bounds.size


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCellUI];
    }
    return self;
}

-(void)createCellUI{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, allScreen.width, allScreen.height)];
    [self.contentView addSubview:_imageView];
}

-(void)getBigImageWithAsset:(PHAsset *)asset{
    PHImageRequestOptions *reques = [[PHImageRequestOptions alloc]init];
    reques.synchronous = NO;
    reques.networkAccessAllowed = NO;
    reques.resizeMode = PHImageRequestOptionsResizeModeExact;
    reques.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(allScreen.width / 4, allScreen.height / 4) contentMode:PHImageContentModeAspectFit options:reques resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            self->_imageView.image = result;
        } else{
            self->_imageView.image = [UIImage imageNamed:@"noimage"];
        }
        self->_imageView.contentMode = UIViewContentModeScaleAspectFit;
        self->_imageView.clipsToBounds = YES;
        self->_imageView.userInteractionEnabled = YES;
        
    }];
}
@end
