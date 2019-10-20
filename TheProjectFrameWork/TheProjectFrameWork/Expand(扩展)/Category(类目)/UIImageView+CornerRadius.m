//
//  UIImageView+CornerRadius.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/8/30.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "UIImageView+CornerRadius.h"

@implementation UIImageView (CornerRadius)
- (UIImageView *)roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius{
    
    UIBezierPath *bezierPath =[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    self.layer.mask = layer;
    return self;
}
@end
