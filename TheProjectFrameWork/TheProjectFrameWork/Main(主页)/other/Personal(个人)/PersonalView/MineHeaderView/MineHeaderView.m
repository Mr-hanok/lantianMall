//
//  MineHeaderView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor groupTableViewBackgroundColor] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 1);
    CGContextAddLineToPoint(ctx, rect.size.width, 1);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, 0, rect.size.height-1);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height-1);
    CGContextStrokePath(ctx);
}
@end
