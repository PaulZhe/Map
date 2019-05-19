//
//  MAPAddDynamicStateView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/1.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddDynamicStateView.h"
#import <Masonry.h>
@interface MAPAddDynamicStateView()

@property (nonatomic, strong) UIView *addDynamicStateView;//添加动态
@property (nonatomic, strong) UILabel *locationNameLabel;//地点名称
@property (nonatomic, strong) UIButton *adjustmentButton;//地点微调按钮
@property (nonatomic, strong) UIView *lineView;//分界线
@property (nonatomic, strong) UIButton *issueButton;//发布按钮

@end

@implementation MAPAddDynamicStateView

///101评论界面，102图片界面，103语音界面，104视频界面
- (instancetype)initWithTypeString:(NSString *) typeString {
    self = [super init];
    if (self) {
        self.mapView = [[BMKMapView alloc] init];
        //将当前地图显示缩放等级设置为21级
        [self.mapView setZoomLevel:21];
        [self addSubview:_mapView];
        
        self.addDynamicStateView = [[UIView alloc] init];
        self.addDynamicStateView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addDynamicStateView];
        
        self.locationNameLabel = [[UILabel alloc] init];
        [self.addDynamicStateView addSubview:_locationNameLabel];
        self.locationNameLabel.text = @"西安邮电大学";
        self.locationNameLabel.font = [UIFont systemFontOfSize:23];
        
        self.adjustmentButton = [[UIButton alloc] init];
        [self.addDynamicStateView addSubview:_adjustmentButton];
        self.adjustmentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.adjustmentButton setTitle:[NSString stringWithFormat:@"地点微调？"] forState:UIControlStateNormal];
        [self.adjustmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.adjustmentButton addTarget:self action:@selector(adjustmentLocation:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineView = [[UIImageView alloc] init];
        [self.addDynamicStateView addSubview:_lineView];
        self.lineView.backgroundColor = [UIColor blackColor];
        
        self.issueButton = [[UIButton alloc] init];
        [self.addDynamicStateView addSubview:_issueButton];
        [self.issueButton setTitle:[NSString stringWithFormat:@"发  布"] forState:UIControlStateNormal];
        [self.issueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.issueButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        
        if ([typeString isEqualToString:@"101"]) {
            //添加评论界面
            self.addCommentView = [[MAPAddCommentsView alloc] init];
            self.addCommentView.delegate = self;
            [self.addDynamicStateView addSubview:_addCommentView];
        } else if ([typeString isEqualToString:@"102"]) {
            //添加图片界面
            self.addPicturesView = [[MAPAddPicturesView alloc] init];
            self.addPicturesView.delegate = self;
            [self.addDynamicStateView addSubview:_addPicturesView];
        } else if ([typeString isEqualToString:@"103"]) {
            //添加语音界面
            __weak typeof(self) weakSelf = self;
            self.issueAudioView = [[MAPIssueAudioView alloc] init];
            
            //点击语音button播放语音
            self.issueAudioView.motiveAudioButton.motiveAudioAction = ^(UIButton * _Nonnull sender) {
                NSURL *mp3Url = [NSURL fileURLWithPath:weakSelf.mp3Path];
                weakSelf.issueAudioView.audioRecordUtils.player = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3Url error:nil];
                [weakSelf.issueAudioView.audioRecordUtils.player prepareToPlay];
                [weakSelf.issueAudioView.audioRecordUtils.player play];
                NSLog(@"++++mp3 play");
            };
            [self.addDynamicStateView addSubview:_issueAudioView];
        } else {
            //添加视频界面
            self.addVedioView = [[MAPAddVedioView alloc] init];
            self.addVedioView.delegate = self;
            [self.addDynamicStateView addSubview:_addVedioView];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.35);
    }];
    
    [_addDynamicStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.65);
    }];
    
    [_locationNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [_adjustmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_locationNameLabel.mas_bottom).mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(0.8);
    }];
    
    [_issueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    [_addCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
        make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
        make.bottom.mas_equalTo(self->_issueButton.mas_top);
    }];
    
    [self.issueAudioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom);
        make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
        make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
        make.bottom.mas_equalTo(self->_issueButton.mas_top);
    }];
    
    [_addPicturesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom);
        make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
        make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
        make.bottom.mas_equalTo(self->_issueButton.mas_top);
    }];
    
    [_addVedioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom);
        make.left.mas_equalTo(self->_addDynamicStateView.mas_left);
        make.right.mas_equalTo(self->_addDynamicStateView.mas_right);
        make.bottom.mas_equalTo(self->_issueButton.mas_top);
    }];
}

//地点微调点击事件
- (void)adjustmentLocation:(UIButton *)button {
    if (_adjustAction) {
        self.adjustAction(button);
    }
}

//键盘的弹出与收回事件
- (void)keyboardWillAppearOrWillDisappear:(NSString *)appearOrDisappearString AndKeykeyboardHeight:(CGFloat)keyboardHeight{
    if ([appearOrDisappearString isEqualToString:@"disappear"]) {
        [UIView animateWithDuration:1 animations:^{
            self->_mapView.transform = CGAffineTransformMakeTranslation(0, 0);
            self->_addDynamicStateView.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    } else if ([appearOrDisappearString isEqualToString:@"appear"]) {
        // 视图整体上升
        [UIView animateWithDuration:1.0 animations:^{
            self->_mapView.transform = CGAffineTransformMakeTranslation(0, keyboardHeight - self.frame.size.height);
            self->_addDynamicStateView.transform = CGAffineTransformMakeTranslation(0, keyboardHeight - self.frame.size.height);
        }];
    }
}

@end
