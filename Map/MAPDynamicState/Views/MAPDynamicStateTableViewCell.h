//
//  MAPDynamicStateTableViewCell.h
//  Map
//
//  Created by 涂强尧 on 2019/1/22.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPDynamicStateTableViewCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UILabel *nameLabel; //名称
@property (nonatomic, strong) UIImageView *headImageView; //头像
@property (nonatomic, strong) UILabel *contentLabel; //文字内容
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) UILabel *timeLabel; //时间
@property (nonatomic, strong) UIButton *likeButton; //点赞
@property (nonatomic, strong) UIButton *commentButton; //评论

//九宫格显示图片
@property (nonatomic, strong) UIView *picturesView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeOfMotion:(NSString *)typeString;

@end

NS_ASSUME_NONNULL_END
