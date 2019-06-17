//
//  MAPAddVedioViewController.m
//  Map
//
//  Created by _祀梦 on 2019/6/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddVedioViewController.h"
#import "MAPAddDynamicStateView.h"
#import "MAPAddPointManager.h"
#import <Masonry.h>

@interface MAPAddVedioViewController () <BMKMapViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    NSMutableArray *annotationMutableArray;
}
@property (nonatomic, strong) MAPAddDynamicStateView *addDynamicStateView;

@end

@implementation MAPAddVedioViewController

- (MAPAddDynamicStateView *)addDynamicStateView {
    if (!_addDynamicStateView) {
        _addDynamicStateView = [[MAPAddDynamicStateView alloc] initWithTypeString:[NSString stringWithFormat:@"%d", 104]];
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
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(BackToHomePage:)];
    backButtonItem.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    //设置地图的代理
    [self.addDynamicStateView.mapView viewWillAppear];
    self.addDynamicStateView.mapView.delegate = self;
    
    //为上传视频设置picker
    self.addDynamicStateView.addVedioView.picker = [[UIImagePickerController alloc] init];
    self.addDynamicStateView.addVedioView.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.addDynamicStateView.addVedioView.picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    self.addDynamicStateView.addVedioView.picker.delegate = self;
    self.addDynamicStateView.addVedioView.picker.allowsEditing = YES;
    //给上传视频界面button设置点击事件
    [self.addDynamicStateView.addVedioView.addVedioButton addTarget:self action:@selector(clickAddVedioButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.addDynamicStateView.mapView viewWillDisappear];
    self.addDynamicStateView.mapView.delegate = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.addDynamicStateView.backgroundColor = [UIColor whiteColor];
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
                
            } error:^(NSError *error) {
                NSLog(@"%@", error);
            }];
            
        } else {
            
        }
        
    };
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
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSLog(@"data %@",data);
        UIImage *image = [self thumbnailImageForVideo:url];
        [_addDynamicStateView.addVedioView.addVedioButton setImage:image forState:UIControlStateNormal];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取视频封面，本地视频，网络视频都可以用
- (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(2.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
    return thumbImg;
}

- (void)dealloc
{
    NSLog(@"");
}

@end
