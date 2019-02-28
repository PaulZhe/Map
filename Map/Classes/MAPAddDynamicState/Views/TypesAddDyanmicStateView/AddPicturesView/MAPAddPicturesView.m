//
//  MAPAddPicturesView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/3.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddPicturesView.h"
#import <Masonry.h>
//#import <QuartzCore/QuartzCore.h>

@implementation MAPAddPicturesView

- (instancetype) init {
    self = [super init];
    if (self) {
        _hintLabel = [[UILabel alloc] init];
        [self addSubview:_hintLabel];
        _hintLabel.text = @"添加标题...";
        
        _addTitleTextField = [[UITextField alloc] init];
        _addTitleTextField.delegate = self;
        [self addSubview:_addTitleTextField];
        _addTitleTextField.borderStyle = UITextBorderStyleNone;
        _addTitleTextField.layer.cornerRadius = 15;
        _addTitleTextField.layer.borderWidth = 0.8f;
        _addTitleTextField.layer.borderColor = [UIColor colorWithRed:0.14f green:0.14f blue:0.14f alpha:1.00f].CGColor;
        //设置左边空格量
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        leftView.backgroundColor = [UIColor clearColor];
        _addTitleTextField.leftView = leftView;
        _addTitleTextField.leftViewMode = UITextFieldViewModeAlways;
        //设置字数标签
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(340, 0, 40, 30)];
        _countLabel.text = @"0/10";
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
        _countLabel.backgroundColor = [UIColor clearColor];
        [_addTitleTextField addSubview:_countLabel];
        //给textField添加字数限制
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:_addTitleTextField];
        
        _addPicturesView = [[UIView alloc] init];
        [self addSubview:_addPicturesView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _picturesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _picturesCollectionView.delegate = self;
        _picturesCollectionView.dataSource = self;
        _picturesCollectionView.backgroundColor = [UIColor whiteColor];
        _picturesCollectionView.showsVerticalScrollIndicator = NO;
        _picturesCollectionView.showsHorizontalScrollIndicator = NO;
        [_addPicturesView addSubview:_picturesCollectionView];
        [_picturesCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"pictures"];
        
        UITapGestureRecognizer *tapTextGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showKeyboard)];
        UITapGestureRecognizer *tapSurfaceGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboardView)];
        [_addTitleTextField addGestureRecognizer:tapTextGesture];
        [self addGestureRecognizer:tapSurfaceGesture];
        
        //监听键盘的出现与消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];

    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_equalTo(10);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];

    [_addTitleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_hintLabel.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];

    [_addPicturesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_addTitleTextField.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(0);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [_picturesCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addPicturesView.mas_top).mas_equalTo(5);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(5);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-5);
        make.bottom.mas_equalTo(self.addPicturesView.mas_bottom).mas_offset(-5);
    }];
}

#pragma MAP  -------------textField的阴纹和字数限制与键盘弹出与收回------------
//字数限制
- (void) textFieldDidChangeValue:(NSNotification *) notifcation {
    UITextField *textField = (UITextField *)[notifcation object];
    NSInteger kMaxLength = 10 ;
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
        //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            } else {
                _countLabel.text = [NSString stringWithFormat:@"%lu/%@", _addTitleTextField.text.length, @"10"];
            }
        } else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        } else {
            _countLabel.text = [NSString stringWithFormat:@"%lu/%@", _addTitleTextField.text.length, @"10"];
        }
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
}
//键盘的弹出
- (void) keyboardWillAppear:(NSNotification *)notification{
    // 计算键盘高度
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    if ([_delegate respondsToSelector:@selector(keyboardWillAppearOrWillDisappear:AndKeykeyboardHeight:)]) {
        [_delegate keyboardWillAppearOrWillDisappear:[NSString stringWithFormat:@"appear"] AndKeykeyboardHeight:keyboardY];
    }
}
- (void)hiddenKeyboardView {
    [_addTitleTextField endEditing:YES];
}
- (void)showKeyboard {
    [_addTitleTextField becomeFirstResponder];
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
    UICollectionViewCell *cell = [_picturesCollectionView dequeueReusableCellWithReuseIdentifier:@"pictures" forIndexPath:indexPath];
    return cell;
}

@end
