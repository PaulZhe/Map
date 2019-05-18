//
//  MAPNavigationView.m
//  Map
//
//  Created by _祀梦 on 2019/4/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPNavigationView.h"
#import <Masonry.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface MAPNavigationView () <BMKSuggestionSearchDelegate>
@property (nonatomic, strong) NSMutableArray *locationMutableArray;
@property (nonatomic, strong) NSMutableArray *locationDataMutableArray;
@property (nonatomic, strong) NSMutableArray *cityMutableArray;
@property (nonatomic, strong) NSMutableArray *keyMutableArray;
@property (nonatomic, strong) NSMutableArray *locationCoordinate2DMutableArray;
@property (nonatomic, assign) int flag;
@end

@implementation MAPNavigationView

- (instancetype)init {
    self = [super init];
    if (self) {
        _mapView = [[BMKMapView alloc] init];
        [_mapView setZoomLevel:21];
        [self addSubview:_mapView];
        
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_navigationView];
        
        _loactionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _loactionTableView.backgroundColor = [UIColor whiteColor];
        _loactionTableView.dataSource = self;
        _loactionTableView.delegate = self;
        _loactionTableView.separatorStyle = UITableViewCellEditingStyleNone;
        _loactionTableView.showsVerticalScrollIndicator = NO;
        _loactionTableView.showsHorizontalScrollIndicator = NO;
        [_loactionTableView registerClass:[MAPLocationTableViewCell class] forCellReuseIdentifier:@"location"];
        [_navigationView addSubview:_loactionTableView];
        
        _checkButton = [[UIButton alloc] init];
        [_checkButton setTitle:[NSString stringWithFormat:@"开始导航"] forState:UIControlStateNormal];
        [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        [_navigationView addSubview:_checkButton];
        
        _locationMutableArray = [[NSMutableArray alloc] initWithObjects:@"起点", @"终点", nil];
        _locationDataMutableArray = [NSMutableArray arrayWithObjects:@"", @"", nil];
        _cityMutableArray = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
        _keyMutableArray = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
        _locationCoordinate2DMutableArray = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.35);
    }];
    
    [_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.65);
    }];
    
    [_loactionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_top).mas_offset(20);
        make.left.mas_equalTo(self.navigationView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.navigationView.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.navigationView.mas_bottom).mas_offset(-60);
    }];
    
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(self.navigationView.mas_left).mas_offset(0);
        make.right.mas_equalTo(self.navigationView.mas_right).mas_offset(0);
        make.bottom.mas_equalTo(self.navigationView.mas_bottom).mas_offset(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_locationMutableArray.count + 1 <= 5) {
        return _locationMutableArray.count + 1;
    } else {
        return 5;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAPLocationTableViewCell *cell1 = nil;
    UITableViewCell *cell2 = nil;
    if (indexPath.section < _locationMutableArray.count) {
        if (cell1 == nil) {
            cell1 = [_loactionTableView dequeueReusableCellWithIdentifier:@"location" forIndexPath:indexPath];
        }
        cell1.leftLabel.text = _locationMutableArray[indexPath.section];
        cell1.locationTextField.tag = 101;
        cell1.cityTextField.tag = 102;
        [cell1.locationTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        [cell1.cityTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        return cell1;
    } else {
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        UIImageView *addLocationImageView = [[UIImageView alloc] init];
        addLocationImageView.image = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        addLocationImageView.tintColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f];
        cell2.layer.borderWidth = 0.8f;
        cell2.layer.borderColor = [UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f].CGColor;
        cell2.backgroundColor = [UIColor whiteColor];
        [cell2 addSubview:addLocationImageView];
        [addLocationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell2.mas_centerX);
            make.centerY.mas_equalTo(cell2.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        return cell2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 10)];
    whiteView.backgroundColor = [UIColor whiteColor];
    return whiteView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == _locationMutableArray.count) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
        formatter.locale = locale;
        NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithUnsignedLong:_locationMutableArray.count]];
        [_locationMutableArray insertObject:[NSString stringWithFormat:@"第%@地点", numberString] atIndex:_locationMutableArray.count - 1];
    }
    [_loactionTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0 && indexPath.section != _locationMutableArray.count && indexPath.section != _locationMutableArray.count - 1) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

//可以显示编译状态，当手指在单元格上移动时
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据源对应的数据
        [_locationMutableArray removeObjectAtIndex:indexPath.section];
        //数据源更新
        [_loactionTableView reloadData];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

#pragma MAP  ---------------------------------------通过关键词进行提示检索----------------------------------------
- (void)textFieldEditChanged:(UITextField *)textField {
    if (textField.tag == 101) {
        //获取所点击的indexPath
        UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
        NSIndexPath *indexPath = [_loactionTableView indexPathForCell:cell];
        [_keyMutableArray replaceObjectAtIndex:indexPath.section withObject:textField.text];
    } else if (textField.tag == 102) {
        //获取所点击的indexPath
        UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
        NSIndexPath *indexPath = [_loactionTableView indexPathForCell:cell];
        [_cityMutableArray replaceObjectAtIndex:indexPath.section withObject:textField.text];
    }
    [_locationDataMutableArray replaceObjectAtIndex:0 withObject:_cityMutableArray];
    [_locationDataMutableArray replaceObjectAtIndex:1 withObject:_keyMutableArray];
    NSLog(@"_locationMutableArray = %@", _locationDataMutableArray);
    BMKSuggestionSearchOption *suggestionOption = [[BMKSuggestionSearchOption alloc] init];
    for (int i = 0; i < 5; i++) {
        suggestionOption.keyword = _locationDataMutableArray[1][i];
        suggestionOption.cityname = _locationDataMutableArray[0][i];
        suggestionOption.cityLimit = NO;
        [self searchData:suggestionOption];
    }
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
    /**
     关键词检索，异步方法，返回结果在BMKSuggestionSearchDelegate
     的onGetSuggestionResult里
     
     suggestionOption sug检索信息类
     成功返回YES，否则返回NO
     */
    BOOL flag = [suggestionSearch suggestionSearch:suggestionOption];
    if(flag) {
        NSLog(@"关键词检索成功");
    } else {
        NSLog(@"关键词检索失败");
    }
}

/**
 关键字检索结果回调
 @param searcher 检索对象
 @param result 关键字检索结果
 @param error 错误码，@see BMKCloudErrorCode
 */
- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    //BMKSearchErrorCode错误码，BMK_SEARCH_NO_ERROR：检索结果正常返回
//    if (error == BMK_SEARCH_NO_ERROR) {
//        NSMutableArray *annotations = [NSMutableArray array];
//        for (BMKSuggestionInfo *sugInfo in result.suggestionList) {
//            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
//            CLLocationCoordinate2D coor = sugInfo.location;
//            annotation.coordinate = coor;
//            _mapView.centerCoordinate = coor;
//            [annotations addObject:annotation];
//        }
//        //将一组标注添加到当前地图View中
//        [_mapView addAnnotations:annotations];
//    }
    
    BMKSuggestionInfo *sugInfo = result.suggestionList.firstObject;
    NSMutableArray *locationMutableArray = [[NSMutableArray alloc] init];
    [locationMutableArray addObject:@(sugInfo.location.latitude)];
    [locationMutableArray addObject:@(sugInfo.location.longitude)];
    [_locationCoordinate2DMutableArray replaceObjectAtIndex:_flag withObject:locationMutableArray];
    NSLog(@"_flag = %d, _locationCoordinate2D = %@", _flag, _locationCoordinate2DMutableArray);
}
@end
