//
//  MAPMotiveReplyView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/11.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPMotiveReplyView.h"

@implementation MAPMotiveReplyView

- (instancetype) init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        self.replyLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, 30)];
        self.replyLable1.text = @"我爱丽丽：那里最漂亮呢？";
        self.replyLable1.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.replyLable1];
        
        self.replyLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, 30)];
        self.replyLable2.text =  @"李四：对啊！确实很美呢！";
        self.replyLable2.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.replyLable2];
        
        self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 75, 100, 30)];
        [self.moreButton setTitle:@"更多回复 >" forState:UIControlStateNormal];
        [self.moreButton setTintColor:[UIColor blueColor]];
        [self addSubview:self.moreButton];
    }
    return self;
}
@end
