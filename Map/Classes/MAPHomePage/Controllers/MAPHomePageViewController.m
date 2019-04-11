//
//  MAPHomePageViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/1/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPHomePageViewController.h"
#import "MAPDynamicStateViewController.h"
#import "MAPAlertView.h"
#import <Masonry.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import "MAPHomePageView.h"
#import "MAPAnnotationView.h"
#import "MAPIssueView.h"
#import "MAPAddDynamicStateViewController.h"
#import "MAPNavigationViewController.h"
#import "MAPPaopaoView.h"
#import "MAPLoginManager.h"
#import "MAPAddPointManager.h"
#import "MAPGetPointManager.h"
#import "MAPAddAudioView.h"

@interface MAPHomePageViewController ()<UIGestureRecognizerDelegate, BMKMapViewDelegate, BMKLocationManagerDelegate> {
    NSMutableArray *annotationMutableArray;
    NSInteger addDynamicStateTypeTag;
    BOOL selected;
    BOOL addButtonSelected;
}
@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置
@property (nonatomic, strong) MAPHomePageView *homePageView;//主界面
@property (nonatomic, strong) MAPAddDynamicStateViewController *addDyanmicStateViewController;//添加动态controller

//测试泡泡点击事件
@property (nonatomic, strong) MAPPaopaoView *paopaoView;
@property (nonatomic, strong) MAPHomePageViewController *homePageViewController;

@end

@implementation MAPHomePageViewController

#pragma MAP -----------------------视图的出现与消失-------------------------
//视图即将出现，设置地图代理
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_homePageView.mapView viewWillAppear];
//    _homePageView.mapView.delegate = self;
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}
//视图即将消失，设置地图代理为nil
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_homePageView.mapView viewWillDisappear];
//    _homePageView.mapView.delegate = nil;
    [_locationManager stopUpdatingLocation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化地图
    [self createChileView];
    //初始化坐标
    [self createLocation];
    //添加泡泡点击事件
//    [self paopaoViewButtonAddTarget];
    //删除view
    [self clearAwaySomeViews];
}

#pragma MAP -------------------------初始化界面-------------------------
- (void)createChileView {
    self.view.backgroundColor = [UIColor whiteColor];
    _homePageView = [[MAPHomePageView alloc] initWithFrame:self.view.bounds];
    _homePageView.mapView.delegate = self;
    _homePageView.mapView.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
    [_homePageView.addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_homePageView.navigationButton addTarget:self action:@selector(navigationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homePageView];
    
//    //loginManager测试
//    MAPLoginManager *loginManager = [MAPLoginManager sharedManager];
//    [loginManager requestUserMessageWith:@2 Success:^(MAPGetUserMessageModel *messageModel) {
//        NSLog(@"+++%@+++%@", messageModel.status, [messageModel.data[0] username]);
//    } Failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
//    //addPointManager测试
//    MAPAddPointManager *addPointManager = [MAPAddPointManager sharedManager];
//    [addPointManager addPointWithName:@"香港测试点1" Latitude:22.28 Longitude:114.16 success:^(MAPAddPointModel *resultModel) {
//        NSLog(@"%@++++", resultModel.message);
//    } error:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
//    //添加评论测试
//    [self addCommentsWithPointID:6 Content:@"这里是香港测试点1"];
}

#pragma MAP -------------------------初始化位置-------------------------
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
//- (void)paopaoViewButtonAddTarget:(MAPPaopaoView *)paopaoView {
//    __weak typeof(self) weakSelf = self;
//    if (!paopaoView) {
//        paopaoView = [MAPPaopaoView new];
//    }
//    
//    MAPDynamicStateViewController *danamicStateViewController = [[MAPDynamicStateViewController alloc] init];
//    danamicStateViewController.dynamicStateView = [[MAPDynamicStateView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [paopaoView.commentButton addTapBlock:^(UIButton * _Nonnull sender) {
//        ///添加评论
////        [weakSelf addCommentsWithPointID:6 Content:@"这里是香港测试点1"];
//        ///获取评论
//        MAPAnnotationView *tempAnnotationView = (MAPAnnotationView *)sender.superview.superview;
//        int ID = [tempAnnotationView.annotation.title intValue];
//        MAPGetPointManager *manager = [MAPGetPointManager sharedManager];
//        [manager fetchPointCommentWithPointID:ID
//                                         type:0 succeed:^(MAPCommentModel *resultModel) {
//                                             NSLog(@"getComment:%@", resultModel.message);
//                                             danamicStateViewController.dynamicStateView.commentModel = resultModel;
//                                             [danamicStateViewController.dynamicStateView.dyanmicStateTableView reloadData];
//                                         } error:^(NSError *error) {
//                                             NSLog(@"%@", error);
//                                         }];
//        danamicStateViewController.typeMotiveString = @"1";
//        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
//    }];
//    [paopaoView.picturesButton addTapBlock:^(UIButton * _Nonnull sender) {
//        danamicStateViewController.typeMotiveString = @"2";
//        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
//
//    }];
//    [paopaoView.voiceButton addTapBlock:^(UIButton * _Nonnull sender) {
//        danamicStateViewController.typeMotiveString = @"3";
//        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
//    }];
//    [paopaoView.vedioButton addTapBlock:^(UIButton * _Nonnull sender) {
//        danamicStateViewController.typeMotiveString = @"4";
//        [weakSelf.navigationController pushViewController:danamicStateViewController animated:YES];
//    }];
//}

#pragma MAP -------------------------清除多余view-------------------------
- (void) clearAwaySomeViews {
    //添加清除主界面之外所有view的手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenAddDynamicStateView)];
    tapGestureRecognizer.delegate = self;
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [_homePageView addGestureRecognizer:tapGestureRecognizer];
}
//手势点击事件
- (void)HiddenAddDynamicStateView {
    //删除相册or拍摄view
    for(id tmpView in [_homePageView subviews]) {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIView class]]){
            UIView *view = (UIView *)tmpView;
            if(view.tag == 200 || view.tag == 201 || view.tag == 202 || view.tag == 203 || view.tag == 204) {  //判断是否满足自己要删除的子视图的条件,alertView.tag == 200  addSelectedView.tag == 201  issueView.tag == 202  addAudioView.tag == 203 recommendView.tag == 204
                [view removeFromSuperview];
            }
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view.superview isEqual:self.homePageView] || [touch.view.superview.superview.superview isEqual:self.homePageView]) {
        return NO;
    }
    return YES;
}


#pragma MAP ----------------------定位中位置变更的回调--------------------
- (BMKUserLocation *)userLocation {
    if (!_userLocation) {
        //初始化BMKUserLocation类的实例
        _userLocation = [[BMKUserLocation alloc] init];
    }
    return _userLocation;
}

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
    }
    
    self.userLocation.location = location.location;
    [self.homePageView.mapView updateLocationData:_userLocation];
    //获取定位坐标周围点
    self->_homePageView.mapView.centerCoordinate = self->_userLocation.location.coordinate;
    //获取定位坐标周围点
    [self getLocationAroundPoints];
}

#pragma MAP --------------------------添加点---------------------------
//- (void)addAnnotation:(BMKLocation *) location {
//    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
//    annotation.coordinate = location.location.coordinate;
//    annotation.title = @"";
//    [self.homePageView.mapView addAnnotation:annotation];
//    annotationMutableArray = [NSMutableArray array];
//    [annotationMutableArray addObject:annotation];
//    [self.homePageView.mapView showAnnotations:annotationMutableArray animated:YES];
//}

#pragma MAP -------------------------自定义样式点标记--------------------------
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        BMKAnnotationView *annotationView = (MAPAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
    //                BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc] initWithCustomView:_paopaoView];
    //                //定义paopaoView
    //                pView.frame = _paopaoView.frame;
    //                annotationView.paopaoView = pView;
    //                self.paopaoView = [[MAPPaopaoView alloc] initWithFrame:CGRectMake(0, 0, 195, 132.5)];
    //                self.paopaoView.center = CGPointMake(CGRectGetWidth(annotationView.bounds) / 2.f + annotationView.calloutOffset.x + 37, -CGRectGetHeight(self.paopaoView.bounds) / 2.f + annotationView.calloutOffset.y + 40);
    //                annotationView.paopaoView = _paopaoView;

//            [self paopaoViewButtonAddTarget:(MAPPaopaoView *)annotationView.paopaoView];
            annotationView.canShowCallout = NO;
        }
        annotationView.image = [UIImage imageNamed:@"info.png"];
        return annotationView;
//        if ([annotation isKindOfClass:[BMKPointAnnotation class]])
//        {
//            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//            BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//            if (annotationView == nil)
//            {
//                annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation
//                                                               reuseIdentifier:reuseIndetifier];
//            }
//
//            annotationView.image = [UIImage imageNamed:@"poi.png"];
//
//            annotationView.canShowCallout = YES;
//            MAPPaopaoView *paopaoView = [[MAPPaopaoView alloc] initWithFrame:CGRectMake(0, 0, 195, 132.5)];
//
//            BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc] initWithCustomView:paopaoView];
//            pView.backgroundColor = [UIColor lightGrayColor];
//            pView.frame = paopaoView.frame;
//            annotationView.paopaoView = pView;
//            return annotationView;
//        }
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"%@；；；；；；；；；", views);
}

//气泡的点击事件
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(MAPAnnotationView *)view {
    [view setSelected:!selected animated:YES];
    selected = !selected;
    view.selected = NO;
}

#pragma MAP -----------------------添加按钮点击事件------------------------
- (void)addButtonClicked:(UIButton *) button {
    MAPAlertView *alertView = [[MAPAlertView alloc] initWithFrame:self.view.frame];
    alertView.tag = 202;
    [_homePageView addSubview:alertView];
    
    alertView.btnAction = ^(NSInteger tag) {
        //tag=100是取消按钮，101是发布按钮
        if (tag == 100) {
            [alertView removeFromSuperview];
        } else {
            //创建发布界面
            [self creatIssueView];
        }
    };
}
//创建发布界面
- (void)creatIssueView {
    MAPIssueView *issueView = [[MAPIssueView alloc] init];
    issueView.tag = 200;
    [self->_homePageView addSubview:issueView];
    issueView.layer.masksToBounds = YES;
    issueView.layer.cornerRadius = 150;
    [issueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_homePageView.mas_centerX);
        make.centerY.mas_equalTo(self->_homePageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    _addDyanmicStateViewController = [[MAPAddDynamicStateViewController alloc] init];
    addDynamicStateTypeTag = 0;
    issueView.btnAction = ^(NSInteger tag) {
        if (tag == 101) {
            //添加评论
            self->_addDyanmicStateViewController.typeString = [NSString stringWithFormat:@"%ld", (long)tag];
            self->_addDyanmicStateViewController.Latitude = self->_userLocation.location.coordinate.latitude;
            self->_addDyanmicStateViewController.Longitud = self->_userLocation.location.coordinate.longitude;
            [self HiddenAddDynamicStateView];
            [self.navigationController pushViewController:self->_addDyanmicStateViewController animated:YES];
        } else if (tag == 102) {
            //添加图片
            self->addDynamicStateTypeTag = tag;
            [self addDynamicStateFromShootingOrAlbum];
        } else if (tag == 103) {
            //添加语音
            self->addDynamicStateTypeTag = tag;
            [self addAudioDynamicStateView];
        } else if (tag == 104) {
            //添加视频
            self->addDynamicStateTypeTag = tag;
            [self addDynamicStateFromShootingOrAlbum];
        }
    };
}
//从拍摄or相册添加图片or视频
- (void)addDynamicStateFromShootingOrAlbum {
    UIView *addSelectedView = [[UIView alloc] init];
    addSelectedView.tag = 201;
    [self->_homePageView addSubview:addSelectedView];
    [addSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.homePageView.mas_bottom);
        make.left.mas_equalTo(self.homePageView.mas_left);
        make.right.mas_equalTo(self.homePageView.mas_right);
        make.height.mas_equalTo(92);
    }];
    addSelectedView.backgroundColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f];
    
    //拍摄
    UIButton *shootingButton = [[UIButton alloc] init];
    [addSelectedView addSubview:shootingButton];
    [shootingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addSelectedView.mas_top);
        make.left.mas_equalTo(addSelectedView.mas_left);
        make.right.mas_equalTo(addSelectedView.mas_right);
        make.height.mas_equalTo(45);
    }];
    shootingButton.backgroundColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f];
    [shootingButton setTitle:[NSString stringWithFormat:@"拍摄"] forState:UIControlStateNormal];
    
    //中间白线
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [addSelectedView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shootingButton.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(2);
    }];
    
    //相册
    UIButton *albumButton = [[UIButton alloc] init];
    [addSelectedView addSubview:albumButton];
    [albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(addSelectedView.mas_bottom);
        make.left.mas_equalTo(addSelectedView.mas_left);
        make.right.mas_equalTo(addSelectedView.mas_right);
        make.height.mas_equalTo(45);
    }];
    albumButton.backgroundColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f];
    [albumButton setTitle:[NSString stringWithFormat:@"相册"] forState:UIControlStateNormal];
    [albumButton addTarget:self action:@selector(clickedAlbumButton:) forControlEvents:UIControlEventTouchUpInside];
}
//通过相册添加图片点击事件
- (void)clickedAlbumButton:(UIButton *) button {
    if (addDynamicStateTypeTag == 102) {
        self->_addDyanmicStateViewController.typeString = [NSString stringWithFormat:@"%ld", (long)addDynamicStateTypeTag];
    } else if (addDynamicStateTypeTag == 104) {
        self->_addDyanmicStateViewController.typeString = [NSString stringWithFormat:@"%ld", (long)addDynamicStateTypeTag];
    }
    self->_addDyanmicStateViewController.Latitude = self->_userLocation.location.coordinate.latitude;
    self->_addDyanmicStateViewController.Longitud = self->_userLocation.location.coordinate.longitude;
    [self HiddenAddDynamicStateView];
    [self.navigationController pushViewController:self->_addDyanmicStateViewController animated:YES];
}
//添加语音
- (void)addAudioDynamicStateView {
    for(id tmpView in [_homePageView subviews]) {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIView class]]){
            UIView *view = (UIView *)tmpView;
            if(view.tag == 201) {  //判断是否满足自己要删除的子视图的条件,alertView.tag == 200  addSelectedView.tag == 201  issueView.tag == 202  addAudioView.tag == 203
                [view removeFromSuperview];
            }
        }
    }
    
    MAPAddAudioView *addAudioView = [[MAPAddAudioView alloc] init];
    addAudioView.backgroundColor = [UIColor whiteColor];
    addAudioView.audioButtonAction = ^(UIButton *sender) {
        self->_addDyanmicStateViewController.typeString = [NSString stringWithFormat:@"%ld", (long)self->addDynamicStateTypeTag];
        self->_addDyanmicStateViewController.Latitude = self->_userLocation.location.coordinate.latitude;
        self->_addDyanmicStateViewController.Longitud = self->_userLocation.location.coordinate.longitude;
        [self HiddenAddDynamicStateView];
        [self.navigationController pushViewController:self->_addDyanmicStateViewController animated:YES];
    };
    addAudioView.tag = 203;
    [_homePageView addSubview:addAudioView];
    [addAudioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.homePageView);
        make.left.mas_equalTo(self.homePageView.mas_left).mas_equalTo(50);
        make.right.mas_equalTo(self.homePageView.mas_right).mas_equalTo(-50);
        make.height.mas_equalTo(addAudioView.mas_width).multipliedBy(1.2);
    }];

}
//button点击事件
- (void)ClikedButton:(UIButton *) button {
    self->_addDyanmicStateViewController.typeString = [NSString stringWithFormat:@"%ld", (long)addDynamicStateTypeTag];
    self->_addDyanmicStateViewController.Latitude = self->_userLocation.location.coordinate.latitude;
    self->_addDyanmicStateViewController.Longitud = self->_userLocation.location.coordinate.longitude;
    [self HiddenAddDynamicStateView];
    [self.navigationController pushViewController:self->_addDyanmicStateViewController animated:YES];
}

#pragma MAP -----------------------导航按钮点击事件-------------------------
- (void)navigationButtonClicked:(UIButton *)button {
    MAPNavigationViewController *navigationViewController = [[MAPNavigationViewController alloc] init];
    navigationViewController.Latitude = self->_userLocation.location.coordinate.latitude;
    navigationViewController.Longitud = self->_userLocation.location.coordinate.longitude;
    [self.navigationController pushViewController:navigationViewController animated:YES];
}

#pragma MAP -----------------------获取定位周围点-------------------------
- (void)getLocationAroundPoints {
    MAPGetPointManager *manager = [MAPGetPointManager sharedManager];
    [manager fetchPointWithLongitude:_userLocation.location.coordinate.longitude
                            Latitude:_userLocation.location.coordinate.latitude
                               Range:30000
                             succeed:^(MAPGetPointModel *pointModel) {
                                 for (int i = 0; i < pointModel.data.count; i++) {
                                     CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([pointModel.data[i] latitude], [pointModel.data[i] longitude]);
                                     BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
                                     annotation.coordinate = coordinate;
                                     annotation.title = [NSString stringWithFormat:@"%d", [pointModel.data[i] ID]];
                                     [self.homePageView.mapView addAnnotation:annotation];
                                     annotation.title = [NSString stringWithFormat:@"%d", [pointModel.data[i] ID] ];
                                     self->annotationMutableArray = [NSMutableArray array];
                                     [self->annotationMutableArray addObject:annotation];
                                     [self.homePageView.mapView showAnnotations:self->annotationMutableArray animated:YES];
//                                     // 移动到中心点
//                                     self->_homePageView.mapView.centerCoordinate = self->_userLocation.location.coordinate;
                                 }
                             }
                               error:^(NSError *error) {
                                   NSLog(@"+++++getLocationAroundPointsError:%@", error);
                               }];
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

@end
