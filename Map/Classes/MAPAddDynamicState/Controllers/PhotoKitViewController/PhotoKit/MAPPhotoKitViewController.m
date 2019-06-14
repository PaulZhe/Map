//
//  MAPPhotoKitViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/3/5.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPPhotoKitViewController.h"
#import <Photos/Photos.h>
#import <Masonry.h>
#import "MAPPhotoSelectViewController.h"

@interface MAPPhotoKitViewController ()

@end

@implementation MAPPhotoKitViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(BackToHomePage:)];
    backButtonItem.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.photoesArray = [[NSMutableArray alloc] init];
    //打开图库
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addSubViews];
                });
            } else {
                NSLog(@"关闭了权限，需要授权");
            }
        }];
    } else {
        [self addSubViews];
    }
}

- (instancetype) initWithMaxCount:(NSString *)maxCountString andIsHaveOriginal:(NSString *)isHaveOriginal andOldImagesDictonary:(NSDictionary *)oldImagesDictionary andIfGetImageArray:(BOOL)ifNeedImageArray {
    self = [super init];
    if (self) {
        _maxCountString = maxCountString;
        _isHaveOriginal = isHaveOriginal;
        _imageDictionary = oldImagesDictionary;
        _ifNeed = ifNeedImageArray;
    }
    return self;
}

//在该界面添加scrollerView
- (void) addSubViews {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    scrollView.tag = 5000;
    [self.view addSubview:scrollView];
    
    //获取相册分类
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        //获取一个相册PHAssetCollection
        PHCollection *collection = smartAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *) collection;
            if ([assetCollection.localizedTitle isEqualToString:@"相机胶卷"] || [assetCollection.localizedTitle isEqualToString:@"所有照片"]) {
                [self.photoesArray insertObject:assetCollection atIndex:0];
            }else if ([assetCollection.localizedTitle isEqualToString:@"视频"]){
                
            }else if ([assetCollection.localizedTitle isEqualToString:@"已隐藏"]){
                
            }else if ([assetCollection.localizedTitle isEqualToString:@"最近删除"]){
                
            }
            else{
                [self.photoesArray addObject:assetCollection];
            }
        } else {
            NSAssert1(NO, @"Fetch collection not PHCollection: %@", collection);
        }
    }
    
    //获取相册分类中的图片
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for (NSInteger i = 0; i < topLevelUserCollections.count; i++) {
        //获取图片
        PHCollection *collection = topLevelUserCollections[i];
        NSLog(@"pictures %ld = %@", i, collection);
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollecion = (PHAssetCollection *) collection;
            [self.photoesArray addObject:assetCollecion];
        } else {
            NSAssert1(NO, @"Fetch collection not PHCollection: %@", collection);
        }
    }
    
    for (NSInteger i = 0; i < self.photoesArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 60*i, self.view.frame.size.width, 60);
        button.tag = 1001 + i;
        [button addTarget:self action:@selector(pushPhotoAlubum:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.frame = CGRectMake(0, 59.5, self.view.frame.size.width, 0.5);
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [button addSubview:lineLabel];
        PHAssetCollection *assetCollection = self.photoesArray[i];
        PHFetchResult *fectchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.frame = CGRectMake(70, 5, self.view.frame.size.width - 70, 60);
        titleLable.text = [NSString stringWithFormat:@"%@(%ld)", assetCollection.localizedTitle, fectchResult.count];
        [titleLable sizeToFit];
        [button addSubview:titleLable];
        
        PHAsset *asset = nil;
        if (fectchResult.count != 0) {
            asset = fectchResult[fectchResult.count - 1];
        }
        
        // 使用PHImageManager从PHAsset中请求图片
        PHImageManager *imageManager = [[PHImageManager alloc] init];
        [imageManager requestImageForAsset:asset targetSize:CGSizeMake(60, 60) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(0, 0, 60, 60);
            [button addSubview:imageView];
            if (result) {
                imageView.image = result;
            } else {
                imageView.image = [UIImage imageNamed:@"noimage"];
            }
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }];
    }
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.photoesArray.count*60);
}

//跳向图库界面
- (void)pushPhotoAlubum:(UIButton *) button {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (PHAsset *asset in [PHAsset fetchAssetsInAssetCollection:[self.photoesArray objectAtIndex:button.tag - 1001] options:nil]) {
        [array addObject:asset];
    }
    
    MAPPhotoSelectViewController *selectViewController = [[MAPPhotoSelectViewController alloc] init];
    selectViewController.PHFetchResult = [PHAsset fetchAssetsInAssetCollection:[_photoesArray objectAtIndex:button.tag - 1001] options:nil];
    PHAssetCollection *assetCollection = [_photoesArray objectAtIndex:button.tag - 1001];
    selectViewController.albumIdentifier = assetCollection.localIdentifier;
    selectViewController.maxcount = [_maxCountString integerValue];
    selectViewController.isOriginal = _isHaveOriginal;
    selectViewController.mySubmitDictionary = _imageDictionary;
    selectViewController.imageDictionary = _imageDictionary;
    selectViewController.haveCount = [_imageDictionary[@"imageDataArray"] count];
    selectViewController.ifNeed = _ifNeed;
    __weak MAPPhotoKitViewController *weakself = self;
    [selectViewController setGetSubmitDictionary:^(NSMutableDictionary * _Nonnull submitDictionary) {
        if (weakself.getSubmitDictionary) {
            weakself.imageDictionary = submitDictionary;
            weakself.getSubmitDictionary(submitDictionary);
        }
    }];
    [self.navigationController pushViewController:selectViewController animated:YES];
}

//返回至添加图片界面
- (void) BackToHomePage:(UIButton *) button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
