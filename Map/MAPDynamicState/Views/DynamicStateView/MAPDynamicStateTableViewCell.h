//
//  MAPDynamicStateTableViewCell.h
//  Map
//
//  Created by 涂强尧 on 2019/1/26.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPMotivePicturesView.h"
#import "MAPMotiveAudioButton.h"
#import "MAPMotiveVideoButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPDynamicStateTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) UIView *picturesView;//九宫格显示图片
@property (nonatomic, strong) MAPMotiveAudioButton *audioButton;//播放语音
@property (nonatomic, strong) MAPMotiveVideoButton *videoButton;//播放视频

//重写init方法，实现cell的封装
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeOfMotion:(nonnull NSString *)typeString;

@end

NS_ASSUME_NONNULL_END
