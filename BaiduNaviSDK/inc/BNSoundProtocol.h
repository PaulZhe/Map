//
//  BNSoundProtocol.h
//  BNOpenKit
//
//  Created by linbiao on 2019/3/19.
//  Copyright © 2019年 Chen,Xintao. All rights reserved.
//

#ifndef BNSoundProtocol_h
#define BNSoundProtocol_h

#import <Foundation/Foundation.h>
#import "BNCommonDef.h"

@protocol BNNaviSoundDelegate <NSObject>

/**
 *  TTS文本回调
 */
- (void)onPlayTTS:(NSString*)text;

/**
 *  TTS音效回调
 *  @param type 音效类型
 *  @param filePath 音频文件路径
 */
- (void)onPlayVoiceSound:(BNVoiceSoundType)type filePath:(NSString *)filePath;

/**
 *  播报或进入导航的时候都会检测TTS是否鉴权成功
 *  (1)如果还没鉴权成功，会尝试先鉴权，然后回调鉴权结果，
 *  (2)如果已经鉴权成功，也会回调鉴权成功
 */
- (void)onTTSAuthorized:(BOOL)success;

@end


@protocol BNSoundProtocol <NSObject>

/**
 *  是否正在播报
 *  @return 是否正在播报
 */
- (BOOL)isTTSPlaying;

/**
 *  暂停播报
 */
- (BOOL)pause;

/**
 *  恢复播报
 */
- (BOOL)resume;

/**
 *   播报文本，使用内部TTS播报时有效
 *   @param text : 需要播报的文本
 */
- (BOOL)playText:(NSString *)text;

/**
 *  设置导航播报的delegate
 */
- (void)setSoundDelegate:(id<BNNaviSoundDelegate>)delegate;

@end

#endif /* BNSoundProtocol_h */
