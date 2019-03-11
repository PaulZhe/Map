//
//  MAPAddPicturesCollectionViewCell.m
//  Map
//
//  Created by 涂强尧 on 2019/3/7.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddPicturesCollectionViewCell.h"

@implementation MAPAddPicturesCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width - 41)/3, ([UIScreen mainScreen].bounds.size.width - 41)/3)];
        [self.contentView addSubview:_imageView];
    }
    return self;
}
@end
