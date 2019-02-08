//
//  MAPAlertView.m
//  Map
//
//  Created by 小哲的DELL on 2019/1/30.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPAlertView.h"
#import "MAPIssueView.h"

@interface MAPAlertView ()

@property (strong, nonatomic) UIView *transparentView;
@property (strong, nonatomic) UIView *alterView;
@property (strong, nonatomic) UILabel *labTitle1;
@property (strong, nonatomic) UILabel *labTitle2;
@property (strong, nonatomic) UIButton *btnCancle;
@property (strong, nonatomic) UIButton *btnConfirm;

@end

@implementation MAPAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _transparentView = [[UIView alloc] initWithFrame:frame];
        _transparentView.backgroundColor= [UIColor colorWithWhite:0 alpha:0.25];
        [self addSubview:_transparentView];
        
        _alterView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-240)/2, (frame.size.height-180)/2, 240, 180)];
        _alterView.backgroundColor = [UIColor whiteColor];
        _alterView.layer.cornerRadius = 3.0;
        _alterView.layer.masksToBounds = YES;
        [_alterView.layer setBorderWidth:1.0];
        _alterView.layer.borderColor = [UIColor blackColor].CGColor;
        [_transparentView addSubview:_alterView];
        
        _labTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 220, 40)];
        _labTitle1.textAlignment = NSTextAlignmentCenter;
        _labTitle1.numberOfLines = 1;
        _labTitle1.text = @"这里什么信息都没有哦";
        [_labTitle1 setFont:[UIFont systemFontOfSize:18]];
        [_alterView addSubview:_labTitle1];
        
        _labTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 220, 30)];
        _labTitle2.textAlignment = NSTextAlignmentCenter;
        _labTitle2.numberOfLines = 0;
        [_labTitle2 setFont:[UIFont systemFontOfSize:14]];
        _labTitle2.text = @"我要做第一个添加内容的人！";
        [_alterView addSubview:_labTitle2];
        
        _btnCancle = [[UIButton alloc] initWithFrame:CGRectMake(10, 140, 100, 35)];
        [_btnCancle setTitle:@"不要" forState:UIControlStateNormal];
        [_btnCancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnCancle.layer.cornerRadius = 5.0;
        _btnCancle.layer.masksToBounds = YES;
        _btnCancle.backgroundColor = [UIColor whiteColor];
        [_btnCancle setTag:100];
        [_btnCancle.layer setBorderWidth:1.0];
        _btnCancle.layer.borderColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f].CGColor;
        [_btnCancle addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_alterView addSubview:_btnCancle];
        
        _btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake (130, 140, 100, 35)];
        [_btnConfirm setTitle:@"发布" forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnConfirm.layer.cornerRadius = 5.0;
        _btnConfirm.layer.masksToBounds = YES;
        _btnConfirm.backgroundColor = [UIColor whiteColor];
        [_btnConfirm setTag:101];
        [_btnConfirm.layer setBorderWidth:1.0];
        _btnConfirm.layer.borderColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f].CGColor;
        [_btnConfirm addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnConfirm setTag:101];
        [_alterView addSubview:_btnConfirm];
    }
    return self;
}

- (void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    _btnAction(btn.tag);
    
}

@end
