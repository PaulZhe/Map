//
//  MAPAnnotationView.m
//  Map
//
//  Created by 涂强尧 on 2019/1/19.
//  Copyright © 2019 小哲的DELL. All rights reserved.
//

#import "MAPAnnotationView.h"

@interface MAPAnnotationView ()
@property (nonatomic, strong, readwrite) MAPPaopaoView *paopaoView;
@end

@implementation MAPAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected == selected) {
        return;
    }
    if (selected){
        if (self.paopaoView == nil){
            //自定义泡泡
            self.paopaoView = [[MAPPaopaoView alloc] initWithFrame:CGRectMake(0, 0, 195, 132.5)];
        }
        [self addSubview:self.paopaoView];
    }
    else {
        [self.paopaoView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}

@end
