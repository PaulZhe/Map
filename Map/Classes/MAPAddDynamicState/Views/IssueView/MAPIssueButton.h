//
//  MAPIssueButton.h
//  Map
//
//  Created by 涂强尧 on 2019/1/31.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const float issueButtonWidth;
extern const float issueButtonHeight;

NS_ASSUME_NONNULL_BEGIN

@interface MAPIssueButton : UIButton

+ (instancetype) buttonWithTitle:(NSString *)title image:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
