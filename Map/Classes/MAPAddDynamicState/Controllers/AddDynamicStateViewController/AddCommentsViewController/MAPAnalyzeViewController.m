//
//  MAPAnalyzeViewController.m
//  Map
//
//  Created by _祀梦 on 2019/6/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAnalyzeViewController.h"
#import <Masonry.h>
#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

@interface MAPAnalyzeViewController () <ARSCNViewDelegate>
@property (nonatomic, strong) ARSession *arSession;
@property (nonatomic, strong) ARConfiguration *arConfiguration;
@property (nonatomic, strong) ARSCNView *arSCNView;
@property (nonatomic, assign) CGFloat simleValue;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation MAPAnalyzeViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(BackToHomePage:)];
    backButtonItem.tintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pictureView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2)];
    [self.view addSubview:self.pictureView];
    [self.pictureView addSubview:self.arSCNView];
    
    self.slider = [[UISlider alloc] init];
    self.slider.maximumValue = 1;
    self.slider.minimumValue = 0;
    self.slider.value = 0;
    //左侧滑条背景颜色
    self.slider.minimumTrackTintColor = [UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f];
    //右侧滑条背景颜色
    self.slider.maximumTrackTintColor = [UIColor grayColor];
    self.slider.thumbTintColor = [UIColor whiteColor];
    [self.view addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(195, 30));
        make.top.mas_equalTo(self.pictureView.mas_bottom).mas_offset(20);
    }];
    
    self.simleLabel = [[UILabel alloc] init];
    self.simleLabel.text = @"微笑指数";
    self.simleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.simleLabel];
    [self.simleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(8);
        make.right.mas_equalTo(self.slider.mas_left).mas_offset(-5);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.pictureView.mas_bottom).mas_offset(20);
    }];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.text = @"0";
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.slider.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-5);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.pictureView.mas_bottom).mas_offset(20);
    }];
    
    self.simleButton = [[UIButton alloc] init];
    [self.simleButton setImage:[UIImage imageNamed:@"Smile"] forState:UIControlStateNormal];
    [self.simleButton setImage:[UIImage imageNamed:@"Smile-2"] forState:UIControlStateSelected];
    [self.view addSubview:self.simleButton];
    [self.simleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slider.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    self.lengMoButton = [[UIButton alloc] init];
    [self.lengMoButton setImage:[UIImage imageNamed:@"Strait-2"] forState:UIControlStateNormal];
    [self.lengMoButton setImage:[UIImage imageNamed:@"Strait"] forState:UIControlStateSelected];
    [self.view addSubview:self.lengMoButton];
    [self.lengMoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slider.mas_bottom).mas_offset(20);
        make.right.mas_equalTo(self.simleButton.mas_left).mas_offset(-30);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    self.bigSimleButton = [[UIButton alloc] init];
    [self.bigSimleButton setImage:[UIImage imageNamed:@"Big-Smile"] forState:UIControlStateNormal];
    [self.bigSimleButton setImage:[UIImage imageNamed:@"Big-Smile-2"] forState:UIControlStateSelected];
    [self.view addSubview:self.bigSimleButton];
    [self.bigSimleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slider.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.simleButton.mas_right).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(70, 70));
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
        make.top.mas_equalTo(self.bigSimleButton.mas_bottom).mas_offset(50);
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
        make.top.mas_equalTo(self.bigSimleButton.mas_bottom).mas_offset(50);
    }];
    
    
    [self.arSession runWithConfiguration:self.arConfiguration options:ARSessionRunOptionRemoveExistingAnchors];
}


- (void)clickedCnacnelButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickedSureButton:(UIButton *)button {
    
}

//导航栏返回按钮点击事件
- (void)BackToHomePage:(UIButton *) button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ARSCNViewDelegate
- (void)renderer:(id<SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    if (!anchor || ![anchor isKindOfClass:[ARFaceAnchor class]]) return;
    
    ARFaceAnchor *faceAnchor = (ARFaceAnchor *)anchor;
    NSDictionary *blendShips = faceAnchor.blendShapes;
    CGFloat leftSmile = [blendShips[ARBlendShapeLocationMouthSmileLeft] floatValue];
    CGFloat rightSmile = [blendShips[ARBlendShapeLocationMouthSmileRight] floatValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.slider.value = (leftSmile + rightSmile)/2;
        self.countLabel.text = [NSString stringWithFormat:@"%.2f", self.slider.value];
        if (0 < self.slider.value <= 0.3) {
            [self.lengMoButton setSelected:YES];
        } else if (0.3 < self.slider.value <= 0.6) {
            [self.simleButton setSelected:YES];
        } else {
            [self.bigSimleButton setSelected:YES];
        }
    });
}

#pragma mark - 懒加载
- (ARSession *)arSession {
    if (!_arSession) {
        _arSession = [[ARSession alloc] init];
    }
    
    return _arSession;
}

- (ARConfiguration *)arConfiguration {
    if (!_arConfiguration) {
        _arConfiguration = [[ARFaceTrackingConfiguration alloc] init];
        _arConfiguration.lightEstimationEnabled = YES;
    }
    
    return _arConfiguration;
}

- (ARSCNView *)arSCNView {
    if (!_arSCNView) {
        _arSCNView = [[ARSCNView alloc] initWithFrame:self.pictureView.bounds options:nil];
        _arSCNView.scene = [SCNScene new];
        _arSCNView.session = self.arSession;
        _arSCNView.delegate = self;
        _arSCNView.backgroundColor = [UIColor clearColor];
    }
    
    return _arSCNView;
}

@end
