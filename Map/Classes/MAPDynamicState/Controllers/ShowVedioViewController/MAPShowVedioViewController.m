//
//  MAPShowVedioViewController.m
//  Map
//
//  Created by _祀梦 on 2019/6/14.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPShowVedioViewController.h"

@interface MAPShowVedioViewController () <UITableViewDelegate>

@end

@implementation MAPShowVedioViewController

//- (MAPDynamicStateView *)showDynamicStatueView {
//    if (!_dynamicStateView) {
//        self.dynamicStateView = [[MAPDynamicStateView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        self.dynamicStateView.dyanmicStateTableView.delegate = self;
//        [self.view addSubview:_dynamicStateView];
//        self.dynamicStateView.typeMotiveString = [NSString stringWithFormat:@"%d", 4];
//    }
//    return _dynamicStateView;
//}

//设置导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(BackToHomePage:)];
    
    backButtonItem.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_dynamicStateView) {
        self.dynamicStateView = [[MAPDynamicStateView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.dynamicStateView.dyanmicStateTableView.delegate = self;
        [self.view addSubview:_dynamicStateView];
        self.dynamicStateView.typeMotiveString = [NSString stringWithFormat:@"%d", 4];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

//导航栏返回按钮点击事件
- (void)BackToHomePage:(UIButton *) button {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
