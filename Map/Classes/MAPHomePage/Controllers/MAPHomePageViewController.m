//
//  MAPHomePageViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/1/13.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPHomePageViewController.h"
#import "MAPAlertView.h"
#import <Masonry.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import "MAPHomePageView.h"
#import "MAPIssueView.h"
//添加动态的四个controller
#import "MAPAddCommentsViewController.h"
#import "MAPAddPicturesViewController.h"
#import "MAPAddVedioViewController.h"
#import "MAPAddAudioViewController.h"
//展示动态的四个controller
#import "MAPShowReplyViewController.h"
#import "MAPShowPicturesViewController.h"
#import "MAPShowVedioViewController.h"
#import "MAPShowAudioViewController.h"
#import "MAPNavigationViewController.h"
#import "MAPPaopaoView.h"
#import "MAPLoginManager.h"
#import "MAPAddPointManager.h"
#import "MAPGetPointManager.h"
#import "MAPAddAudioView.h"
#import "MAPAudioRecordUtils.h"

@interface MAPHomePageViewController ()<UIGestureRecognizerDelegate, BMKMapViewDelegate, BMKLocationManagerDelegate> {
    NSMutableArray *annotationMutableArray;
//    NSInteger addDynamicStateTypeTag;
    BOOL selected;
    BOOL addButtonSelected;
}
@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置
@property (nonatomic, strong) MAPHomePageView *homePageView;//主界面

//记录主界面点击发布按钮跳转过去时是否有发布点
@property (nonatomic, assign) bool addViewControllerIsSelected;
//记录各个controller的各个属性
@property (nonatomic, assign) int addViewControllerID;
@property (nonatomic, copy) NSString *addViewControllerPointName;

@property (nonatomic, strong) MAPAudioRecordUtils *audioRecordUtils;


//获取点ID用的annotationView
@property (nonatomic, strong) BMKAnnotationView *tempAnnotationView;
@property (nonatomic, assign) NSInteger addDynamicStateTypeTag;
@end

@implementation MAPHomePageViewController

#pragma MAP -----------------------视图的出现与消失-------------------------
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

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化地图
    [self createChileView];
    //初始化坐标
    [self createLocation];
    //addPointManager测试
//    MAPAddPointManager *addPointManager = [MAPAddPointManager sharedManager];
//    [addPointManager addPointWithName:@"西安邮电大学" Latitude:34.165 Longitude:108.95 success:^(MAPAddPointModel *resultModel) {
//        NSLog(@"%@++++", resultModel.message);
//        //更新添加点
//
//    } error:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    //删除view
    [self clearAwaySomeViews];
}

#pragma MAP -------------------------初始化界面-------------------------
- (void)createChileView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.homePageView = [[MAPHomePageView alloc] initWithFrame:self.view.bounds];
    self.homePageView.mapView.delegate = self;
    self.homePageView.mapView.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
    
    __weak typeof(self) weakSelf = self;
    //添加按钮点击事件
    self.homePageView.addButtonAction = ^(UIButton * _Nonnull sender) {
        if (weakSelf.addViewControllerIsSelected == YES) {
            //创建发布界面
            UIView *transparentView = [[UIView alloc] initWithFrame:weakSelf.view.frame];
            transparentView.backgroundColor= [UIColor colorWithWhite:0 alpha:0.25];
            transparentView.tag = 205;
            [weakSelf.homePageView addSubview:transparentView];
            [weakSelf creatIssueView:transparentView];
        } else {
            MAPAlertView *alertView = [[MAPAlertView alloc] initWithFrame:weakSelf.view.frame];
            alertView.tag = 202;
            __weak MAPAlertView *weakAlertView = alertView;
            [weakSelf.homePageView addSubview:alertView];
            alertView.btnAction = ^(NSInteger tag) {
                //tag=100是取消按钮，101是发布按钮
                if (tag == 100) {
                    [weakAlertView removeFromSuperview];
                } else {
                    //创建发布界面
                    [weakSelf creatIssueView:weakSelf.homePageView];
                }
            };
        }
    };
    //导航按钮点击事件
    self.homePageView.navigationAction = ^(UIButton * _Nonnull sender) {
        MAPNavigationViewController *navigationViewController = [[MAPNavigationViewController alloc] init];
        navigationViewController.Latitude = weakSelf.userLocation.location.coordinate.latitude;
        navigationViewController.Longitud = weakSelf.userLocation.location.coordinate.longitude;
        [weakSelf.navigationController pushViewController:navigationViewController animated:YES];
    };
    [self.view addSubview:_homePageView];
    
        //loginManager测试
//        MAPLoginManager *loginManager = [MAPLoginManager sharedManager];
//        [loginManager requestUserMessageWith:@2 Success:^(MAPGetUserMessageModel *messageModel) {
//            NSLog(@"+++%@+++%@", messageModel.status, [messageModel.data[0] username]);
//        } Failure:^(NSError *error) {
//            NSLog(@"%@", error);
//        }];
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

#pragma MAP -------------------------清除多余view-------------------------
- (void)clearAwaySomeViews {
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
            if(view.tag == 200 || view.tag == 201 || view.tag == 202 || view.tag == 203 || view.tag == 204 || view.tag == 205) {  //判断是否满足自己要删除的子视图的条件,alertView.tag == 200  addSelectedView.tag == 201  issueView.tag == 202  addAudioView.tag == 203 recommendView.tag == 204 阴影view.tag == 205
                [view removeFromSuperview];
            }
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[MAPIssueView class]]) {
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
    NSString *placeTitle = [NSString stringWithFormat:@"%@%@", location.rgcData.district, location.rgcData.street];
    self.userLocation.title = placeTitle;
    self.addViewControllerPointName = placeTitle;;
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
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"info.png"];
        annotationView.canShowCallout = YES;
        annotationView.tag = 1000;
        annotationView.hidePaopaoWhenSingleTapOnMap = YES;
        annotationView.hidePaopaoWhenSelectOthers = YES;
        [annotationView setCalloutOffset:CGPointMake(26, 38)];
        
        self.paopaoView = [[MAPPaopaoView alloc] initWithFrame:CGRectMake(0, 0, 165, 145)];

        NSRange pos = [annotation.subtitle rangeOfString:@" pointName "];
        NSRange pos0 = [annotation.subtitle rangeOfString:@" mesCount "];
        NSRange pos1 = [annotation.subtitle rangeOfString:@" phoCount "];
        NSRange pos2 = [annotation.subtitle rangeOfString:@" audCount "];
        NSRange pos3 = [annotation.subtitle rangeOfString:@" vidCount "];

        self.paopaoView.pointName = [annotation.subtitle substringFromIndex:pos.location + 11];
        self.paopaoView.mesCount = [[annotation.subtitle substringWithRange:NSMakeRange(pos0.location + 10, pos1.location - pos0.location - 10)] intValue];
        self.paopaoView.phoCount = [[annotation.subtitle substringWithRange:NSMakeRange(pos1.location + 10, pos2.location - pos1.location - 10)] intValue];
        self.paopaoView.audCount = [[annotation.subtitle substringWithRange:NSMakeRange(pos2.location + 10, pos3.location - pos2.location - 10)] intValue];
        self.paopaoView.vidCount = [[annotation.subtitle substringFromIndex:pos3.location + 10] intValue];
        [self.paopaoView initPaopaoView];
        
        //给paopaoView中button添加 点击事件
        __weak typeof(self) weakSelf = self;
        [weakSelf paopaoViewButtonAddTarget:_paopaoView];
        
        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc] initWithCustomView:self->_paopaoView];
        pView.backgroundColor = [UIColor clearColor];
        pView.frame = self->_paopaoView.frame;
        annotationView.paopaoView = pView;
        
        return annotationView;
    }
    return nil;
}

//气泡的点击事件
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    self.tempAnnotationView = view;

    [self.homePageView.addButton setTitle:@"发  布" forState:UIControlStateNormal];
    [self.homePageView.addButton setTitle:@"发  布" forState:UIControlStateHighlighted];
    [self.homePageView.addButton setImage:nil forState:UIControlStateNormal];
    [self.homePageView.addButton setImage:nil forState:UIControlStateHighlighted];

    self.addViewControllerIsSelected = YES;
    
    //传递点击点ID和name
    self.addViewControllerID = [view.annotation.title intValue];

    NSRange pos = [view.annotation.subtitle rangeOfString:@" pointName "];
    self.addViewControllerPointName = [view.annotation.subtitle substringFromIndex:pos.location + 11];
}
/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
}

//当取消选中一个annotation views时，调用此接口
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {
    [self.homePageView.addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.homePageView.addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
    [self.homePageView.addButton setTitle:nil forState:UIControlStateNormal];
    [self.homePageView.addButton setTitle:nil forState:UIControlStateHighlighted];

    self.addViewControllerIsSelected = NO;

    self.addViewControllerPointName = _userLocation.title;
}

//- (void)comment {
//    MAPShowReplyViewController *showReplyViewController = [[MAPShowReplyViewController alloc] init];
//    MAPGetPointManager *manager = [MAPGetPointManager sharedManager];
//    [manager fetchPointCommentWithPointID:[self.tempAnnotationView.annotation.title intValue]
//                                     type:0 succeed:^(MAPCommentModel *resultModel) {
//                                         NSLog(@"getComment:%@", resultModel.message);
//                                         showReplyViewController.dynamicStateView.commentModel = resultModel;
//                                         [showReplyViewController.dynamicStateView.dyanmicStateTableView reloadData];
//                                     } error:^(NSError *error) {
//                                         NSLog(@"%@", error);
//                                     }];
//    [self.navigationController pushViewController:showReplyViewController animated:YES];
//}
//
//- (void)picture {
//    MAPShowPicturesViewController *showPicturesViewController = [[MAPShowPicturesViewController alloc] init];
//    [self.navigationController pushViewController:showPicturesViewController animated:YES];
//
//}
//
//- (void)audio {
//    MAPShowAudioViewController *showAudioViewController = [[MAPShowAudioViewController alloc] init];
//    MAPGetPointManager *manager = [MAPGetPointManager sharedManager];
//    [manager fetchPointCommentWithPointID:[self.tempAnnotationView.annotation.title intValue] type:2 succeed:^(MAPCommentModel *resultModel) {
//        NSLog(@"getComment:%@", resultModel.message);
//        showAudioViewController.dynamicStateView.commentModel = resultModel;
//        [showAudioViewController.dynamicStateView.dyanmicStateTableView reloadData];
//    } error:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    [self.navigationController pushViewController:showAudioViewController animated:YES];
//}
//
//- (void)vedio {
//    MAPShowVedioViewController *showVedioViewController = [[MAPShowVedioViewController alloc] init];
//    [self.navigationController pushViewController:showVedioViewController animated:YES];
//}

//泡泡内按钮点击事件
- (void)paopaoViewButtonAddTarget:(MAPPaopaoView *)paopaoView {
    __weak typeof(self) weakSelf = self;

    
    
    
    
//    [paopaoView.commentButton addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
//    [paopaoView.picturesButton addTarget:self action:@selector(picture) forControlEvents:UIControlEventTouchUpInside];
//    [paopaoView.voiceButton addTarget:self action:@selector(audio) forControlEvents:UIControlEventTouchUpInside];
//    [paopaoView.vedioButton addTarget:self action:@selector(vedio) forControlEvents:UIControlEventTouchUpInside];
//    showReplyViewController.callBlock = ^{
//        self.paopaoView = nil;
//    };
    paopaoView.commentButton.paopaoButtonAction = ^(UIButton * _Nonnull sender) {
        MAPShowReplyViewController *showReplyViewController = [[MAPShowReplyViewController alloc] init];
        //        ///添加评论
        //                [weakSelf addCommentsWithPointID:6 Content:@"这里是香港测试点1"];
        ///获取评论
        //                BMKAnnotationView *tempAnnotationView = (BMKAnnotationView *)sender.superview.superview;
        MAPGetPointManager *manager = [MAPGetPointManager sharedManager];
        [manager fetchPointCommentWithPointID:[weakSelf.tempAnnotationView.annotation.title intValue]
                                         type:0 succeed:^(MAPCommentModel *resultModel) {
                                             NSLog(@"getComment:%@", resultModel.message);
                                             showReplyViewController.dynamicStateView.commentModel = resultModel;
                                             [showReplyViewController.dynamicStateView.dyanmicStateTableView reloadData];
                                         } error:^(NSError *error) {
                                             NSLog(@"%@", error);
                                         }];
        [weakSelf.navigationController pushViewController:showReplyViewController animated:YES];
    };

    paopaoView.picturesButton.paopaoButtonAction = ^(UIButton * _Nonnull sender) {
        MAPShowPicturesViewController *showPicturesViewController = [[MAPShowPicturesViewController alloc] init];
        [weakSelf.navigationController pushViewController:showPicturesViewController animated:YES];
    };

    paopaoView.voiceButton.paopaoButtonAction = ^(UIButton * _Nonnull sender) {
        MAPShowAudioViewController *showAudioViewController = [[MAPShowAudioViewController alloc] init];
        MAPGetPointManager *manager = [MAPGetPointManager sharedManager];
        [manager fetchPointCommentWithPointID:[weakSelf.tempAnnotationView.annotation.title intValue] type:2 succeed:^(MAPCommentModel *resultModel) {
            NSLog(@"getComment:%@", resultModel.message);
            showAudioViewController.dynamicStateView.commentModel = resultModel;
            [showAudioViewController.dynamicStateView.dyanmicStateTableView reloadData];
        } error:^(NSError *error) {
            NSLog(@"%@", error);
        }];
        [weakSelf.navigationController pushViewController:showAudioViewController animated:YES];
    };

    paopaoView.vedioButton.paopaoButtonAction = ^(UIButton * _Nonnull sender) {
        MAPShowVedioViewController *showVedioViewController = [[MAPShowVedioViewController alloc] init];
        [weakSelf.navigationController pushViewController:showVedioViewController animated:YES];
    };
}

#pragma MAP -----------------------添加按钮点击事件------------------------
//创建发布界面
- (void)creatIssueView:(id)superView {
    MAPIssueView *issueView = [[MAPIssueView alloc] init];
    issueView.tag = 200;
    [superView addSubview:issueView];
    issueView.layer.masksToBounds = YES;
    issueView.layer.cornerRadius = 150;
    [issueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_homePageView.mas_centerX);
        make.centerY.mas_equalTo(self->_homePageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    self.addDynamicStateTypeTag = 0;
    __weak MAPHomePageViewController *weakSelf = self;
    issueView.btnAction = ^(NSInteger tag) {
        if (tag == 101) {
            //添加评论
            MAPAddCommentsViewController *addCommentViewController = [[MAPAddCommentsViewController alloc] init];
            //传值
            addCommentViewController.pointName = weakSelf.addViewControllerPointName;
            addCommentViewController.ID = weakSelf.addViewControllerID;
            addCommentViewController.Latitude = weakSelf.userLocation.location.coordinate.latitude;
            addCommentViewController.Longitud = weakSelf.userLocation.location.coordinate.longitude;
            addCommentViewController.isSelected = weakSelf.addViewControllerIsSelected;
            [weakSelf.navigationController pushViewController:addCommentViewController animated:YES];
            [weakSelf HiddenAddDynamicStateView];
        } else if (tag == 102) {
            //添加图片
            weakSelf.addDynamicStateTypeTag = tag;
            [weakSelf addDynamicStateFromShootingOrAlbum];
        } else if (tag == 103) {
            //添加语音
            weakSelf.addDynamicStateTypeTag = tag;
            [weakSelf addAudioDynamicStateView];
        } else if (tag == 104) {
            //添加视频
            weakSelf.addDynamicStateTypeTag = tag;
            [weakSelf addDynamicStateFromShootingOrAlbum];
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
- (void)clickedAlbumButton:(UIButton *)button {
    if (self.addDynamicStateTypeTag == 102) {
        MAPAddPicturesViewController *addPictureViewController = [[MAPAddPicturesViewController alloc] init];
        addPictureViewController.pointName = _addViewControllerPointName;
        addPictureViewController.ID = _addViewControllerID;
        addPictureViewController.Latitude = self.userLocation.location.coordinate.latitude;
        addPictureViewController.Longitud = self.userLocation.location.coordinate.longitude;
        [self.navigationController pushViewController:addPictureViewController animated:YES];
    } else if (self.addDynamicStateTypeTag == 104) {
        MAPAddVedioViewController *addVedioController = [[MAPAddVedioViewController alloc] init];
        addVedioController.pointName = _addViewControllerPointName;
        addVedioController.ID = _addViewControllerID;
        addVedioController.Latitude = self.userLocation.location.coordinate.latitude;
        addVedioController.Longitud = self.userLocation.location.coordinate.longitude;
        [self.navigationController pushViewController:addVedioController animated:YES];
    }
    [self HiddenAddDynamicStateView];
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
    
    //录音功能
    __weak MAPAddAudioView *weakAddAudioView = addAudioView;
    addAudioView.audioTouchDownAction = ^(UIButton *sender) {
        if (!self->_audioRecordUtils) {
            self.audioRecordUtils = [[MAPAudioRecordUtils alloc] init];
        }
        [self->_audioRecordUtils startClick];
        [weakAddAudioView startRecord];
    };
    
    MAPAddAudioViewController *addAudioViewController = [[MAPAddAudioViewController alloc] init];

    //添加跳转功能的点击事件
    addAudioView.audioButtonAction = ^(UIButton *sender) {
        //结束录音
        [self->_audioRecordUtils endClick];
        [weakAddAudioView endRecord];

        if (self->_audioRecordUtils.jumpFlag) {
            addAudioViewController.pointName = self->_addViewControllerPointName;
            addAudioViewController.ID = self->_addViewControllerID;
            addAudioViewController.Latitude = self->_userLocation.location.coordinate.latitude;
            addAudioViewController.Longitud = self->_userLocation.location.coordinate.longitude;
            addAudioViewController.addDynamicStateView.mp3Path = self->_audioRecordUtils.mp3Path;
            addAudioViewController.addDynamicStateView.issueAudioView.seconds = weakAddAudioView.seconds;
            addAudioViewController.addDynamicStateView.issueAudioView.minutes = weakAddAudioView.minutes;

            [self HiddenAddDynamicStateView];
            [self.navigationController pushViewController:addAudioViewController animated:YES];
        }
        [weakAddAudioView reset];
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
                                     annotation.subtitle = [NSString stringWithFormat:@" mesCount %ld phoCount %ld audCount %ld vidCount %ld pointName %@", [pointModel.data[i] mesCount], [pointModel.data[i] phoCount], [pointModel.data[i] audCount], [pointModel.data[i] vidCount], [pointModel.data[i] pointName]];
                                     [self.homePageView.mapView addAnnotation:annotation];
//                                     annotation.title = [NSString stringWithFormat:@"%d", [pointModel.data[i] ID] ];
                                     self->annotationMutableArray = [NSMutableArray array];
                                     [self->annotationMutableArray addObject:annotation];
                                     [self.homePageView.mapView showAnnotations:self->annotationMutableArray animated:YES];
                                     // 移动到中心点
                                     self->_homePageView.mapView.centerCoordinate = self->_userLocation.location.coordinate;
                                 }
                             }
                               error:^(NSError *error) {
                                   NSLog(@"+++++getLocationAroundPointsError:%@", error);
//                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
//                                   NSLog(@"+++++getLocationAroundPointsError:%@", dict);
                               }];
}

@end
