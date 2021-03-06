//
//  MAPAddCommentView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/28.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddCommentView.h"
#import <Masonry.h>

@implementation MAPAddCommentView

- (instancetype) init {
    self = [super init];
    if (self) {
        _addCommentTextView = [[UITextView alloc] init];
        [self addSubview:_addCommentTextView];
        _addCommentTextView.delegate = self;
        _addCommentTextView.font = [UIFont systemFontOfSize:16.5f];
        _addCommentTextView.textColor = [UIColor blackColor];
        _addCommentTextView.keyboardType = UIKeyboardTypeDefault;
        _addCommentTextView.returnKeyType = UIReturnKeyDefault;
        // 自定义文本框placeholder
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.text = @"添加评论...";
        _placeHolderLabel.font = [UIFont fontWithName:@"Arial" size:16.5f];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.enabled = NO;
        [_addCommentTextView addSubview:_placeHolderLabel];
        // 自定义文本框字数统计
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"0/140";
        _countLabel.tintColor = [UIColor blackColor];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.enabled = NO;
        [_addCommentTextView addSubview:_countLabel];
        
        _addPicturesView = [[UIView alloc] init];
        [self addSubview:_addPicturesView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _picturesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _picturesCollectionView.dataSource = self;
        _picturesCollectionView.delegate = self;
        _picturesCollectionView.backgroundColor = [UIColor whiteColor];
        _picturesCollectionView.showsHorizontalScrollIndicator = NO;
        _picturesCollectionView.showsVerticalScrollIndicator = NO;
        [_addPicturesView addSubview:_picturesCollectionView];
        [_picturesCollectionView registerClass:[MAPMotivePicturesCollectionViewCell class] forCellWithReuseIdentifier:@"pictures"];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenkeyboardView)];
        //将触摸事件添加到当前view
        [_addCommentTextView addGestureRecognizer:tapGestureRecognizer];
        _flag = 0;
        
        //监听键盘的出现与消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_addCommentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self);
    }];
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_addCommentTextView.mas_top).mas_equalTo(3);
        make.left.mas_equalTo(self->_addCommentTextView.mas_left).mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self->_addCommentTextView.mas_bottom);
        make.right.mas_equalTo(self->_addCommentTextView.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [_addPicturesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addCommentTextView.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self.mas_right).mas_offset(0);
        make.left.mas_equalTo(self.mas_left).mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
    }];
    [_picturesCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(0);
        make.right.mas_equalTo(self.mas_right).mas_offset(0);
        make.left.mas_equalTo(self.mas_left).mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
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

#pragma mark - collectionDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     MAPMotivePicturesCollectionViewCell *cell = [_picturesCollectionView dequeueReusableCellWithReuseIdentifier:@"pictures" forIndexPath:indexPath];
    NSString* str1 = [NSString stringWithFormat:@"upPicture1"];
    NSString* str2 = [NSString stringWithFormat:@"upPicture2"];
    NSString* str3 = [NSString stringWithFormat:@"upPicture3"];
    NSString* str4 = [NSString stringWithFormat:@"upPicture4"];
    NSString* str5 = [NSString stringWithFormat:@"upPicture5"];
    NSString* str6 = [NSString stringWithFormat:@"upPicture6"];
    NSString* str7 = [NSString stringWithFormat:@"upPicture7"];
    NSString* str8 = [NSString stringWithFormat:@"upPicture8"];
    NSString* str9 = [NSString stringWithFormat:@"upPicture9"];
    NSString* str10 = [NSString stringWithFormat:@"upPicture10"];
    NSString* str11 = [NSString stringWithFormat:@"upPicture11"];
    NSString* str12 = [NSString stringWithFormat:@"upPicture12"];
    NSArray* sec = [NSArray arrayWithObjects:str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, str11, str12, nil];
    cell.picturesImageView.image = [UIImage imageNamed:[sec objectAtIndex:indexPath.item]];
    return cell;
}

@end
