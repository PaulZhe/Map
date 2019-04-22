
//  MAPAudioRecordUtils.m
//  Map
//
//  Created by 小哲的DELL on 2019/4/15.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "MAPAudioRecordUtils.h"
#import "MAPLameTool.h"

@implementation MAPAudioRecordUtils

-(AVAudioRecorder *)record {
    if (!_record) {
         self.cafPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"text.caf"];
        // url : 录音文件的路径 (path是沙盒路径)
        NSURL *url = [NSURL URLWithString:_cafPath];
        NSLog(@"%@", _cafPath);
        // setting:录音的设置项
        NSDictionary *configDic = @{// 编码格式
                                    AVFormatIDKey:@(kAudioFormatLinearPCM),
                                    // 采样率
                                    AVSampleRateKey:@(11025.0),
                                    // 通道数
                                    AVNumberOfChannelsKey:@(2),
                                    // 录音质量
                                    AVEncoderAudioQualityKey:@(AVAudioQualityMin)
                                    };
        NSError *error = nil;
        _record = [[AVAudioRecorder alloc]initWithURL:url settings:configDic error:&error];
        if (error) {
            NSLog(@"error:%@",error);
        }
        // 准备录音(系统会给我们分配一些资源)
        [_record prepareToRecord];
    }
    return _record;
}

- (void)startClick {
    // 开始录音
    [self.record record];
    NSLog(@"开始录音");
}
- (void)endClick {
    // 根据当前的录音时间，做处理
    // 如果录音不超过1秒，则删除录音
    if (self.record.currentTime > 1) {
        [self.record stop];
        self.mp3Path = [MAPLameTool audioToMP3:_cafPath isDeleteSourchFile:YES];
        NSLog(@"%@", _mp3Path);
        self.jumpFlag = YES;
    } else {
        //如果想要删除录音文件，必须先停止录音
        [self.record stop];
        [self.record deleteRecording];
        self.jumpFlag = NO;
    }
    NSLog(@"结束录音");
}

@end
