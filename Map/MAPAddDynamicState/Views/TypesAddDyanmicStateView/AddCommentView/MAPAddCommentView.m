//
//  MAPAddCommentView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/2.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddCommentView.h"
#import <Masonry.h>

@implementation MAPAddCommentView 

- (instancetype) init {
    self = [super init];
    if (self) {
        _locationNameLabel = [[UILabel alloc] init];
        [self addSubview:_locationNameLabel];
        _locationNameLabel.text = @"西安邮电大学";
        _locationNameLabel.font = [UIFont systemFontOfSize:23];
        
        _adjustmentButton = [[UIButton alloc] init];
        [self addSubview:_adjustmentButton];
        _adjustmentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_adjustmentButton setTitle:[NSString stringWithFormat:@"地点微调？"] forState:UIControlStateNormal];
        [_adjustmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _lineView = [[UIImageView alloc] init];
        [self addSubview:_lineView];
        _lineView.backgroundColor = [UIColor blackColor];

        _addCommentTextView = [[UITextView alloc] init];
        [self addSubview:_addCommentTextView];
        _addCommentTextView.delegate = self;
        _addCommentTextView.font = [UIFont systemFontOfSize:16.5f];
        _addCommentTextView.textColor = [UIColor blackColor];
        _addCommentTextView.keyboardType = UIKeyboardTypeDefault;
        //不自动大写
        _addCommentTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _addCommentTextView.returnKeyType = UIReturnKeyDefault;
        // 自定义文本框placeholder
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 320, 35)];
        _placeHolderLabel.text = @"添加评论...";
        _placeHolderLabel.font = [UIFont fontWithName:@"Arial" size:16.5f];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.enabled = NO;
        [_addCommentTextView addSubview:_placeHolderLabel];
        // 自定义文本框字数统计
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 330, 80, 20)];
        _countLabel.text = @"0/140";
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.enabled = NO;
        [_addCommentTextView addSubview:_countLabel];
        
        _issueButton = [[UIButton alloc] init];
        [self addSubview:_issueButton];
        [_issueButton setTitle:[NSString stringWithFormat:@"发  布"] forState:UIControlStateNormal];
        [_issueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_issueButton setBackgroundColor:[UIColor colorWithRed:0.95f green:0.55f blue:0.55f alpha:1.00f]];
        
        //监听键盘的出现与消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
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
    
    [_addCommentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_lineView.mas_bottom).mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(360);
    }];
    
    [_issueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_addCommentTextView.mas_bottom).mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

// 限制输入文本长度
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location < 140) {
        return  YES;
    } else {
        return NO;
    }
}

// 自定义文本框placeholder
- (void)textViewDidChange:(UITextView *)textView {
    _countLabel.text = [NSString stringWithFormat:@"%lu/%@", _addCommentTextView.text.length, @"140"];
    if (textView.text.length == 0) {
        _placeHolderLabel.text = @"添加评论...";
    } else {
        _placeHolderLabel.text = @"";
    }
}

- (void)keyboardWillDisappear:(NSNotification *)notification{
    [UIView animateWithDuration:1 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)keyboardWillAppear:(NSNotification *)notification{
    // 计算键盘高度
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 视图整体上升
    [UIView animateWithDuration:1.0 animations:^{self.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.frame.size.height);}];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_addCommentTextView resignFirstResponder];
}

@end
