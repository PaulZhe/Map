//
//  MAPNavigationView.m
//  Map
//
//  Created by _祀梦 on 2019/4/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPNavigationView.h"
#import <Masonry.h>

@interface MAPNavigationView ()
@property (nonatomic, strong) NSMutableArray *locationMutableArray;
@end

@implementation MAPNavigationView

- (instancetype) init {
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
        [_checkButton setTitle:[NSString stringWithFormat:@"查看路线"] forState:UIControlStateNormal];
        [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        [_checkButton addTarget:self action:@selector(clickedCheckButton:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView addSubview:_checkButton];
        
        _locationMutableArray = [[NSMutableArray alloc] initWithObjects:@"起点", @"终点", nil];
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
    return _locationMutableArray.count + 1;
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
        cell1.locationTextField.placeholder = _locationMutableArray[indexPath.section];
        [cell1.locationTextField setValue:[UIColor colorWithRed:0.95f green:0.35f blue:0.35f alpha:1.00f] forKeyPath:@"_placeholderLabel.textColor"];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
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
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据源对应的数据
        [_locationMutableArray removeObjectAtIndex:indexPath.section];
        //数据源更新
        [_loactionTableView reloadData];
    }
}
    
//查看路线点击事件
- (void)clickedCheckButton:(UIButton *)button {
    
}
@end
