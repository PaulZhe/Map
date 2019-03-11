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
    
    //右上角选择按钮
    UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 64, 0, 64, 64)];
    [selectButton addTarget:selectButton action:@selector(pressSelecte:) forControlEvents:UIControlEventTouchUpInside];
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
    UIButton *comepleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.height - 80, 5, 80, 40)];
    comepleteButton.tag = 150000;
    [comepleteButton addTarget:self action:@selector(pressComplete:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:comepleteButton];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (comepleteButton.frame.size.height - 20)/2, 20, 20)];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.backgroundColor = [UIColor greenColor];
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
    
}

//点击完成
- (void)pressComplete:(UIButton *)button {
    
}
@end
