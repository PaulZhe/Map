//
//  MAPAddPicturesView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/3.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAddPicturesView.h"
#import <Masonry.h>
#import "MAPAddPicturesCollectionViewCell.h"
#import "MAPPhotoKitViewController.h"
//#import <QuartzCore/QuartzCore.h>

@interface MAPAddPicturesView ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSDictionary *selectImageDictionary;
@end

@implementation MAPAddPicturesView

- (instancetype)init {
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
        [_picturesCollectionView registerClass:[MAPAddPicturesCollectionViewCell class] forCellWithReuseIdentifier:@"pictures"];
        
        UITapGestureRecognizer *tapTextGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showKeyboard)];
        UITapGestureRecognizer *tapSurfaceGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboardView)];
        [_addTitleTextField addGestureRecognizer:tapTextGesture];
        [_addTitleTextField addGestureRecognizer:tapSurfaceGesture];
        
        //监听键盘的出现与消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
        
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)layoutSubviews {
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
        make.top.mas_equalTo(self.addPicturesView.mas_top).mas_equalTo(0);
        make.left.mas_equalTo(self.mas_left).mas_equalTo(10);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-10);
        make.bottom.mas_equalTo(self.addPicturesView.mas_bottom).mas_offset(-10);
    }];
}

#pragma MAP  -------------textField的阴纹和字数限制与键盘弹出与收回------------
//字数限制
- (void)textFieldDidChangeValue:(NSNotification *) notifcation {
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
- (void)keyboardWillDisappear:(NSNotification *)notification{
    // 计算键盘高度
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    if ([_delegate respondsToSelector:@selector(keyboardWillAppearOrWillDisappear: AndKeykeyboardHeight:)]) {
        [_delegate keyboardWillAppearOrWillDisappear:[NSString stringWithFormat:@"disappear"] AndKeykeyboardHeight:keyboardY];
    }
}
//键盘的弹出
- (void)keyboardWillAppear:(NSNotification *)notification{
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
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - collectionDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataSource.count == 0) {
        return 1;
    } else {
        return _dataSource.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MAPAddPicturesCollectionViewCell *cell = [_picturesCollectionView dequeueReusableCellWithReuseIdentifier:@"pictures" forIndexPath:indexPath];
    
    NSString *addPicture = [NSString stringWithFormat:@"xukuang"];
    if (_dataSource.count == 0) {
        cell.imageView.image = [UIImage imageNamed:addPicture];
    } else {
        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.synchronous = NO;
        requestOptions.networkAccessAllowed = NO;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        if (indexPath.item < _dataSource.count) {
            [[PHImageManager defaultManager] requestImageForAsset:_dataSource[indexPath.item] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    cell.imageView.image = result;
                } else {
                    cell.imageView.image = [UIImage imageNamed:@"noimage"];
                }
            }];
        }
        if (indexPath.item == self->_dataSource.count) {
            cell.imageView.image = [UIImage imageNamed:addPicture];
        }
    }
    return cell;
}

//返回每个cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 41)/3, ([UIScreen mainScreen].bounds.size.width - 41)/3);
}

//返回cell之间 行 间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//返回cell之间 列 间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //如果cell被覆盖无法响应点击事件
    if (indexPath.row == _dataSource.count) {
        MAPPhotoKitViewController *photoKitViewController = [[MAPPhotoKitViewController alloc] initWithMaxCount:@"9" andIsHaveOriginal:@"0" andOldImagesDictonary:_selectImageDictionary andIfGetImageArray:YES];
        
        [photoKitViewController setGetSubmitDictionary:^(NSMutableDictionary *selectDictionary) {
            NSLog(@"dic = %@", selectDictionary);
            self->_selectImageDictionary = selectDictionary;
            [self upDataCollection];
        }];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:photoKitViewController];
        [self.delegate getToPhotoAlbumViewAndViewController:navigationController];
    }
}

//返回至添加图片界面，进行重新赋值
- (void)upDataCollection {
    if (_dataSource.count > 0) {
        [_dataSource removeAllObjects];
        [self.uploadPicturesMutableArray removeAllObjects];
    }
    
    NSMutableArray *photoesArray = [_selectImageDictionary objectForKey:@"photoArray"];
    for (int i = 0; i < photoesArray.count; i++) {
        [_dataSource addObject:[photoesArray[i] objectForKey:@"photoAsset"]];
    }
    //为上传数组赋值
    if (!_uploadPicturesMutableArray) {
        self.uploadPicturesMutableArray = [[NSMutableArray alloc] init];
    }
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.synchronous = NO;
    requestOptions.networkAccessAllowed = NO;
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    for (int i = 0; i < _dataSource.count; i++) {
        [[PHImageManager defaultManager] requestImageForAsset:_dataSource[i] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                [self.uploadPicturesMutableArray addObject:result];
            }
        }];
    }
    
    [_picturesCollectionView reloadData];
}
@end
