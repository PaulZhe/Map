//
//  MAPDynamicStateTableViewCell.m
//  Map
//
//  Created by 涂强尧 on 2019/1/22.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPDynamicStateTableViewCell.h"
#import <Masonry.h>

static const float kMotiveButtonFromLeft = 65.0;

@implementation MAPDynamicStateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeOfMotion:(nonnull NSString *)typeString{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(kMotiveButtonFromLeft);
            make.size.mas_equalTo(CGSizeMake(300, 20));
        }];
        
        self.headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds=YES;
        _headImageView.layer.cornerRadius = 22.5;
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:18];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45);
            make.left.mas_equalTo(kMotiveButtonFromLeft);
            make.right.mas_equalTo(-15);
        }];
        
        self.timeLabel = [[UILabel alloc] init];
        _timeLabel.numberOfLines = 0;
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-10);
            make.left.mas_equalTo(kMotiveButtonFromLeft);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(150);
        }];
        
        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setImage:[UIImage imageNamed:@"comt"] forState:UIControlStateNormal];
        [_commentButton setTitle:@"(2)" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_commentButton];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-10);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [_likeButton setTitle:@"(2)" forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_likeButton];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-10);
            make.right.mas_equalTo(self->_commentButton.mas_left).mas_equalTo(-2);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        
        if ([typeString isEqualToString:@"1"]) {
            //这里是回复
            self.replyView = [[MAPMotiveReplyView alloc] init];
            [self.contentView addSubview:_replyView];
            [_replyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(kMotiveButtonFromLeft);
                make.right.mas_equalTo(-15);
            }];
        } else if ([typeString isEqualToString:@"2"]) {
            //这里是图片
            self.picturesView = [[MAPMotivePicturesView alloc] init];
            [self.contentView addSubview:_picturesView];
            [_picturesView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(kMotiveButtonFromLeft);
                make.right.mas_equalTo(-15);
            }];
        } else if ([typeString isEqualToString:@"3"]) {
            //这里是语音
            self.audioButton = [[MAPMotiveAudioButton alloc] init];
            [self.contentView addSubview:_audioButton];
            [_audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(kMotiveButtonFromLeft);
                make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.3);
                make.height.mas_equalTo(35.0);
            }];
        } else if ([typeString isEqualToString:@"4"]) {
            //这里是视频
            self.videoButton = [[MAPMotiveVideoButton alloc] init];
            [self.contentView addSubview:_videoButton];
            [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(kMotiveButtonFromLeft);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(150.0);
            }];
        }
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

