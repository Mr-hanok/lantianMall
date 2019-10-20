//
//  IconLayer.m
//  test
//
//  Created by TheMacBook on 16/6/23.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "IconLayer.h"

@interface IconLayer ()

@end

@implementation IconLayer
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if(self)
    {
        _image = image;
        self.delegate = self;
        [self setNeedsDisplay];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.delegate = self;
        [self setNeedsDisplay];
    }
    return self;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
    layer.anchorPoint = CGPointMake(0.0, 0.0);
    layer.cornerRadius = layer.bounds.size.height/2;
    layer.borderWidth = 2;
    layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    layer.masksToBounds = YES;
    layer.position = layer.bounds.origin;
    CGContextSaveGState(ctx);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -layer.bounds.size.height);
//    cgcontex
    CGContextDrawImage(ctx, CGRectMake(layer.bounds.origin.x, -layer.bounds.origin.y, layer.bounds.size.width, layer.bounds.size.height), _image.CGImage);
    
    CGContextRestoreGState(ctx);

    
}
@end
