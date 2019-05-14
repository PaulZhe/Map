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
        //设置左边标签
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textColor = [UIColor colorWithRed:0.95f green:0.35f blue:0.35f alpha:1.00f];
        _leftLabel.backgroundColor = [UIColor colorWithRed:0.99f green:0.90f blue:0.89f alpha:1.00f];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.left.mas_equalTo(self.mas_left);
        }];
        
        _cityTextField = [[UITextField alloc] init];
        _cityTextField.backgroundColor = [UIColor colorWithRed:0.99f green:0.90f blue:0.89f alpha:1.00f];
        _cityTextField.borderStyle = UITextBorderStyleNone;
        _cityTextField.font = [UIFont systemFontOfSize:16];
        _cityTextField.delegate = self;
        UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
        _cityTextField.leftView = cityLabel;
        _cityTextField.leftViewMode = UITextFieldViewModeAlways;
        _cityTextField.keyboardType = UIKeyboardTypeDefault;
        _cityTextField.returnKeyType = UIReturnKeyDefault;
        _cityTextField.placeholder = @"输入城市";
        [self.contentView addSubview:_cityTextField];
        [_cityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.leftLabel.mas_right).mas_offset(2);
            make.size.mas_equalTo(CGSizeMake(80, 50));
        }];
        
        _locationTextField = [[UITextField alloc] init];
        _locationTextField.backgroundColor = [UIColor colorWithRed:0.99f green:0.90f blue:0.89f alpha:1.00f];
        _locationTextField.borderStyle = UITextBorderStyleNone;
        _locationTextField.font = [UIFont systemFontOfSize:16];
        _locationTextField.delegate = self;
        UILabel *loactionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _locationTextField.leftView = loactionLabel;
        _locationTextField.leftViewMode = UITextFieldViewModeAlways;
        _locationTextField.keyboardType = UIKeyboardTypeDefault;
        _locationTextField.returnKeyType = UIReturnKeyDefault;
        _locationTextField.placeholder = @"输入关键字";
        [self.contentView addSubview:_locationTextField];
        [_locationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.right.mas_equalTo(self.mas_right);
            make.left.mas_equalTo(self.cityTextField.mas_right).mas_offset(2);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
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
