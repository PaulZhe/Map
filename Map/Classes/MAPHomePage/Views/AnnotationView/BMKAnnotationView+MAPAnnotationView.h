//
//  BMKAnnotationView+MAPAnnotationView.h
//  Map
//
//  Created by 小哲的DELL on 2019/4/15.
//  Copyright © 2019年 小哲的DELL. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface BMKAnnotationView (MAPAnnotationView)
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)setSelected;
@end
