//
//  MAPDynamicStateView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/22.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPMotivePicturesView.h"
#import "AVFoundation/AVFoundation.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PlayerStatus) {
    None,
    End,
    Play,
    Pause
};

@interface MAPDynamicStateView : UIView <UITableViewDataSource>
@property (nonatomic, strong) UITableView *dyanmicStateTableView;
@property (nonatomic, strong) NSString *typeMotiveString; //按钮点击类别
@property (nonatomic, strong) MAPMotivePicturesView *picturesView;

@property (nonatomic, strong) AVPlayer *audioPlayer;//播放音频,支持播放在线音乐
@property (nonatomic, assign) PlayerStatus playerStatue;//标记语音
@end

NS_ASSUME_NONNULL_END
