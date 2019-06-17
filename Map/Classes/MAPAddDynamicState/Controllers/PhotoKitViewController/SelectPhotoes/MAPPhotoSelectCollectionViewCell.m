//
//  MAPPhotoSelectCollectionViewCell.m
//  Map
//
//  Created by 涂强尧 on 2019/3/6.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPPhotoSelectCollectionViewCell.h"

#define allScreen [UIScreen mainScreen].bounds.size
@implementation MAPPhotoSelectCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (allScreen.width - 25) / 4, (allScreen.width - 25) / 4)];
        [self.contentView addSubview:_imageView];
        
        _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(_imageView.frame.size.width - 25, 0, 25, 25)];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"ico_check_nomal"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"ico_check_select"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:_selectButton];
    }
    return self;
}

- (void) getPhotoWithAset:(PHAsset *)myAsset andWhichOne:(NSInteger)which {
    self.which = _which;
    _selectButton.tag = which;
    
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc]init];
    requestOptions.synchronous = NO;
    requestOptions.networkAccessAllowed = NO;
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    [[PHImageManager defaultManager] requestImageForAsset:myAsset targetSize:CGSizeMake(allScreen.width/4, allScreen.height/4) contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            self->_imageView.image = result;
        }else{
            self->_imageView.image = [UIImage imageNamed:@"noimage"];
        }
        self->_imageView.contentMode = UIViewContentModeScaleAspectFill;
        self->_imageView.clipsToBounds = YES;
        self->_imageView.userInteractionEnabled = YES;
        
    }];
}

-(void)pressBtn:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(selectButton:)]) {
        [_delegate selectButton:button];
    }
}

@end
