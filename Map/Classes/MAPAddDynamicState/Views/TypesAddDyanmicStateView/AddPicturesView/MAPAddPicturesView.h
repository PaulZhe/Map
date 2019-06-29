//
//  MAPAddPicturesView.h
//  Map
//
//  Created by 涂强尧 on 2019/2/3.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MAPAddPicturesViewDelegate <NSObject>
//键盘的弹出与消失
- (void)keyboardWillAppearOrWillDisappear:(NSString *) appearOrDisappearString AndKeykeyboardHeight:(CGFloat) keyboardHeight;
//跳转到相册界面
- (void)getToPhotoAlbumViewAndViewController:(UINavigationController *)navigationController;
@end

@interface MAPAddPicturesView : UIView <UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UILabel *hintLabel;//提示添加标题
@property (nonatomic, strong) UITextField *addTitleTextField;//添加标题输入框
@property (nonatomic, strong) UILabel *countLabel;//输入框字数限制
@property (nonatomic, strong) UIView *addPicturesView;//添加图片
@property (nonatomic, strong) UICollectionView *picturesCollectionView;//九宫格显示图片
@property (nonatomic, weak) id<MAPAddPicturesViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *uploadPicturesMutableArray;

@end

NS_ASSUME_NONNULL_END
