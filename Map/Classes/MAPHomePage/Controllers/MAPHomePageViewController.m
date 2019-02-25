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
#import "MAPRecommendView.h"
#import "MAPRecommendViewController.h"
#import "MAPPaopaoView.h"
#import "MAPLoginManager.h"
#import "MAPAddPointManager.h"

@interface MAPHomePageViewController ()<UIGestureRecognizerDelegate, BMKMapViewDelegate, BMKLocationManagerDelegate> {
    NSMutableArray *annotationMutableArray;
    NSInteger addDynamicStateTypeTag;
    BOOL selected;
    BOOL addButtonSelected;
}
@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置
//@property (nonatomic, strong) BMKPointAnnotation *annotation;//标记点
@property (nonatomic, strong) MAPHomePageView *homePageView;//主界面
@property (nonatomic, strong) MAPAnnotationView *annotationView;//气泡界面
@property (nonatomic, strong) MAPAddDynamicStateViewController *addDyanmicStateViewController;//添加动态controller

//测试泡泡点击事件
@property (nonatomic, strong) MAPPaopaoView *paopaoView;
@property (nonatomic, strong) MAPHomePageViewController *homePageViewController;

@property (nonatomic, strong) UIView *addAudioView;

@end

@implementation MAPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化地图
    [self createChileView];
    //初始化坐标
    [self createLocation];
    
    //添加泡泡点击事件
    [self paopaoViewButtonAddTarget];
    
    //删除view
    [self clearAwaySomeViews];
}

#pragma MAP -------------------------初始化界面-------------------------
- (void)createChileView {
    self.view.backgroundColor = [UIColor whiteColor];
    _homePageView = [[MAPHomePageView alloc] initWithFrame:self.view.bounds];
    [_homePageView.addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_homePageView.recommendButton addTarget:self action:@selector(recommendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homePageView];
    
    _addAudioView = [[UIView alloc] init];
    
//    //loginManager测试
//    MAPLoginManager *loginManager = [MAPLoginManager sharedManager];
//    [loginManager requestUserMessageWith:@2 Success:^(MAPGetUserMessageModel *messageModel) {
//        NSLog(@"+++%@+++%@", messageModel.status, [messageModel.data[0] username]);
//    } Failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    //addPointManager测试
    MAPAddPointManager *addPointManager = [MAPAddPointManager sharedManager];
    [addPointManager addPointWithName:@"香港测试点1" Latitude:22.28 Longitude:114.16 success:^(MAPAddPointModel *resultModel) {
        NSLog(@"%@++++", resultModel.message);
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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

#pragma MAP --------------------------添加点---------------------------
- (void)addAnnotation:(BMKLocation *) location {
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = location.location.coordinate;
    annotation.title = @"";
    [self.homePageView.mapView addAnnotation:annotation];
    annotationMutableArray = [NSMutableArray array];
    [annotationMutableArray addObject:annotation];
    [self.homePageView.mapView showAnnotations:annotationMutableArray animated:YES];
}

#pragma MAP -------------------------自定义气泡--------------------------
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        _annotationView = (MAPAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (_annotationView == nil)
        {
            _annotationView = [[MAPAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            _annotationView.canShowCallout = NO;
        }
        _annotationView.image = [UIImage imageNamed:@"info.png"];
        return _annotationView;
    }
    return nil;
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
- (void) addDynamicStateFromShootingOrAlbum {
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
- (void) clickedAlbumButton:(UIButton *) button {
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
- (void) addAudioDynamicStateView {
    for(id tmpView in [_homePageView subviews]) {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIView class]]){
            UIView *view = (UIView *)tmpView;
            if(view.tag == 201) {  //判断是否满足自己要删除的子视图的条件,alertView.tag == 200  addSelectedView.tag == 201  issueView.tag == 202  addAudioView.tag == 203
                [view removeFromSuperview];
            }
        }
    }
    
    _addAudioView.backgroundColor = [UIColor whiteColor];
    _addAudioView.tag = 203;
    [_homePageView addSubview:_addAudioView];
    [_addAudioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.homePageView);
        make.left.mas_equalTo(self.homePageView.mas_left).mas_equalTo(50);
        make.right.mas_equalTo(self.homePageView.mas_right).mas_equalTo(-50);
        make.height.mas_equalTo(self.addAudioView.mas_width).multipliedBy(1.2);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"长按录制语音";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:22];
    [_addAudioView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_addAudioView.mas_centerX);
        make.top.mas_equalTo(self->_addAudioView.mas_top).mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"00:12";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:20];
    [_addAudioView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_addAudioView.mas_centerX);
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UIButton *audioButton = [[UIButton alloc] init];
    audioButton.tag = 102;
    [_addAudioView addSubview:audioButton];
    [audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_addAudioView.mas_centerX);
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    [audioButton setImage:[UIImage imageNamed:@"souRed"] forState:UIControlStateNormal];
    [audioButton addTarget:self action:@selector(ClikedButton:) forControlEvents:UIControlEventTouchUpInside];
}
//button点击事件
- (void)ClikedButton:(UIButton *) button {
    self->_addDyanmicStateViewController.typeString = [NSString stringWithFormat:@"%ld", (long)addDynamicStateTypeTag];
    self->_addDyanmicStateViewController.Latitude = self->_userLocation.location.coordinate.latitude;
    self->_addDyanmicStateViewController.Longitud = self->_userLocation.location.coordinate.longitude;
    [self HiddenAddDynamicStateView];
    [self.navigationController pushViewController:self->_addDyanmicStateViewController animated:YES];
}

#pragma MAP -----------------------推荐按钮点击事件-------------------------
- (void)recommendButtonClicked:(UIButton *)button {
    MAPRecommendView *recommendView = [[MAPRecommendView alloc] init];
    recommendView.tag = 204;
    [_homePageView addSubview:recommendView];
    [recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_homePageView.mas_top).mas_offset(0);
        make.left.mas_equalTo(self->_homePageView.mas_left).mas_offset(0);
        make.right.mas_equalTo(self->_homePageView.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(self->_homePageView.mas_bottom).mas_offset(0);
    }];
    
    MAPRecommendViewController *recommendViewController = [[MAPRecommendViewController alloc] init];
    recommendView.btnAction = ^(NSInteger tag) {
        if (tag == 101) {
            [self.navigationController pushViewController:recommendViewController animated:YES];
        } else if (tag == 102) {
            [self.navigationController pushViewController:recommendViewController animated:YES];
        } else if (tag == 103) {
            [self.navigationController pushViewController:recommendViewController animated:YES];
        } else if (tag == 104) {
            for(id tmpView in [self->_homePageView subviews]) {
                //找到要删除的子视图的对象
                if([tmpView isKindOfClass:[UIView class]]){
                    UIView *view = (UIView *)tmpView;
                    if(view.tag == 204) {  //判断是否满足自己要删除的子视图的条件,alertView.tag == 200  addSelectedView.tag == 201  issueView.tag == 202  addAudioView.tag == 203 recommendView.tag == 204
                        [view removeFromSuperview];
                    }
                }
            }
        }
    };
    
}

#pragma MAP -----------------------试图的出现与消失-------------------------
//视图即将出现，设置地图代理
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_homePageView.mapView viewWillAppear];
    _homePageView.mapView.delegate = self;
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}
//视图即将消失，设置地图代理为nil
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_homePageView.mapView viewWillDisappear];
    _homePageView.mapView.delegate = nil;
    [_locationManager stopUpdatingLocation];
}

@end
