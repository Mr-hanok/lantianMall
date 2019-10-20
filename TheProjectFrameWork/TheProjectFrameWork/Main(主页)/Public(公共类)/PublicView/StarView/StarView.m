//
//  StarView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "StarView.h"

@implementation StarView

#define Max_statr 5

#define StarWidth 15

#define StarHeight 15

#define MinWidth 5

/** 绘制 */
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!self.minwidth) {
        self.minwidth = MinWidth;
    }
    if (!self.width) {
        self.width = StarWidth;
    }
    float height = StarHeight;
    if (self.height) {
        height = self.height;
    }
    for (int i = 0; i<Max_statr; i++) {
        [self.backImage drawInRect:CGRectMake(5+(self.minwidth+self.width)*i, 0,self.width, height)];
    }
    if (self.isShow)
    {
        NSInteger m = self.show_star;
        NSString * showString = [NSString stringWithFormat:@"(%ld)",(long)m];
        UIFont  *font = [UIFont boldSystemFontOfSize:13.0];//定义默认字体
        NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment=NSTextAlignmentLeft;//文
        NSDictionary* attribute = @{
                                    NSForegroundColorAttributeName:[UIColor lightGrayColor],//设置文字颜色
                                    NSFontAttributeName:font,//设置文字的字体
                                    NSKernAttributeName:@1,//文字之间的字距
                                    NSParagraphStyleAttributeName:paragraphStyle,//设置文字的样式
                                    };
        [showString drawInRect:CGRectMake(self.minwidth+5+(self.minwidth+self.width)*5, 0,self.frame.size.width-(self.minwidth+5+(self.minwidth+self.width)*5), height) withAttributes:attribute];
    }
    if (self.show_star<Max_statr){
        
        CGContextClipToRect(context,CGRectMake(0, 0, 5+(self.minwidth+self.width)*self.show_star, height));
    }
    for (float i = 0; i<MIN(self.show_star, Max_statr); i++){
        [self.fullImage drawInRect:CGRectMake(5+(self.minwidth+self.width)*i, 0, self.width,height)];
    }
}
-(void)Setwidtt:(CGFloat)width minWidth:(CGFloat)minWidth showStar:(float)showStar
{
    self.width = width;
    self.minwidth = minWidth;
    self.show_star = showStar;
    [self setNeedsDisplay];
}
-(void)Setwidtt:(CGFloat)width minWidth:(CGFloat)minWidth with:(NSString*)creditView
{
    NSArray * array = [creditView componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    NSString * string = [NSString stringWithFormat:@"level_%@",[array firstObject]];
    self.fullImage = [UIImage imageNamed:string];
    self.width = width;
    self.minwidth = minWidth;
    self.show_star = [[array lastObject] floatValue];
    [self setNeedsDisplay];

    
}


/** 获取评分值 */
-(void)GetValues:(StarViewSetValueBlock)block
{
    self.block = block;
}

/** 触摸开始 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.canSelected)
    {//可以选择
        //获取触摸位置
     CGPoint pt = [[touches anyObject] locationInView:self];
        self.show_star = (pt.x-5)/(self.width+self.minwidth);
     NSInteger tmp = self.show_star;
     CGFloat stars = self.show_star-tmp;
     self.show_star = tmp+stars *(self.width+self.minwidth)/self.width;
        if ([self respondsToSelector:@selector(GetValues:)]) {
            if (self.block) {
                self.block(MIN(self.show_star, Max_statr));
            }
        }
        //重新绘制
        [self setNeedsDisplay];
    }
}

/** 移动 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.canSelected)
    {//可以选择
        //获取触摸位置
    CGPoint pt = [[touches anyObject] locationInView:self];
    self.show_star = (pt.x-5)/(self.width+self.minwidth);
    NSInteger tmp = self.show_star;
    float stars = self.show_star-tmp;
    self.show_star = tmp+stars *(self.width+self.minwidth)/self.width;        if ([self respondsToSelector:@selector(GetValues:)]) {
            if (self.block) {
                self.block(MIN(self.show_star, Max_statr));
            }
        }
        //重新绘制
        [self setNeedsDisplay];
    }
}
@end
