//
//  MAPLocationTableViewCell.h
//  Map
//
//  Created by _祀梦 on 2019/4/2.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPLocationTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *locationTextField;
@end

NS_ASSUME_NONNULL_END
