//
//  MAPScrollerViewShowPhotoViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/3/9.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPScrollerViewShowPhotoViewController.h"
#import "MAPPhotoSelectCollectionViewCell.h"

@interface MAPScrollerViewShowPhotoViewController ()
@property (nonatomic, strong) UIScrollView *imagesShowScrollerView;
@property (nonatomic, strong) UIImageView *currentImage;
@property (nonatomic, strong) NSMutableDictionary *thisSelectedDictionary;
@property (nonatomic, strong) UICollectionView *ImageShowCollectionView;
@property (nonatomic, strong) UIView *backBlackView;

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
    [_ImageShowCollectionView registerClass:[MAPPhotoSelectCollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    _ImageShowCollectionView.delegate = self;
    _ImageShowCollectionView.dataSource = self;
    _ImageShowCollectionView.backgroundColor = [UIColor blackColor];
    _ImageShowCollectionView.pagingEnabled = YES;
    _ImageShowCollectionView.showsVerticalScrollIndicator = NO;
    _ImageShowCollectionView.showsHorizontalScrollIndicator = NO;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressBackButton:)];
    [_ImageShowCollectionView addGestureRecognizer:tap];
    
    
}

@end
