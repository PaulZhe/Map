//
//  MAPAddCommentsViewController.m
//  Map
//
//  Created by _祀梦 on 2019/6/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddCommentsViewController.h"
#import <Masonry.h>
#import "MAPAddDynamicStateView.h"
#import "MAPAddPointManager.h"
#import "MAPAnalyzeViewController.h"

@interface MAPAddCommentsViewController () <BMKMapViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
     NSMutableArray *annotationMutableArray;
}
@property (nonatomic, strong) MAPAddDynamicStateView *addDynamicStateView;
@end

@implementation MAPAddCommentsViewController

- (MAPAddDynamicStateView *)addDynamicStateView {
    if (!_addDynamicStateView) {
        _addDynamicStateView = [[MAPAddDynamicStateView alloc] initWithTypeString:[NSString stringWithFormat:@"%d", 101]];
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
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.addDynamicStateView.mapView viewWillDisappear];
    self.addDynamicStateView.mapView.delegate = nil;
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
    self.addDynamicStateView.addCommentView.backgroundColor = [UIColor whiteColor];
    self.pickerController.delegate = self;
    self.pickerController.allowsEditing = YES;
    [self.addDynamicStateView.addCommentView.takePictureButton addTarget:self action:@selector(clicekTakePictureButton:) forControlEvents:UIControlEventTouchUpInside];
}

//添加发布点点击事件
- (void)createChildView {
    self.addDynamicStateView.locationNameLabel.text = _pointName;
    __weak typeof(self) weakSelf = self;
    self.addDynamicStateView.issueAction = ^(UIButton * _Nonnull sender) {
        if (weakSelf.isSelected == NO) {
            //addPointManager测试
            MAPAddPointManager *addPointManager = [MAPAddPointManager sharedManager];
            [addPointManager addPointWithName:weakSelf.pointName Latitude:weakSelf.Latitude Longitude:weakSelf.Longitud success:^(MAPAddPointModel *resultModel) {
                NSLog(@"%@++++", resultModel.message);
                //更新添加点
                [weakSelf addCommentsWithPointID:weakSelf.ID Content:weakSelf.addDynamicStateView.addCommentView.addCommentTextView.text];
            } error:^(NSError *error) {
                NSLog(@"%@", error);
            }];
            
        } else {
            [weakSelf addCommentsWithPointID:weakSelf.ID Content:weakSelf.addDynamicStateView.addCommentView.addCommentTextView.text];
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

- (UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
    }
    return _pickerController;
}

//给图像识别添加点击事件
- (void)clicekTakePictureButton:(UIButton *)button {
    BOOL isPicker = NO;
    //判断相机是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        isPicker = true;
    }
    
    if (isPicker) {
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    MAPAnalyzeViewController *analyzeViewController = [[MAPAnalyzeViewController alloc] init];
    analyzeViewController.pictureImageView = [[UIImageView alloc] init];
    analyzeViewController.pictureImageView.image = image;
    [picker presentViewController:analyzeViewController animated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
