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
}

//地点微调点击事件;
- (void) adjustmentLocationAction{
    NSLog(@"点击了");
    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate = self;
    //初始化请求参数类BMKCitySearchOption的实例
    BMKPOICitySearchOption *cityOption = [[BMKPOICitySearchOption alloc] init];
    //检索关键字，必选。举例：小吃
    cityOption.keyword = @"小吃";
    //区域名称(市或区的名字，如北京市，海淀区)，最长不超过25个字符，必选
    cityOption.city = @"北京市";
    //检索分类，可选，与keyword字段组合进行检索，多个分类以","分隔。举例：美食,烧烤,酒店
    cityOption.tags = @[@"美食",@"烧烤"];
    //区域数据返回限制，可选，为YES时，仅返回city对应区域内数据
    cityOption.isCityLimit = YES;
    //POI检索结果详细程度
    //cityOption.scope = BMK_POI_SCOPE_BASIC_INFORMATION;
    //检索过滤条件，scope字段为BMK_POI_SCOPE_DETAIL_INFORMATION时，filter字段才有效
    //cityOption.filter = filter;
    //分页页码，默认为0，0代表第一页，1代表第二页，以此类推
    cityOption.pageIndex = 0;
    //单次召回POI数量，默认为10条记录，最大返回20条
    cityOption.pageSize = 10;
    
    BOOL flag = [_poiSearch poiSearchInCity:cityOption];
    if(flag) {
        NSLog(@"POI城市内检索成功");
    } else {
        NSLog(@"POI城市内检索失败");
    }
}
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPOISearchResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    //BMKSearchErrorCode错误码，BMK_SEARCH_NO_ERROR：检索结果正常返回
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"检索结果返回成功：%@",poiResult.poiInfoList);
    }
    else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD) {
        NSLog(@"检索词有歧义");
    } else {
        NSLog(@"其他检索结果错误码相关处理");
    }
}

//添加自定义点
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
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


@end
