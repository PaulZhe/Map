//
//  MAPIssueAudioView.h
//  Map
//
//  Created by 小哲的DELL on 2019/5/9.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPMotiveAudioButton.h"
#import "MAPAudioRecordUtils.h"

@interface MAPIssueAudioView : UIView

@property (nonatomic, strong) MAPMotiveAudioButton *motiveAudioButton;
@property (nonatomic, assign) int seconds;
@property (nonatomic, assign) int minutes;
@property (nonatomic, strong) MAPAudioRecordUtils *audioRecordUtils;

@end
