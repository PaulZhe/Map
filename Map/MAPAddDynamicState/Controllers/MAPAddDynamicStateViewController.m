//
//  MAPAddDynamicStateViewController.m
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddDynamicStateViewController.h"

@interface MAPAddDynamicStateViewController ()

@end

@implementation MAPAddDynamicStateViewController

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
    _addDynamicStateView = [[MAPAddDynamicStateView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_addDynamicStateView];
}

//导航栏返回按钮点击事件
- (void)BackToHomePage:(UIButton *) button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
