//
//  MAPDynamicStateView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/22.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPDynamicStateView.h"
#import "MAPDynamicStateTableViewCell.h"
#import "MAPMotivePicturesView.h"
#import "AVFoundation/AVFoundation.h"
#import "MAPMotiveVideoButtonView.h"

@interface MAPDynamicStateView()

//点击播放按钮之后的界面
@property (nonatomic, strong) MAPMotiveVideoButtonView *vedioButtonView;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;//播放音频,支持播放在线音乐

@property (nonatomic, strong) AVPlayer *vedioPlayer;//视频播放器
@property (nonatomic, strong) AVPlayerItem *vedioPlayerItem;//播放元素
@property (nonatomic, strong) AVPlayerLayer *vedioPlayerLayer;//播放界面

@end

@implementation MAPDynamicStateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _dyanmicStateTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _dyanmicStateTableView.dataSource = self;
        [self addSubview:_dyanmicStateTableView];
        [_dyanmicStateTableView registerClass:[MAPDynamicStateTableViewCell class] forCellReuseIdentifier:@"motion"];
    }
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_commentModel) {
        return 3;
    }
    return _commentModel.data.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAPDynamicStateTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    MAPDynamicStateTableViewCell *picturesCell = [tableView dequeueReusableCellWithIdentifier:@"pictures"];
    MAPDynamicStateTableViewCell *voiceCell = [tableView dequeueReusableCellWithIdentifier:@"voice"];
    MAPDynamicStateTableViewCell *videoCell = [tableView dequeueReusableCellWithIdentifier:@"video"];
    if ([_typeMotiveString isEqualToString:@"1"]) {
        if (commentCell == nil) {
            commentCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment" typeOfMotion:_typeMotiveString];
        }
        //        if (!_commentModel) {
        //            commentCell.nameLabel.text = @"111111111";
        //            commentCell.contentLabel.text = @"22222222";
        //            commentCell.timeLabel.text = @"333333333";
        //        } else {
        commentCell.nameLabel.text = [NSString stringWithFormat:@"%@", [_commentModel.data[indexPath.row] username]];
        commentCell.contentLabel.text = [NSString stringWithFormat:@"%@", [_commentModel.data[indexPath.row] content]];
        commentCell.timeLabel.text = [NSString stringWithFormat:@"%@", [_commentModel.data[indexPath.row] createAt]];
        //        }
        return commentCell;
    } else if ([_typeMotiveString isEqualToString:@"2"]) {
        if (picturesCell == nil) {
            picturesCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pictures" typeOfMotion:_typeMotiveString];
        }
        picturesCell.nameLabel.text = @"1111";
        picturesCell.timeLabel.text = @"2019";
        return picturesCell;
    } else if ([_typeMotiveString isEqualToString:@"3"]) {
        if (voiceCell == nil) {
            voiceCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"voice" typeOfMotion:_typeMotiveString];
        }
        
        //添加语音点击事件
        voiceCell.audioButton.motiveAudioAction = ^(UIButton * _Nonnull sender) {
            NSLog(@"点击了语音%ld", (long)indexPath.row);
            NSString *mp3Str = [NSString stringWithFormat:@"http://haojianqiang.top%@", [self->_commentModel.data[indexPath.row] content].url];
            NSData *mp3Data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:mp3Str]];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithData:mp3Data error:nil];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        };
        return voiceCell;
    } else {
        if (videoCell == nil) {
            videoCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"video" typeOfMotion:_typeMotiveString];
        }
        //添加视频点击事件
        videoCell.videoButton.motiveVideoAction = ^(UIButton * _Nonnull sender) {
            NSLog(@"点击了视频");
            [self vedioPlay];
        };
        return videoCell;
    }
}



//播放音频
//- (void)audioPlay {
//    NSURL *audioUrl = [NSURL URLWithString:[NSString stringWithFormat:@"123"]];
//    _audioPlayer = [[AVPlayer alloc] initWithURL:audioUrl];
//    if (_playerStatue == Play) {
//        [_audioPlayer pause];
//    }
//    [_audioPlayer play];
//    _playerStatue = Play;
//}

//播放视频
- (void)vedioPlay {
    //视频播放器的Layer
    UIView *vedioView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    vedioView.backgroundColor = [UIColor lightGrayColor];
    NSURL *vedioUrl = [NSURL URLWithString:[NSString stringWithFormat:@"123"]];
    //播放元素
    _vedioPlayerItem = [[AVPlayerItem alloc] initWithURL:vedioUrl];
    //播放片添加播放对象
    _vedioPlayer = [[AVPlayer alloc] initWithPlayerItem:_vedioPlayerItem];
    //观察Status属性，可以在加载成功之后得到视频的长度
    [_vedioPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //观察loadedTimeRanges，可以获取缓存进度，实现缓冲进度条
    [_vedioPlayer.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    // 监听 videoPlayer 是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_vedioPlayerItem];
    
    _vedioPlayerLayer = [[AVPlayerLayer alloc] initWithLayer:_vedioPlayer];
    //AVLayerVideoGravityResizeAspect 等比例  默认
    _vedioPlayerLayer.videoGravity = AVVideoScalingModeResizeAspect;
    _vedioPlayerLayer.frame = vedioView.bounds;
    [vedioView.layer addSublayer:_vedioPlayerLayer];
    
    //初始化底部视图
    _vedioButtonView = [[MAPMotiveVideoButtonView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, 100)];
    [self addSubview:_vedioButtonView];
    
    //添加一个计时的标签不断更新当前的播放进度
    __weak typeof(self) weakSelf = self;
    [_vedioPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
        //当前时间
        CGFloat currentTime = weakSelf.vedioPlayerItem.currentTime.value/weakSelf.vedioPlayerItem.currentTime.timescale;
        NSLog(@"当前时间 = %f", currentTime);
        //视频总时间
        CGFloat totalTime = CMTimeGetSeconds(weakSelf.vedioPlayerItem.duration);
        NSLog(@"总时间 = %f", totalTime);
        NSString *timeString = [NSString stringWithFormat:@"%@/%@", [weakSelf formatTimeWithTime:currentTime], [weakSelf formatTimeWithTime:totalTime]];
        weakSelf.vedioButtonView.videoSlider.value = currentTime/totalTime;
        weakSelf.vedioButtonView.timeLabel.text = timeString;
    }];
}

//添加视频属性观察
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        //获取playerItem的status属性最新的状态
        switch (_vedioPlayerItem.status) {
            case AVPlayerStatusReadyToPlay:{
                //标记播放状态
                _playerStatue = Play;
                //开始播放视频
                [_vedioPlayer play];
                break;
            }
            case AVPlayerStatusFailed:{
                //视频加载失败，点击重新加载
                NSLog(@"视频加载失败，点击重新加载");
                break;
            }
            case AVPlayerStatusUnknown:{
                NSLog(@"加载遇到未知问题:AVPlayerStatusUnknown");
                break;
            }
            default:
                break;
        }
    }
}

//视频播放结束
- (void)videoPlayerDidFinished:(NSNotification *)notification {
    [_vedioPlayer pause];
}

//转换时间格式的方法
- (NSString *)formatTimeWithTime:(CGFloat) time {
    int minute = 0,  secend = 0;
    NSString *minuteString, *secendString;
    minute = time / 60;
    secend = time - minute * 60;
    if (minute < 10) {
        minuteString = [NSString stringWithFormat:@"0%d", minute];
    } else {
        minuteString = [NSString stringWithFormat:@"%d", minute];
    }
    if (secend < 10) {
        secendString = [NSString stringWithFormat:@"0%d", secend];
    } else {
        secendString = [NSString stringWithFormat:@"%d", secend];
    }
    return [NSString stringWithFormat:@"%@:%@", minuteString, secendString];
}

@end
