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

@interface MAPAddDynamicStateViewController () {
    NSMutableArray *annotationMutableArray;
}

@end

@implementation MAPAddDynamicStateViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(BackToHomePage:)];
    backButtonItem.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    _addDynamicStateView = [[MAPAddDynamicStateView alloc] initWithTypeString:_typeString];
    [self.view addSubview:_addDynamicStateView];
    [_addDynamicStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    //设置跳转相册代理
    _addDynamicStateView.addPicturesView.delegate = self;
    //设置地图的代理
    [_addDynamicStateView.mapView viewWillAppear];
    _addDynamicStateView.mapView.delegate = self;
    __weak typeof(self) weakSelf = self;
    [_addDynamicStateView addTapBlock:^(UIButton * _Nonnull sender) {
        //地点微调点击事件;
        [weakSelf adjustmentLocationAction];
    }];

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_addDynamicStateView.mapView viewWillDisappear];
    _addDynamicStateView.mapView.delegate = nil;
}

//显示定位点
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc] init];
    [annotation setCoordinate:CLLocationCoordinate2DMake(_Latitude, _Longitud)];
    annotation.title = @"";
    [_addDynamicStateView.mapView addAnnotation:annotation];
    annotationMutableArray = [NSMutableArray array];
    [annotationMutableArray addObject:annotation];
    [_addDynamicStateView.mapView showAnnotations:annotationMutableArray animated:YES];
    
    //测试上传图片
//    NSArray *imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"upPicture1"], [UIImage imageNamed:@"uoPicture2"], nil];
//    [self postImageCommentWithArray:imageArray andTitle:@"Test"];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


}

//添加自定义点
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        BMKAnnotationView *annotationView = (BMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"local"];
        return annotationView;
    }
    return nil;
}

//导航栏返回按钮点击事件
- (void) BackToHomePage:(UIButton *) button {
    [self.navigationController popViewControllerAnimated:YES];
}

//地点微调点击事件;
- (void) adjustmentLocationAction {
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
