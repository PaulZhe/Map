//
//  MAPScrollerViewShowPhotoViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/3/9.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPScrollerViewShowPhotoViewController.h"
#import "MAPShowPhotoCollectionViewCell.h"

@interface MAPScrollerViewShowPhotoViewController ()
@property (nonatomic, strong) UIScrollView *imagesShowScrollerView;
@property (nonatomic, strong) UIScrollView *currentScroller;
@property (nonatomic, strong) UIImageView *currentImage;
@property (nonatomic, strong) NSMutableDictionary *thisSelectedDictionary;
@property (nonatomic, strong) UICollectionView *ImageShowCollectionView;
@property (nonatomic, strong) UIView *backBlackView;
@property (nonatomic, assign) float currentX;

@end

@implementation MAPScrollerViewShowPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    _freshSelectedMutableArray = [[NSMutableArray alloc] init];
    _submitDictionary = [[NSMutableDictionary alloc] init];
    _thisSelectedDictionary = [[NSMutableDictionary alloc] initWithDictionary:_lastDictionary];
    [_freshSelectedMutableArray addObjectsFromArray:_selectedButtonArray];
    [self creatView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)creatView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _ImageShowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    [_ImageShowCollectionView registerClass:[MAPShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    _ImageShowCollectionView.delegate = self;
    _ImageShowCollectionView.dataSource = self;
    _ImageShowCollectionView.backgroundColor = [UIColor blackColor];
    _ImageShowCollectionView.pagingEnabled = YES;
    _ImageShowCollectionView.showsVerticalScrollIndicator = NO;
    _ImageShowCollectionView.showsHorizontalScrollIndicator = NO;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    [self.view addSubview:_ImageShowCollectionView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressBackButton:)];
    [_ImageShowCollectionView addGestureRecognizer:tap];
    
    if (_whichOne.length > 0) {
        NSInteger which = [_whichOne integerValue];
        [_ImageShowCollectionView setContentOffset:CGPointMake(self.view.frame.size.width * which, 0)];
        
        _currentX = self.view.frame.size.width * which;
        _backBlackView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * which, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _backBlackView.backgroundColor = [UIColor blackColor];
        [_ImageShowCollectionView addSubview:_backBlackView];
        
        _imagesShowScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _backBlackView.frame.size.width, _backBlackView.frame.size.height)];
        _imagesShowScrollerView.showsHorizontalScrollIndicator = NO;
        _imagesShowScrollerView.showsVerticalScrollIndicator = NO;
        _imagesShowScrollerView.pagingEnabled = NO;
        _imagesShowScrollerView.delegate = self;
        _imagesShowScrollerView.maximumZoomScale = 3.0;//图片的放大倍数
        _imagesShowScrollerView.minimumZoomScale = 1.0;//图片的最小倍率
        
        _currentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, _backBlackView.frame.size.width, _backBlackView.frame.size.height)];
        
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.synchronous = NO;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        [[PHImageManager defaultManager] requestImageForAsset:[_PHFectchResult objectAtIndex:which] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                self->_currentImage.image = result;
            } else {
                self->_currentImage.image = [UIImage imageNamed:@"noimage"];
            }
            self->_currentImage.contentMode = UIViewContentModeScaleAspectFit;
            self->_currentImage.clipsToBounds = YES;
        }];
        _currentImage.tag = 1000;
        _currentImage.contentMode = UIViewContentModeScaleAspectFit;
        [_imagesShowScrollerView addSubview:_currentImage];
        [_backBlackView addSubview:_imagesShowScrollerView];
        [_ImageShowCollectionView bringSubviewToFront:_backBlackView];
    } else {
        _currentX = 0;
    }
    
    //透明按钮
    UIButton *backClearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [backClearButton addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
    backClearButton.backgroundColor = [UIColor clearColor];
    [_imagesShowScrollerView addSubview:backClearButton];
    
    //上方视图
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    topView.tag = 10000;
    [self.view addSubview:topView];
    
    //返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    [backButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(backButton.center.x - 10, backButton.center.y - 10, 20, 20)];
    backImageView.image = [UIImage imageNamed:@"photoBack"];
    [backButton addSubview:backImageView];
    
    //点击选择按钮
    UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 64, 0, 64, 64)];
    [selectButton addTarget:self action:@selector(pressSelecte:) forControlEvents:UIControlEventTouchUpInside];
    selectButton.tag = 15000;
    [topView addSubview:selectButton];
    
    UIImageView *selecteImageView = [[UIImageView alloc] initWithFrame:CGRectMake((64 - 30)/2, (64 - 30)/2, 30, 30)];
    selecteImageView.tag = 15001;
    selecteImageView.image = [UIImage imageNamed:@"ico_check_nomal"];
    [selectButton addSubview:selecteImageView];
    [selectButton setSelected:NO];
    
    PHAssetCollection *assetCollection = (PHAssetCollection *)_PHFectchResult[[_whichOne integerValue]];
    NSArray *photoArray = _thisSelectedDictionary[@"photoArray"];
    
    for (int i = 0; i < photoArray.count; i++) {
        if ([assetCollection.localIdentifier isEqualToString:photoArray[i][@"photoIdentifier"]]) {
            selecteImageView.image = [UIImage imageNamed:@"ico_check_select"];
            [selectButton setSelected:YES];
        } else {
            
        }
    }
    
    //下方视图
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    downView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    downView.tag = 11000;
    [self.view addSubview:downView];
    
    //完成按钮
    UIButton *comepleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 5, 80, 40)];
    comepleteButton.tag = 150000;
    [comepleteButton addTarget:self action:@selector(pressComplete:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:comepleteButton];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (comepleteButton.frame.size.height - 20)/2, 20, 20)];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.backgroundColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];;
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.layer.cornerRadius = 10;
    numberLabel.clipsToBounds = YES;
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.tag = 16000;
    [comepleteButton addSubview:numberLabel];
    if (photoArray.count >= 1) {
        numberLabel.text = [NSString stringWithFormat:@"%ld", photoArray.count];
    } else {
        numberLabel.hidden = YES;
    }
    
    UILabel *completeLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabel.frame.origin.x + numberLabel.frame.size.width, (comepleteButton.frame.size.height - 30) / 2, 60, 30)];
    completeLabel.text = @"完成";
    completeLabel.textColor = [UIColor whiteColor];
    completeLabel.textAlignment = NSTextAlignmentCenter;
    [comepleteButton addSubview:completeLabel];
}

#pragma mark - collectinoDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _PHFectchResult.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MAPShowPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    [cell getBigImageWithAsset:_PHFectchResult[indexPath.item]];
    return cell;
}

#pragma MAP  -------------button点击事件---------------
//返回按钮
- (void)pressBack {
    [self.navigationController popViewControllerAnimated:YES];
    _selectedDictionaryBlock(_thisSelectedDictionary);
}

//点击背景
- (void)pressBackButton:(UIButton *)button {
    UIView *upView = (id)[self.view viewWithTag:10000];
    UIView *downView = (id)[self.view viewWithTag:11000];
    if (upView.hidden == YES) {
        upView.hidden = NO;
        downView.hidden = NO;
    }else{
        upView.hidden = YES;
        downView.hidden = YES;
    }
}

//点击选择
- (void)pressSelecte:(UIButton *)button {
    int current = _backBlackView.frame.origin.x/self.view.frame.size.width;
    NSMutableArray *photoArray = [NSMutableArray arrayWithArray:_thisSelectedDictionary[@"photoArray"]];
    PHAssetCollection *assetCollection = (PHAssetCollection *)_PHFectchResult[current];
    UIImageView *imageView = (id)[button viewWithTag:15001];
    if (button.selected == NO) {
        if (photoArray.count >= _maxCount) {
            [button setSelected:NO];
        } else {
            imageView.image = [UIImage imageNamed:@"ico_check_select"];
            [_freshSelectedMutableArray addObject:[NSString stringWithFormat:@"%d", current + 10000]];
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setValue:[NSString stringWithFormat:@"%@", assetCollection.localIdentifier] forKey:@"photoIdentifier"];
            [dictionary setValue:_alumbIdentifier forKey:@"albumIdentifier"];
            [dictionary setValue:_PHFectchResult[current] forKey:@"photoAsset"];
            [photoArray addObject:dictionary];
            [_thisSelectedDictionary setObject:photoArray forKey:@"photoArray"];
            [button setSelected:YES];
        }
    } else {
        imageView.image = [UIImage imageNamed:@"ico_check_nomal"];
        [button setSelected:NO];
        for (int i = 0; i < _freshSelectedMutableArray.count; i++) {
            if (current == [_freshSelectedMutableArray[i] integerValue] - 10000) {
                [_freshSelectedMutableArray removeObjectAtIndex:i];
            }
        }
        
        for (int i = 0; i < [photoArray count]; i++) {
            if ([photoArray[i][@"photoIdentifier"] isEqualToString:assetCollection.localIdentifier]) {
                [photoArray removeObjectAtIndex:i];
                button.selected = NO;
            }
        }
        [_thisSelectedDictionary setObject:photoArray forKey:@"photoArray"];
    }
    
    UILabel *comlpleteLable = (id)[self.view viewWithTag:16000];
    comlpleteLable.text = [NSString stringWithFormat:@"%ld", [_thisSelectedDictionary[@"photoArray"] count]];
    NSLog(@"text = %@", comlpleteLable.text);
    if ([_thisSelectedDictionary[@"photoArray"] count] == 0) {
        comlpleteLable.hidden = YES;
    } else {
        comlpleteLable.hidden = NO;
    }
    
    if ([_isOriginalString isEqualToString:@"1"]) {
        [_submitDictionary setObject:@"1" forKey:@"isOriginal"];
    }else{
        [_submitDictionary setObject:@"0" forKey:@"isOriginal"];
    }
    
    NSMutableArray *myPhotoArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _freshSelectedMutableArray.count; i++) {
        NSMutableDictionary *photoDictionary = [[NSMutableDictionary alloc] init];
        PHAssetCollection *assetCollection = (PHAssetCollection *)_PHFectchResult[[_freshSelectedMutableArray[i] integerValue] - 10000];
        [photoDictionary setObject:[NSString stringWithFormat:@"%@",assetCollection.localIdentifier] forKey:@"photoIdentifier"];
        [photoDictionary setObject:_alumbIdentifier forKey:@"albumIdentifier"];
        [photoDictionary setObject:_PHFectchResult[[_freshSelectedMutableArray[i] integerValue] - 10000] forKey:@"photoAsset"];
        [myPhotoArray addObject:photoDictionary];
    }
    [_submitDictionary setObject:myPhotoArray forKey:@"photoArray"];
    
    if (_isNeed == YES) {
        __weak MAPScrollerViewShowPhotoViewController *showPhotoSelf = self;
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < _freshSelectedMutableArray.count; i++) {
            PHImageRequestOptions *requsetOptions = [[PHImageRequestOptions alloc] init];
            requsetOptions.synchronous = NO;
            requsetOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
            requsetOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
            
            [[PHImageManager defaultManager] requestImageForAsset:_PHFectchResult[[_freshSelectedMutableArray[i] integerValue] - 10000] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:requsetOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    NSData *imageData = UIImageJPEGRepresentation(result, 0.3);
                    UIImage *image = [UIImage imageWithData:imageData];
                    NSData *imageDatatwo = [showPhotoSelf resetSizeOfImageData:image maxSize:100];
                    [dataArray addObject:imageDatatwo];
                } else {
                    
                }
            }];
            [_submitDictionary setObject:dataArray forKey:@"imageDataArray"];
        }
    } else {
        
    }
    
    if (_freshSelectedMutableArray.count > 0) {

    } else {
        NSArray *dataArray = [[NSArray alloc] init];
        [_submitDictionary setObject:dataArray forKey:@"imageDataArray"];
    }
}

//点击完成
- (void)pressComplete:(UIButton *)button {
    NSArray *photoArray = _thisSelectedDictionary[@"photoArray"];
//    __weak MAPScrollerViewShowPhotoViewController *detailSelf = self;
    NSMutableArray *dataMutableArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < photoArray.count; i++) {
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.synchronous = NO;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        for (int j = 0; j < _PHFectchResult.count; j++) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)_PHFectchResult[j];
            if ([assetCollection.localIdentifier isEqualToString:photoArray[i][@"photoIdentifier"]]) {
                [[PHImageManager defaultManager] requestImageForAsset:_PHFectchResult[j] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    if (result) {
                        NSData *imageData = UIImageJPEGRepresentation(result, 0.3);
                        UIImage *image = [UIImage imageWithData:imageData];
                        NSData *imageDataTwo = [self resetSizeOfImageData:image maxSize:100];
                        [dataMutableArray addObject:imageDataTwo];
                    } else {
                        
                    }
                }];
            }
        }
        [_thisSelectedDictionary setObject:dataMutableArray forKey:@"imageDataArray"];
    }
    self.getSubmitDictionary(_thisSelectedDictionary);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//改变分辨率
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
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

#pragma mark - scrollViewDelegtate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_ImageShowCollectionView]) {
        _currentX = scrollView.contentOffset.x;
        _backBlackView.frame = CGRectMake(scrollView.contentOffset.x, _currentScroller.frame.origin.y, _currentScroller.frame.size.width, _currentScroller.frame.size.height);
        _currentScroller.zoomScale = 1.0;
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.synchronous = NO;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        [[PHImageManager defaultManager] requestImageForAsset:[self.PHFectchResult objectAtIndex:scrollView.contentOffset.x / self.view.frame.size.width] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                self->_currentImage.image = result;
            }else{
                self->_currentImage.image = [UIImage imageNamed:@"noimage"];
            }
            self->_currentImage.contentMode = UIViewContentModeScaleAspectFit;
            self->_currentImage.clipsToBounds = YES;
            [self->_ImageShowCollectionView bringSubviewToFront:self->_backBlackView];
            self->_currentImage.hidden = NO;
        }];
        UIButton *selectedButton = (id)[self.view viewWithTag:15000];
        UIImageView *selectImageView = (id)[selectedButton viewWithTag:15001];
        int current = scrollView.contentOffset.x / self.view.frame.size.width;
        
        PHAssetCollection *assetCollection = (PHAssetCollection *)_PHFectchResult[current];
        NSArray *photoArray = _thisSelectedDictionary[@"photoArray"];
        
        for (int j = 0; j < photoArray.count; j++) {
            if ([assetCollection.localIdentifier isEqualToString:photoArray[j][@"photoIdentifier"]]) {
                [selectedButton setSelected:YES];
                selectImageView.image = [UIImage imageNamed:@"ico_check_select"];
                break;
            }else{
                [selectedButton setSelected:NO];
                selectImageView.image = [UIImage imageNamed:@"ico_check_nomal"];
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_ImageShowCollectionView]) {
        float a = ABS(scrollView.contentOffset.x - _currentX);
        if (a > self.view.frame.size.width / 2) {
            _currentImage.image = nil;
            _backBlackView.hidden = YES;
        }
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _currentImage;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //scrollView放大代理
    if (scrollView != _ImageShowCollectionView) {
        CGPoint uiii;
        if (scrollView.contentSize.width>scrollView.frame.size.width) {
            uiii.x = scrollView.contentSize.width/2.0;
        }else{
            uiii.x = scrollView.frame.size.width/2.0;
        }
        if (scrollView.contentSize.height>scrollView.frame.size.height) {
            uiii.y = scrollView.contentSize.height/2.0;
        }else{
            uiii.y = scrollView.frame.size.height/2.0;
        }
        _currentImage.center = uiii;
    }
}
@end
