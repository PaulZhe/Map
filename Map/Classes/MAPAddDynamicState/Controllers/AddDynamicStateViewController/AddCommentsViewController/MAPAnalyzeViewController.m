//
//  MAPAnalyzeViewController.m
//  Map
//
//  Created by _祀梦 on 2019/6/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAnalyzeViewController.h"
#import <Masonry.h>

@interface MAPAnalyzeViewController ()

@end

@implementation MAPAnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(210, 210));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(150);
    }];
    
    self.cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:self.cancelButton];
    self.cancelButton.backgroundColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.cancelButton.layer.cornerRadius = 3;
    self.cancelButton.layer.borderWidth = 0.8f;
    self.cancelButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.cancelButton addTarget:self action:@selector(clickedCnacnelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.top.mas_equalTo(self.pictureImageView.mas_bottom).mas_offset(80);
    }];
    
    self.sureButton = [[UIButton alloc] init];
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:self.sureButton];
    self.sureButton.backgroundColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.sureButton.layer.cornerRadius = 3;
    self.sureButton.layer.borderWidth = 0.8f;
    self.sureButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.sureButton addTarget:self action:@selector(clickedSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-80);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.top.mas_equalTo(self.pictureImageView.mas_bottom).mas_offset(80);
    }];
    
}

- (void)clickedCnacnelButton:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickedSureButton:(UIButton *)button {
    
}

@end
