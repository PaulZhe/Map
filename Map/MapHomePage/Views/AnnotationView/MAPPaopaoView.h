//
//  MAPPaopaoView.h
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPPaopaoButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAPPaopaoView : UIView
@property (nonatomic, strong) MAPPaopaoButton *commentButton;
@property (nonatomic, strong) MAPPaopaoButton *picturesButton;
@property (nonatomic, strong) MAPPaopaoButton *voiceButton;
@property (nonatomic, strong) MAPPaopaoButton *vedioButton;
@property (nonatomic, strong) UILabel *title;
@end

NS_ASSUME_NONNULL_END
