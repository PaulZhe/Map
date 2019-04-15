//
//  BMKAnnotationView+MAPAnnotationView.m
//  Map
//
//  Created by 小哲的DELL on 2019/4/15.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import "BMKAnnotationView+MAPAnnotationView.h"

@implementation BMKAnnotationView (MAPAnnotationView)
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //    if (self.selected == selected) {
    //        return;
    //    }
    if (selected){
        if (self.paopaoView == nil){
            //自定义泡泡
            self.paopaoView = [[BMKActionPaopaoView alloc] initWithFrame:CGRectMake(0, 0, 195, 132.5)];
            self.paopaoView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x + 37, -CGRectGetHeight(self.paopaoView.bounds) / 2.f + self.calloutOffset.y + 40);
        }
        [self addSubview:self.paopaoView];
    }
    else {
        [self.paopaoView removeFromSuperview];
    }
}
@end
