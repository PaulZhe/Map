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
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAPDynamicStateTableViewCell *cell = nil;
    if (cell == nil) {
        cell = [_dyanmicStateTableView dequeueReusableCellWithIdentifier:@"motion" forIndexPath:indexPath];
    }
    return cell;
}

@end
