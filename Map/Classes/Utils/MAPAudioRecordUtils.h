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
@property (nonatomic, strong) AVAudioRecorder *record;

- (void)startClick;
- (void)endClick;
@end
