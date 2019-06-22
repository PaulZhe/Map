//
//  MAPAddCommentsView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/28.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddCommentsView.h"
#import <Masonry.h>

@implementation MAPAddCommentsView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.takePictureButton = [[UIButton alloc] init];
        [self addSubview:self.takePictureButton];
        self.takePictureButton.layer.cornerRadius = 60;
        self.takePictureButton.layer.borderWidth = 1.2f;
        self.takePictureButton.layer.borderColor = [UIColor grayColor].CGColor;
        [self.takePictureButton setImage:[[UIImage imageNamed:@"hao"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.takePictureButton setTintColor:[UIColor colorWithRed:0.95f green:0.54f blue:0.54f alpha:1.00f]];

        
        self.addCommentTextView = [[UITextView alloc] init];
        [self addSubview:_addCommentTextView];
        self.addCommentTextView.layer.cornerRadius = 15;
        self.addCommentTextView.layer.borderWidth = 0.8f;
        self.addCommentTextView.layer.borderColor = [UIColor grayColor].CGColor;
        self.addCommentTextView.delegate = self;
        self.addCommentTextView.font = [UIFont systemFontOfSize:16.5f];
        self.addCommentTextView.textColor = [UIColor blackColor];
        self.addCommentTextView.keyboardType = UIKeyboardTypeDefault;
        self.addCommentTextView.returnKeyType = UIReturnKeyDefault;
        // 自定义文本框placeholder
        self.placeHolderLabel = [[UILabel alloc] init];
        self.placeHolderLabel.text = @"添加评论...";
        self.placeHolderLabel.font = [UIFont fontWithName:@"Arial" size:16.5f];
        self.placeHolderLabel.backgroundColor = [UIColor clearColor];
        self.placeHolderLabel.enabled = NO;
        [self.addCommentTextView addSubview:_placeHolderLabel];
        // 自定义文本框字数统计
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.text = @"0/140";
        self.countLabel.tintColor = [UIColor blackColor];
        self.countLabel.textAlignment = NSTextAlignmentRight;
        self.countLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
        self.countLabel.backgroundColor = [UIColor clearColor];
        self.countLabel.enabled = NO;
        [self.addCommentTextView addSubview:_countLabel];
   
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenkeyboardView)];
        //将触摸事件添加到当前view
        [_addCommentTextView addGestureRecognizer:tapGestureRecognizer];
        self.flag = 0;
        
        //监听键盘的出现与消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.takePictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    [_addCommentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.takePictureButton.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(150);
    }];
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addCommentTextView.mas_top).mas_equalTo(3);
        make.left.mas_equalTo(self.addCommentTextView.mas_left).mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addCommentTextView.mas_top).mas_offset(115);
        make.right.mas_equalTo(self.mas_right).mas_offset(-28);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

#pragma MAP  --------------------UItextField事件--------------------
// 限制输入文本长度
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location < 140) {
        return  YES;
    } else {
        return NO;
    }
}

// 自定义文本框placeholder
- (void) textViewDidChange:(UITextView *)textView {
    _countLabel.text = [NSString stringWithFormat:@"%lu/%@", _addCommentTextView.text.length, @"140"];
    if (textView.text.length == 0) {
        _placeHolderLabel.text = @"添加评论...";
    } else {
        _placeHolderLabel.text = @"";
    }
}

//键盘的收回
- (void) keyboardWillDisappear:(NSNotification *)notification{
    // 计算键盘高度
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    if ([_delegate respondsToSelector:@selector(keyboardWillAppearOrWillDisappear: AndKeykeyboardHeight:)]) {
        [_delegate keyboardWillAppearOrWillDisappear:[NSString stringWithFormat:@"disappear"] AndKeykeyboardHeight:keyboardY];
    }
    _flag = 0;
}
//键盘的弹出
- (void) keyboardWillAppear:(NSNotification *)notification{
    // 计算键盘高度
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    if ([_delegate respondsToSelector:@selector(keyboardWillAppearOrWillDisappear:AndKeykeyboardHeight:)]) {
        [_delegate keyboardWillAppearOrWillDisappear:[NSString stringWithFormat:@"appear"] AndKeykeyboardHeight:keyboardY];
    }
    _flag = 1;
}
- (void) HiddenkeyboardView {
    if (_flag == 1) {
        [_addCommentTextView endEditing:YES];
    } else if (_flag == 0) {
        [_addCommentTextView becomeFirstResponder];
    }
}
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
