//
//  MAPDynamicStateView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/22.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPDynamicStateView.h"
#import "MAPDynamicStateTableViewCell.h"

@implementation MAPDynamicStateView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _dyanmicStateTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _dyanmicStateTableView.dataSource = self;
        [self addSubview:_dyanmicStateTableView];
        [_dyanmicStateTableView registerClass:[MAPDynamicStateTableViewCell class] forCellReuseIdentifier:@"motion"];
    }
    return self;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAPDynamicStateTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    MAPDynamicStateTableViewCell *picturesCell = [tableView dequeueReusableCellWithIdentifier:@"pictures"];
    MAPDynamicStateTableViewCell *voiceCell = [tableView dequeueReusableCellWithIdentifier:@"voice"];
    MAPDynamicStateTableViewCell *vedioCell = [tableView dequeueReusableCellWithIdentifier:@"vedio"];
    if ([_typeMotiveString isEqualToString:@"1"]) {
        if (commentCell == nil) {
            commentCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment" typeOfMotion:_typeMotiveString];
        }
        commentCell.nameLabel.text = @"1111";
        commentCell.contentLabel.text = @"22222";
        commentCell.timeLabel.text = @"2019";
        return commentCell;
    } else if ([_typeMotiveString isEqualToString:@"2"]) {
        if (picturesCell == nil) {
            picturesCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pictures" typeOfMotion:_typeMotiveString];
        }
        picturesCell.nameLabel.text = @"1111";
        picturesCell.timeLabel.text = @"2019";
        _picturesView = [[MAPMotivePicturesView alloc] init];
        _picturesView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 80, 100);
        [picturesCell.picturesView addSubview:_picturesView];
        return picturesCell;
    } else if ([_typeMotiveString isEqualToString:@"3"]) {
        if (voiceCell == nil) {
            voiceCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"voice" typeOfMotion:_typeMotiveString];
        }
        return voiceCell;
    } else {
        if (vedioCell == nil) {
            vedioCell = [[MAPDynamicStateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vedio" typeOfMotion:_typeMotiveString];
        }
        return vedioCell;
    }
}

@end
