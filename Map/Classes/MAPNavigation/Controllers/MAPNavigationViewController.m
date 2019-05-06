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

- (void)searchData:(BMKSuggestionSearchOption *)option {
    //初始化BMKSuggestionSearch实例
    BMKSuggestionSearch *suggestionSearch = [[BMKSuggestionSearch alloc] init];
    //设置关键词检索的代理
    suggestionSearch.delegate = self;
    //初始化请求参数类BMKSuggestionSearchOption的实例
    BMKSuggestionSearchOption* suggestionOption = [[BMKSuggestionSearchOption alloc] init];
    //城市名
    suggestionOption.cityname = option.cityname;
    //检索关键字
    suggestionOption.keyword  = option.keyword;
    //是否只返回指定城市检索结果，默认为NO（海外区域暂不支持设置cityLimit）
    suggestionOption.cityLimit = option.cityLimit;
   
    BOOL flag = [suggestionSearch suggestionSearch:suggestionOption];
    if(flag) {
        NSLog(@"关键词检索成功");
    } else {
        NSLog(@"关键词检索失败");
    }
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
    // 节点数组
    NSMutableArray *nodesArray = [[NSMutableArray alloc] init];
    
    // 起点
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = 113.948222;
    startNode.pos.y = 22.549555;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];
    
    BNRoutePlanNode *viaNode = [[BNRoutePlanNode alloc] init];
    viaNode.pos = [[BNPosition alloc] init];
    viaNode.pos.x = 113.9422200000;
    viaNode.pos.y = 22.5529980000;
    viaNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:viaNode];
    
    BNRoutePlanNode *viaNode1 = [[BNRoutePlanNode alloc] init];
    viaNode1.pos = [[BNPosition alloc] init];
    viaNode1.pos.x = 113.9715960000;
    viaNode1.pos.y = 22.5601200000;
    viaNode1.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:viaNode1];
 
    // 终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = 113.940868;
    endNode.pos.y = 22.54647;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:endNode];
    
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
