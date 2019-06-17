//
//  MAPAddDynamicStateViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddDynamicStateViewController.h"
#import "MAPAddPointManager.h"
#import <Masonry.h>
#import <Photos/Photos.h>
#import "MAPPhotoKitViewController.h"

@interface MAPAddDynamicStateViewController () <MAPAddPicturesViewDelegate, UINavigationControllerDelegate>
{
    NSMutableArray *annotationMutableArray;
}

@end

@implementation MAPAddDynamicStateViewController

- (MAPAddDynamicStateView *)addDynamicStateView {
    if (!_addDynamicStateView) {
        _addDynamicStateView = [[MAPAddDynamicStateView alloc] initWithTypeString:_typeString];
        [self.view addSubview:_addDynamicStateView];
        [_addDynamicStateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
    }
    return _addDynamicStateView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(BackToHomePage:)];
    backButtonItem.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    self.addDynamicStateView.locationNameLabel.text = _pointName;

    //为上传视频设置picker
    _addDynamicStateView.addVedioView.picker = [[UIImagePickerController alloc] init];
    _addDynamicStateView.addVedioView.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _addDynamicStateView.addVedioView.picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    _addDynamicStateView.addVedioView.picker.delegate = self;
    _addDynamicStateView.addVedioView.picker.allowsEditing = YES;
    //给上传视频界面button设置点击事件
    [_addDynamicStateView.addVedioView.addVedioButton addTarget:self action:@selector(clickAddVedioButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置跳转相册代理
    _addDynamicStateView.addPicturesView.delegate = self;
    //设置地图的代理
    [_addDynamicStateView.mapView viewWillAppear];
    _addDynamicStateView.mapView.delegate = self;
    __weak typeof(self) weakSelf = self;
    self.addDynamicStateView.adjustAction = ^(UIButton * _Nonnull sender) {
        //地点微调点击事件;
        [weakSelf adjustmentLocationAction];
    };
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_addDynamicStateView.mapView viewWillDisappear];
    _addDynamicStateView.mapView.delegate = nil;
}

//显示定位点
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    [annotation setCoordinate:CLLocationCoordinate2DMake(_Latitude, _Longitud)];
    annotation.title = @"";
    [_addDynamicStateView.mapView addAnnotation:annotation];
    annotationMutableArray = [NSMutableArray array];
    [annotationMutableArray addObject:annotation];
    [_addDynamicStateView.mapView showAnnotations:annotationMutableArray animated:YES];
    

    self.addDynamicStateView.locationNameLabel.text = _pointName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加发布点点击事件
    [self createChildView];
}

//更新语音时长标签
- (void)refreshData {
    if ([_typeString isEqualToString:@"103"]) {
        NSString *timeStr;
        if (_addDynamicStateView.issueAudioView.minutes == 0) {
            timeStr = [NSString stringWithFormat:@"%ds", _addDynamicStateView.issueAudioView.seconds];
        } else {
            timeStr = [NSString stringWithFormat:@"%dm%ds", _addDynamicStateView.issueAudioView.minutes, _addDynamicStateView.issueAudioView.seconds];
        }
        _addDynamicStateView.issueAudioView.motiveAudioButton.timeLabel.text = timeStr;
    }
}

//添加发布点点击事件
- (void)createChildView {
    self.addDynamicStateView.locationNameLabel.text = _pointName;
    __weak typeof(self) weakSelf = self;
    self.addDynamicStateView.issueAction = ^(UIButton * _Nonnull sender) {
        if (weakSelf.isSelected == NO) {
            //addPointManager测试
            MAPAddPointManager *addPointManager = [MAPAddPointManager sharedManager];
            [addPointManager addPointWithName:weakSelf.pointName Latitude:22.278 Longitude:114.158 success:^(MAPAddPointModel *resultModel) {
                    NSLog(@"%@++++", resultModel.message);
                    //更新添加点
                    [weakSelf variousKindsInterfaceAddActions];
                } error:^(NSError *error) {
                    NSLog(@"%@", error);
                }];
            
        } else {
            [weakSelf variousKindsInterfaceAddActions];
        }
        
    };
}

//添加评论
- (void)addCommentsWithPointID:(int)ID Content:(NSString *)content {
    MAPAddPointManager *manager = [MAPAddPointManager sharedManager];
    [manager addMessageWithPointId:ID
                           Content:content
                           success:^(MAPAddPointModel *resultModel) {
                               NSLog(@"addComment:%@", resultModel.message);
                           } error:^(NSError *error) {
                               NSLog(@"%@", error);
                           }];
}

//各个不同界面的点击事件
- (void)variousKindsInterfaceAddActions {
    __weak typeof(self) weakSelf = self;
    if ([_typeString isEqualToString:@"101"]) {
        //添加评论
        [self addCommentsWithPointID:_ID Content:self.addDynamicStateView.addCommentView.addCommentTextView.text];
    } else if ([_typeString isEqualToString:@"102"]) {
        
    } else if ([_typeString isEqualToString:@"103"]) {
        NSData *mp3Cache = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:weakSelf.addDynamicStateView.mp3Path]];
        [[MAPAddPointManager sharedManager] uploadAudioWithPointId:weakSelf.ID Data:mp3Cache Type:2 Second:weakSelf.addDynamicStateView.issueAudioView.seconds Minutes:weakSelf.addDynamicStateView.issueAudioView.minutes success:^(MAPAddPointModel *resultModel) {
            NSLog(@"mp3上传成功");
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } error:^(NSError *error) {
            NSLog(@"mp3上传失败");
        }];
    } else if ([_typeString isEqualToString:@"104"]) {
        
    }
}


//给视频界面button添加事件
- (void)clickAddVedioButton:(UIButton *)button {
    [self presentViewController:_addDynamicStateView.addVedioView.picker animated:YES completion:nil];
}

//获取到视频后返回
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.movie"]){
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];//获得视频的URL
        NSLog(@"url %@",url);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//添加自定义点
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"local"];
        return annotationView;
    }
    return nil;
}

//导航栏返回按钮点击事件
- (void)BackToHomePage:(UIButton *) button {
    [self.navigationController popViewControllerAnimated:YES];
}

//地点微调点击事件;
- (void)adjustmentLocationAction {
    NSLog(@"点击了");
}

// 上传图片评论
- (void)postImageCommentWithArray:(NSArray *)imageArray andTitle:(NSString *)title {
    NSMutableArray *dataArray = [NSMutableArray array];
    for (id image in imageArray) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [dataArray addObject:imageData];
    }
    __weak MAPAddDynamicStateViewController *weakSelf = self;

    [[MAPAddPointManager sharedManager] uploadPhotosWithPointId:6 Title:title Data:dataArray success:^(MAPAddPointModel *resultModel) {
        NSLog(@"上传成功");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        NSLog(@"上传失败");
    }];
}

#pragma MAP   --------------打开相册选取图片-------------------
- (void)getToPhotoAlbumViewAndViewController:(UINavigationController *)navigationController{
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
