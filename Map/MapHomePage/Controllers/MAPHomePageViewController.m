//
//  MAPHomePageViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/1/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPHomePageViewController.h"
#import "MAPAnnotationView.h"
#import "MAPDynamicStateViewController.h"

@interface MAPHomePageViewController () {
    NSMutableArray *annotationMutableArray;
}

@end

@implementation MAPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化地图
    [self createChileView];
    //初始化坐标
    [self createLocation];
    
    
    //测试泡泡内按钮点击事件
    [self paopaoViewButtonAddTarget];
}

- (void)createChileView {
    self.view.backgroundColor = [UIColor whiteColor];
    _homePageView = [[MAPHomePageView alloc] initWithFrame:self.view.bounds];
    [_homePageView.addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_homePageView.recommendButton addTarget:self action:@selector(recommendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homePageView];
}

- (void)createLocation {
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeGCJ02;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    //由于苹果系统的首次定位结果为粗定位，其可能无法满足需要高精度定位的场景。
    //所以，百度提供了 kCLLocationAccuracyBest 参数，设置该参数可以获取到精度在10m左右的定位结果，但是相应的需要付出比较长的时间（10s左右），越高的精度需要持续定位时间越长。
    //推荐使用kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右，超时时间设置在2s-3s左右即可。
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
//    _locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 20;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 20;
    //如果需要持续定位返回地址信息（需要联网)
    [self.locationManager setLocatingWithReGeocode:YES];
    //开启持续定位
    [self.locationManager startUpdatingLocation];
}


//测试泡泡内按钮点击事件
- (void)paopaoViewButtonAddTarget {
    __weak typeof(self) weakSelf = self;
    _paopaoView = [[MAPPaopaoView alloc] initWithFrame:CGRectMake(50, 50, 200, 140)];
    [self.view addSubview:_paopaoView];
    MAPDynamicStateViewController *danamicStateViewController = [[MAPDynamicStateViewController alloc] init];
    [_paopaoView.commentButton addTapBlock:^(UIButton * _Nonnull sender) {
        danamicStateViewController.typeMotiveString = @"1";
        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
    }];
    [_paopaoView.picturesButton addTapBlock:^(UIButton * _Nonnull sender) {
        danamicStateViewController.typeMotiveString = @"2";
        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
    }];
    [_paopaoView.voiceButton addTapBlock:^(UIButton * _Nonnull sender) {
        danamicStateViewController.typeMotiveString = @"3";
        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
    }];
    [_paopaoView.vedioButton addTapBlock:^(UIButton * _Nonnull sender) {
        danamicStateViewController.typeMotiveString = @"4";
        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
    }];
}

// 定位SDK中，位置变更的回调
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error) {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    }
    if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
        }
        //给所得到的位置，添加点
        [self addAnnotation:location];
    }
    if (!self.userLocation) {
        self.userLocation = [[BMKUserLocation alloc] init];
    }
    self.userLocation.location = location.location;
    [self.homePageView.mapView updateLocationData:_userLocation];
}

//给所得到的位置添加点
- (void) addAnnotation:(BMKLocation *) location {
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = location.location.coordinate;
    [self.homePageView.mapView addAnnotation:annotation];
    annotationMutableArray = [NSMutableArray array];
    [annotationMutableArray addObject:annotation];
    [self.homePageView.mapView showAnnotations:annotationMutableArray animated:YES];
}

//显示气泡
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAPAnnotationView *annotationView = (MAPAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            annotationView.canShowCallout = NO;
        }
        annotationView.image = [UIImage imageNamed:@"info.png"];
        return annotationView;
    }
    return nil;
}

//底部添加按钮点击事件
- (void)addButtonClicked:(UIButton *) button {

}

//推荐按钮点击事件
- (void)recommendButtonClicked:(UIButton *)button {
    
}

//视图即将出现，设置地图代理
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_homePageView.mapView viewWillAppear];
    _homePageView.mapView.delegate = self;
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}

//视图即将消失，设置地图代理为nil
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_homePageView.mapView viewWillDisappear];
    _homePageView.mapView.delegate = nil;
    [_locationManager stopUpdatingLocation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
