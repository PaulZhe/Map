//
//  MAPNavigationViewController.m
//  Map
//
//  Created by _祀梦 on 2019/4/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPNavigationViewController.h"
#import <Masonry.h>
#import "BNaviService.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface MAPNavigationViewController () <BNNaviRoutePlanDelegate, BNNaviUIManagerDelegate, BMKSuggestionSearchDelegate>
@property (nonatomic, strong) NSMutableArray *annotationMutableArray;
@property (nonatomic, assign) long node;
@end

@implementation MAPNavigationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(BackToHomePage:)];
    backButtonItem.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    //设置地图的代理
    [_navigationView.mapView viewWillAppear];
    _navigationView.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //设置地图的代理
    [_navigationView.mapView viewWillAppear];
    _navigationView.mapView.delegate = nil;
}

//显示定位点
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc] init];
    [annotation setCoordinate:CLLocationCoordinate2DMake(_Latitude, _Longitud)];
    annotation.title = @"";
    [_navigationView.mapView addAnnotation:annotation];
    _annotationMutableArray = [NSMutableArray array];
    [_annotationMutableArray addObject:annotation];
    [_navigationView.mapView showAnnotations:_annotationMutableArray animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _navigationView = [[MAPNavigationView alloc] init];
    [self.view addSubview:_navigationView];
    [_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [_navigationView.checkButton addTarget:self action:@selector(ClickedCheckButton:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"sendCoordinate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendFlag:) name:@"sendFlag" object:nil];
    
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

- (void)BackToHomePage:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ClickedCheckButton:(UIButton *)button {
    [self startNavi];
}

- (void)tongzhi:(NSNotification *) notification {
    _dataMutableArray = [[NSMutableArray alloc] initWithArray:_navigationView.locationCoordinate2DMutableArray];
}

- (void)sendFlag:(NSNotification *) notificaton {
    NSLog(@"flag = %@", notificaton.object);
    _node = [notificaton.object longValue] + 1;
}
/**
 *返回suggestion搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:( BMKSuggestionSearchResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else {
        NSLog(@"检索失败");
    }
}

- (void)startNavi {
    NSLog(@"controller = %@", _dataMutableArray);
    
    // 节点数组
    NSMutableArray *nodesArray = [[NSMutableArray alloc] init];
    
    // 起点
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    
    BNRoutePlanNode *viaNode = [[BNRoutePlanNode alloc] init];
    viaNode.pos = [[BNPosition alloc] init];
    viaNode.pos.eType = BNCoordinate_BaiduMapSDK;
    
    BNRoutePlanNode *viaNode1 = [[BNRoutePlanNode alloc] init];
    viaNode1.pos = [[BNPosition alloc] init];
    viaNode1.pos.eType = BNCoordinate_BaiduMapSDK;
    
    BNRoutePlanNode *viaNode2 = [[BNRoutePlanNode alloc] init];
    viaNode2.pos = [[BNPosition alloc] init];
    viaNode2.pos.eType = BNCoordinate_BaiduMapSDK;
    
    // 终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    
    if (_node == 2) {
        startNode.pos.x = [_dataMutableArray[0][1] doubleValue];
        startNode.pos.y = [_dataMutableArray[0][0] doubleValue];
        [nodesArray addObject:startNode];
        
        endNode.pos.x = [_dataMutableArray[1][1] doubleValue];
        endNode.pos.y = [_dataMutableArray[1][0] doubleValue];
        [nodesArray addObject:endNode];
    } else if (_node == 3) {
        startNode.pos.x = [_dataMutableArray[0][1] doubleValue];
        startNode.pos.y = [_dataMutableArray[0][0] doubleValue];
        [nodesArray addObject:startNode];
        
        viaNode.pos.x = [_dataMutableArray[1][1] doubleValue];
        viaNode.pos.y = [_dataMutableArray[1][0] doubleValue];
        [nodesArray addObject:viaNode];
        
        endNode.pos.x = [_dataMutableArray[2][1] doubleValue];
        endNode.pos.y = [_dataMutableArray[2][0] doubleValue];
        [nodesArray addObject:endNode];
        
    } else if (_node == 4) {
        startNode.pos.x = [_dataMutableArray[0][1] doubleValue];
        startNode.pos.y = [_dataMutableArray[0][0] doubleValue];
        [nodesArray addObject:startNode];
        
        viaNode.pos.x = [_dataMutableArray[1][1] doubleValue];
        viaNode.pos.y = [_dataMutableArray[1][0] doubleValue];
        [nodesArray addObject:viaNode];
        
        viaNode1.pos.x = [_dataMutableArray[2][1] doubleValue];
        viaNode1.pos.y = [_dataMutableArray[2][0] doubleValue];
        [nodesArray addObject:viaNode1];
        
        endNode.pos.x = [_dataMutableArray[3][1] doubleValue];
        endNode.pos.y = [_dataMutableArray[3][0] doubleValue];
        [nodesArray addObject:endNode];
    } else {
        startNode.pos.x = [_dataMutableArray[0][1] doubleValue];
        startNode.pos.y = [_dataMutableArray[0][0] doubleValue];
        [nodesArray addObject:startNode];
        
        viaNode.pos.x = [_dataMutableArray[1][1] doubleValue];
        viaNode.pos.y = [_dataMutableArray[1][0] doubleValue];
        [nodesArray addObject:viaNode];
        
        viaNode1.pos.x = [_dataMutableArray[2][1] doubleValue];
        viaNode1.pos.y = [_dataMutableArray[2][0] doubleValue];
        [nodesArray addObject:viaNode1];
        
        viaNode2.pos.x = [_dataMutableArray[3][1] doubleValue];
        viaNode2.pos.y = [_dataMutableArray[3][0] doubleValue];
        [nodesArray addObject:viaNode2];
        
        endNode.pos.x = [_dataMutableArray[4][1] doubleValue];
        endNode.pos.y = [_dataMutableArray[4][0] doubleValue];
        [nodesArray addObject:endNode];
    }
    
    NSLog(@"nodesArray = %@", nodesArray);
    //关闭openURL,不想跳转百度地图可以设为YES
    [BNaviService_RoutePlan setDisableOpenUrl:YES];
    [BNaviService_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
}

//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo {
    NSLog(@"算路成功");
    
    //路径规划成功，开始导航
    [BNaviService_UI showPage:BNaviUI_NormalNavi delegate:self extParams:nil];
}




@end
