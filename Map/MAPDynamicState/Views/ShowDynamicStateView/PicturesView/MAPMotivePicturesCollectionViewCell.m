//
//  MAPMotivePicturesCollectionViewCell.m
//  Map
//
//  Created by 涂强尧 on 2019/1/24.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPMotivePicturesCollectionViewCell.h"

@implementation MAPMotivePicturesCollectionViewCell

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _picturesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self.contentView addSubview:_picturesImageView];
    }
    return self;
}
@end
