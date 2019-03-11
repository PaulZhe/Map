//
//  MAPPhotoSelectViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/3/5.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPPhotoSelectViewController.h"
#import <Masonry.h>
#import "MAPPhotoSelectCollectionViewCell.h"

@interface MAPPhotoSelectViewController ()
@property (nonatomic, strong) UICollectionView *selectedCollectionView;
@property (nonatomic, strong) NSMutableDictionary *submitDictionary;
@property (nonatomic, strong) NSMutableDictionary *thisSelecteDictionary;
@property (nonatomic, assign) dispatch_queue_t queue;
@property (nonatomic, assign) NSInteger page;
@end

@implementation MAPPhotoSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.isOriginal.length > 0) {
        
    } else {
        self.isOriginal = @"0";
    }
    //设置导航栏button
    [self setNavigationButton];
    //设置九宫格显示图片
    [self addSubview];
}

#pragma MAP  -------------------------设置导航栏button--------------------
- (void) setNavigationButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToLastView:)];
    leftButton.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backToFirstView:)];
    cancelButton.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.rightBarButtonItem = cancelButton;
}

- (void)backToLastView:(UIButton *) button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backToFirstView:(UIButton *) button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma MAP  -------------------------设置collectionView--------------------
- (void)addSubview {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.selectedCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 5, self.view.frame.size.width, self.view.frame.size.height - 64 - 50) collectionViewLayout:flowLayout];
    [_selectedCollectionView registerClass:[MAPPhotoSelectCollectionViewCell class] forCellWithReuseIdentifier:@"photoes"];
    _selectedCollectionView.delegate = self;
    _selectedCollectionView.dataSource = self;
    _selectedCollectionView.backgroundColor = [UIColor whiteColor];
    _selectedCollectionView.showsVerticalScrollIndicator = YES;
    _selectedCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_selectedCollectionView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *completeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 5, 80, 40)];
    completeButton.tag = 15000;
    [completeButton addTarget:self action:@selector(pressComplete:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:completeButton];
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (completeButton.frame.size.height - 20) / 2, 20, 20)];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.backgroundColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.layer.cornerRadius = 10;
    numberLabel.clipsToBounds = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.tag = 16000;
    NSArray *photoArray = _submitDictionary[@"photoArray"];
    if (photoArray.count >= 1) {
        numberLabel.text = [NSString stringWithFormat:@"%ld", photoArray.count];
    } else {
        numberLabel.hidden = YES;
    }
    [completeButton addSubview:numberLabel];
    
    UILabel *completeLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabel.frame.origin.x + numberLabel.frame.size.width, (completeButton.frame.size.height - 30) / 2, 60, 30)];
    completeLabel.text = @"完成";
    completeLabel.textAlignment = NSTextAlignmentCenter;
    [completeButton addSubview:completeLabel];
}

//完成按钮点击事件
- (void)pressComplete:(UIButton *) button {
    self.getSubmitDictionary(_thisSelecteDictionary);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma MAP  ------------------------collectionViewDelegate---------------
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _PHFetchResult.count;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MAPPhotoSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoes" forIndexPath:indexPath];
    [cell getPhotoWithAset:_PHFetchResult[indexPath.item] andWhichOne:indexPath.item + 10000];
    PHAssetCollection *assetColletion = (PHAssetCollection *)_PHFetchResult[indexPath.item];
    NSArray *phtotArray = _thisSelecteDictionary[@"photoArray"];
    if (phtotArray.count > 0) {
        for (int i = 0; i < phtotArray.count; i++) {
            if ([phtotArray[i][@"photoIdentifier"] isEqualToString:assetColletion.localIdentifier]) {
                cell.selectButton.selected = YES;
                break;
            }else{
                cell.selectButton.selected = NO;
            }
        }
    }
    return cell;
}

//返回每个cell大小
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 25) / 4, (self.view.frame.size.width - 25) / 4);
}

//返回cell之间 行 间隙
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

//返回cell之间 列 间隙
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

//调整图片分辨率
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        if ([finallImageData length]/1024>200) {
            NSData *finallImageData1 = UIImageJPEGRepresentation(newImage,0.30);
            return finallImageData1;
        }
        return finallImageData;
    }
    return imageData;
}

@end
