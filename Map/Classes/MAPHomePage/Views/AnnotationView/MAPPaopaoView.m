//
//  MAPPaopaoView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPPaopaoView.h"
#import <Masonry.h>

@interface MAPPaopaoView()

@property (nonatomic, strong) UITapGestureRecognizer * tapRG;

@end
@implementation MAPPaopaoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        self.userInteractionEnabled = NO;
        [self initPaopaoView];
    }
    return self;
}

- (void)initPaopaoView {
    _commentButton = [[MAPPaopaoButton alloc] init];
    _commentButton.countLabel.text = [NSString stringWithFormat:@"%ld", _mesCount];
    [_commentButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    _commentButton.tag = 101;
    [self addSubview:_commentButton];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _picturesButton = [[MAPPaopaoButton alloc] init];
    _picturesButton.countLabel.text = [NSString stringWithFormat:@"%ld", _phoCount];
    [_picturesButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    _picturesButton.tag = 102;
    [self addSubview:_picturesButton];
    [_picturesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_commentButton.mas_top).mas_equalTo(20);
        make.left.mas_equalTo(self->_commentButton.mas_right).mas_equalTo(2);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _voiceButton = [[MAPPaopaoButton alloc] init];
    _voiceButton.countLabel.text = [NSString stringWithFormat:@"%ld", _audCount];
    [_voiceButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    _voiceButton.tag = 103;
    [self addSubview:_voiceButton];
    [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_picturesButton.mas_centerY).mas_equalTo(12);
        make.left.mas_equalTo(self->_picturesButton.mas_right).mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _vedioButton = [[MAPPaopaoButton alloc] init];
    _vedioButton.countLabel.text = [NSString stringWithFormat:@"%ld", _vidCount];
    [_vedioButton setImage:[UIImage imageNamed:@"video"] forState:UIControlStateNormal];
    _vedioButton.tag = 104;
    [self addSubview:_vedioButton];
    [_vedioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_voiceButton.mas_centerY).mas_equalTo(22);
        make.left.mas_equalTo(self->_voiceButton.mas_right).mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    //如果上层透明视图是window  按钮（uibutton 继承自UIControl ）就允许点击
    NSLog(@"+++++%f,%f", point.x, point.y);
    NSLog(@"%@", hitView);
    if(![hitView isKindOfClass:[UIButton class]]){
        return nil;
    }
    return hitView;
}

@end
