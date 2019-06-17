//
//  MAPAddPicturesViewController.m
//  Map
//
//  Created by _祀梦 on 2019/6/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddPicturesViewController.h"
#import "MAPAddDynamicStateView.h"
#import <Masonry.h>

@interface MAPAddPicturesViewController () <BMKMapViewDelegate> {
    NSMutableArray *annotationMutableArray;
}
@property (nonatomic, strong) MAPAddDynamicStateView *addDynamicStateView;
@end

@implementation MAPAddPicturesViewController

- (MAPAddDynamicStateView *)addDynamicStateView {
    if (!_addDynamicStateView) {
        _addDynamicStateView = [[MAPAddDynamicStateView alloc] initWithTypeString:[NSString stringWithFormat:@"%d", 102]];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.addDynamicStateView.addPicturesView.backgroundColor = [UIColor whiteColor];
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

@end
