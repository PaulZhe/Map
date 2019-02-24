//
//  MAPAddDynamicStateViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddDynamicStateViewController.h"
#import <Masonry.h>

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
    //设置地图的代理
    [_addDynamicStateView.mapView viewWillAppear];
    _addDynamicStateView.mapView.delegate = self;
    __weak typeof(self) weakSelf = self;
    [_addDynamicStateView addTapBlock:^(UIButton * _Nonnull sender) {
        //地点微调点击事件;
        [weakSelf adjustmentLocationAction];
    }];
    
    [_addDynamicStateView.addPicturesView.addPictureButton addTarget:self action:@selector(openPhotoAlbumAddPicture:) forControlEvents:UIControlEventTouchUpInside];
    [_addDynamicStateView.addVedioView.addVedioButton addTarget:self action:@selector(openPhotoAlbumAddPicture:) forControlEvents:UIControlEventTouchUpInside];
    
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
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pickerController = [[UIImagePickerController alloc] init];
    _pickerController.delegate = self;
    _pickerController.allowsEditing = YES;
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

#pragma MAP   --------------打开相册选取图片-------------------
//打开相册添加图片
- (void) openPhotoAlbumAddPicture:(UIButton *) button {
    BOOL isPicker = NO;
    //打开相册
    _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    isPicker = true;
    if (isPicker) {
        [self presentViewController:_pickerController animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //    获取图片
//    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //    获取图片后返回
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //    返回
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}

@end
