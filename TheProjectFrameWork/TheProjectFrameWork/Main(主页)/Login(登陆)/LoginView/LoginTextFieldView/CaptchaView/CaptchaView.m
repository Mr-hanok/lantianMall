//
//  CaptchaView.m
//  test
//
//  Created by TheMacBook on 16/6/21.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "CaptchaView.h"
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define kLineCount 5

@interface CaptchaView ()
{
    NSMutableString * _authCodeStr;
    NSArray * _dataArray;
}
@end


@implementation CaptchaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 1.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _dataArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"j",@"k",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
//        _dataArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];


        [self getAuthcode];//获得随机验证码
    }
    return self;
}
- (instancetype)initWithColor:(UIColor *)color{
    self = [super init];
    if(!self) return nil;
    
    self.backgroundColor = color;
    
    return self;
}
/**
 *  更新随机验证码
 */
- (void)getAuthcode
{
    _authCodeStr = [[NSMutableString alloc] initWithCapacity:kLineCount];
    for (NSInteger i = 0 ;  i < kLineCount ; i ++)
    {
        NSInteger index = arc4random() % (_dataArray.count-1);
        NSString * tempStr = _dataArray[index];
        _authCodeStr = (NSMutableString *)[_authCodeStr stringByAppendingString:tempStr];
    }
   
}
- (void)refresh
{
    [self getAuthcode];
    // 调用该方法间接调用drawRect:
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self getAuthcode];
    // 调用该方法间接调用drawRect:
    [self setNeedsDisplay];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    
    //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    NSString * captchaStr = [NSString stringWithFormat:@"%@", _authCodeStr];
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(15)]}];
    
    CGPoint point;
    //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    float pX,pY;
    for ( int i = 0; i<captchaStr.length; i++)
    {

        pY = CGRectGetMidY(rect)-(cSize.height/2);
        pX = rect.size.width*0.8f/captchaStr.length * i;
        point = CGPointMake(pX+rect.size.width*0.1f, pY);
        unichar c = [captchaStr characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(15)],NSForegroundColorAttributeName:kNavigationColor}];
    }
  
    CGContextSetLineWidth(context, 1);
    
    if([self.delegate respondsToSelector:@selector(currentCaptcha:)])
    {
        [self.delegate currentCaptcha:_authCodeStr];
    }
}


@end
