//
//  MAPAudioRecordUtils.h
//  Map
//
//  Created by 小哲的DELL on 2019/4/15.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MAPAudioRecordUtils : NSObject
@property (nonatomic, copy) NSString *cafPath;
@property (nonatomic, copy) NSString *mp3Path;
@property (nonatomic, strong) AVAudioRecorder *record;
@property (nonatomic, assign) BOOL jumpFlag;

- (void)startClick;
- (void)endClick;
@end
