//
//  MAPLocationTableViewCell.m
//  Map
//
//  Created by _祀梦 on 2019/4/2.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPLocationTableViewCell.h"
#import <Masonry.h>

@implementation MAPLocationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _locationTextField = [[UITextField alloc] init];
        _locationTextField.backgroundColor = [UIColor colorWithRed:0.99f green:0.90f blue:0.89f alpha:1.00f];
        _locationTextField.borderStyle = UITextBorderStyleNone;
        _locationTextField.font = [UIFont systemFontOfSize:16];
        _locationTextField.delegate = self;
        //设置左边空格量
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
        leftView.backgroundColor = [UIColor clearColor];
        _locationTextField.leftView = leftView;
        _locationTextField.leftViewMode = UITextFieldViewModeAlways;
        _locationTextField.keyboardType = UIKeyboardTypeDefault;
        _locationTextField.returnKeyType = UIReturnKeyDefault;
        [self.contentView addSubview:_locationTextField];
        [_locationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        NSLog(@"location = %@", _locationTextField.text);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
