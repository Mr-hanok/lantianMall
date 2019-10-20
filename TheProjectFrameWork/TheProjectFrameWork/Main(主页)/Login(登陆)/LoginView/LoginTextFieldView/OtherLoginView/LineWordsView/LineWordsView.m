//
//  LineWordsView.m
//  test
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "LineWordsView.h"
@interface LineWordsView ()
{
    NSString * _text;
}
@end
@implementation LineWordsView
- (instancetype)initWithWords:(NSString *)text
{
    self = [super init];
    if (self) {
        _text = text;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(14)],NSForegroundColorAttributeName:[UIColor colorWithString:@"#616161"]};
    // 文字尺寸
    CGSize cSize = [_text sizeWithAttributes:dic];
    CGFloat wordsStartX = (rect.size.width - cSize.width) / 2;
    CGFloat wordsEndX = rect.size.width - wordsStartX;
    
    [[UIColor grayColor] setStroke];
    CGContextMoveToPoint(ctx, 0, rect.size.height/2);
    
    CGContextAddLineToPoint(ctx, wordsStartX-5, rect.size.height/2);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, wordsEndX+5, rect.size.height/2);
    
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height/2);
    CGContextStrokePath(ctx);
    [_text drawInRect:CGRectMake(wordsStartX, (rect.size.height-cSize.height)/2, cSize.width, cSize.height) withAttributes:dic];
    
}
@end
