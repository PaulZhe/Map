//
//  MAPMotivePicturesView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/24.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPMotivePicturesView.h"
#import "MAPMotivePicturesCollectionViewCell.h"

@interface MAPMotivePicturesView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@end

@implementation MAPMotivePicturesView

- (instancetype) init {
    self = [super init];
    if (self) {
        //这里是图片
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //垂直方向滚动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _picturesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 80, 200) collectionViewLayout:flowLayout];
        //注册collectionView的cell
        [_picturesCollectionView registerClass:[MAPMotivePicturesCollectionViewCell class] forCellWithReuseIdentifier:@"pictures"];
        _picturesCollectionView.dataSource = self;
        _picturesCollectionView.delegate = self;
        _picturesCollectionView.backgroundColor = [UIColor clearColor];
        _picturesCollectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:_picturesCollectionView];
    }
    return self;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MAPMotivePicturesCollectionViewCell *cell = [_picturesCollectionView dequeueReusableCellWithReuseIdentifier:@"pictures" forIndexPath:indexPath];
    NSString* str1 = [NSString stringWithFormat:@"upPicture1"];
    NSString* str2 = [NSString stringWithFormat:@"upPicture2"];
    NSString* str3 = [NSString stringWithFormat:@"upPicture3"];
    NSString* str4 = [NSString stringWithFormat:@"upPicture4"];
    NSString* str5 = [NSString stringWithFormat:@"upPicture5"];
    NSString* str6 = [NSString stringWithFormat:@"upPicture6"];
    NSString* str7 = [NSString stringWithFormat:@"upPicture7"];
    NSString* str8 = [NSString stringWithFormat:@"upPicture8"];
    NSString* str9 = [NSString stringWithFormat:@"upPicture9"];
    NSString* str10 = [NSString stringWithFormat:@"upPicture10"];
    NSString* str11 = [NSString stringWithFormat:@"upPicture11"];
    NSString* str12 = [NSString stringWithFormat:@"upPicture12"];
    NSArray* sec = [NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, str11, str12, nil];
    cell.picturesImageView.image = [UIImage imageNamed:[sec objectAtIndex:indexPath.item]];
    return cell;
}

//返回Footer大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
}

//返回Header大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
}

//返回每个cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 111)/3, ([UIScreen mainScreen].bounds.size.width - 111)/3);
}

//返回cell之间 行 间隙
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//返回cell之间 列 间隙
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设置上下左右边界缩紧
- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
