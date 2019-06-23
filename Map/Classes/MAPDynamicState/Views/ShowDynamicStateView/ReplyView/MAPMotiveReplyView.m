//
//  MAPMotiveReplyView.m
//  Map
//
//  Created by 涂强尧 on 2019/2/11.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPMotiveReplyView.h"
#import <Masonry.h>
#import "MAPReplyTableViewCell.h"

@interface MAPMotiveReplyView()
@property (nonatomic, strong) NSMutableArray *replyMutableArray;
@property (nonatomic, assign) int flag;
@end

@implementation MAPMotiveReplyView

- (instancetype) init {
    self = [super init];
    if (self) {
        self.replyMutableArray = [[NSMutableArray alloc] initWithObjects:@"我爱丽丽：那里最漂亮呢？", @"李四：对啊！确实很美呢！", @"小李：真美", @"小王：真的很美！", @"小哲：的确很美！", nil];
        self.flag = 0;
//        self.replyLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 80, 30)];
//        self.replyLable1.textColor = [UIColor blackColor];
//        self.replyLable1.text = @"我爱丽丽：那里最漂亮呢？";
//        self.replyLable1.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.replyLable1];
//
//        self.replyLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width - 80, 30)];
//        self.replyLable2.text =  @"李四：对啊！确实很美呢！";
//        self.replyLable2.textColor = [UIColor blackColor];
//        self.replyLable2.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.replyLable2];
//
//        self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 75, 100, 30)];
//        [self.moreButton setTitle:@"更多回复 >" forState:UIControlStateNormal];
//        self.moreButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//        [self.moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [self.moreButton addTarget:self action:@selector(clickedMoreButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.moreButton];
        
        
        self.backgroundColor = [UIColor whiteColor];
        self.replyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.replyTableView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
        self.replyTableView.delegate = self;
        self.replyTableView.dataSource = self;
        [self addSubview:self.replyTableView];
        [self.replyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self.replyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.replyTableView.showsVerticalScrollIndicator = NO;
//        self.replyTableView.allowsSelection = NO;
        [self.replyTableView registerClass:[MAPReplyTableViewCell class] forCellReuseIdentifier:@"reply"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.flag == 0) {
        return 3;
    }else {
        return self.replyMutableArray.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAPReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reply" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    cell.replyLabel.text = self.replyMutableArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

//- (void)clickedMoreButton:(UIButton *)button {
//
//}
@end
