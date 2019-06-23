//
//  MAPReplyTableViewCell.m
//  Map
//
//  Created by _祀梦 on 2019/6/23.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPReplyTableViewCell.h"
#import <Masonry.h>

@implementation MAPReplyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.replyLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.replyLabel];
        self.replyLabel.textAlignment = NSTextAlignmentLeft;
        self.replyLabel.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
        [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(30);
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
