//
//  MAPDynamicStateTableViewCell.m
//  Map
//
//  Created by 涂强尧 on 2019/1/22.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPDynamicStateTableViewCell.h"
#import <Masonry.h>

@implementation MAPDynamicStateTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeOfMotion:(nonnull NSString *)typeString{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(65);
            make.size.mas_equalTo(CGSizeMake(300, 20));
        }];
        
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds=YES;
        _headImageView.layer.cornerRadius = 22.5;
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        _contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:18];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45);
            make.left.mas_equalTo(65);
            make.right.mas_equalTo(-15);
        }];
        
        if ([typeString isEqualToString:@"1"]) {
            //这里是回复
            _replyLabel = [[UILabel alloc] init];
            [self.contentView addSubview:_replyLabel];
            _replyLabel.font = [UIFont systemFontOfSize:18];
            _replyLabel.numberOfLines = 0;
            _replyLabel.textColor = [UIColor grayColor];
            [_replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(65);
                make.right.mas_equalTo(-15);
            }];
        } else if ([typeString isEqualToString:@"2"]) {
            //这里是图片
            _picturesView = [[UIView alloc] init];
            [self.contentView addSubview:_picturesView];
            [_picturesView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(65);
                make.right.mas_equalTo(-15);
            }];
        } else if ([typeString isEqualToString:@"3"]) {
            //这里是语音
            _audioButton = [[MAPMotiveAudioButton alloc] init];
            [self.contentView addSubview:_audioButton];
            [_audioButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(65);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(35.0);
            }];
        } else if ([typeString isEqualToString:@"4"]) {
            //这里是视频
            _videoButton = [[MAPMotiveVideoButton alloc] init];
            [self.contentView addSubview:_videoButton];
            [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(5);
                make.left.mas_equalTo(65);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(150.0);
            }];
            __weak typeof(self) weakSelf = self;
            [_videoButton addTapBlock:^(UIButton * _Nonnull sender) {
                [weakSelf vedioPlay];
            }];
        }
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.numberOfLines = 0;
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-10);
            make.left.mas_equalTo(65);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(100);
        }];
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [_likeButton setTitle:@"(2)" forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_likeButton];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-10);
            make.right.mas_equalTo(self->_timeLabel.mas_right).mas_equalTo(180);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setImage:[UIImage imageNamed:@"comt"] forState:UIControlStateNormal];
        [_commentButton setTitle:@"(2)" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_commentButton];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-10);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
    }
    return self;
}

//播放视频
- (void) vedioPlay {
    NSLog(@"点击了视频");
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

