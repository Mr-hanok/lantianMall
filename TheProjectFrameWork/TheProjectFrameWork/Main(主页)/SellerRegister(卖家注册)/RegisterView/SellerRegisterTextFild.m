//
//  SellerRegisterTextFild.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SellerRegisterTextFild.h"
#import "CaptchaView.h"

@interface SellerRegisterTextFild ()<UITextFieldDelegate,CaptchaViewDelegate>
{
    UILabel * _label;
    UITextField * _textField;
    UIView * _line;
    NSString * _securityCode;
    MASConstraint * width;
}
@end

@implementation SellerRegisterTextFild
- (instancetype)initWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
{
    self = [super init];
    if(self)
    {
        
        _label.text = text;
        _textField.placeholder = placeholder;
        _text = text;
        width.mas_equalTo([text sizeWithAttributes:@{NSFontAttributeName:_label.font}].width);
        self.backgroundColor = [UIColor whiteColor];
//        self.layer.cornerRadius = 3;
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = [UIColor colorWithString:@"#e6e6e6"].CGColor;
    }
    return self;
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder
                           isVerify:(BOOL)isVerify
{
    self = [super init];
    if(self)
    {
        _textField.placeholder = placeholder;
        if(isVerify) [self captchaView];
//        self.layer.cornerRadius = 3;
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = [UIColor colorWithString:@"#e6e6e6"].CGColor;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self) return nil;
    self.backgroundColor = [UIColor whiteColor];
    
    _label = [UILabel new];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14];
    _textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.font = _label.font;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_textField];
    [self addSubview:_label];
    __weak typeof(self) weakSelf = self;
    _label.lineBreakMode = NSLineBreakByClipping;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).offset(10).priority(1000);
        width = make.width.mas_equalTo(0);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(weakSelf);
        make.left.equalTo(_label.mas_right).offset(8);
        make.width.greaterThanOrEqualTo(weakSelf.mas_width).multipliedBy(0.5f);
        
    }];
    
    _line = [[UIView alloc]init];
    _line.backgroundColor =[UIColor colorWithString:@"#e6e6e6"];
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(.5);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    return self;
}
- (void)loadWithText:(NSString *)text placeholder:(NSString *)placeholder
{
    _textField.placeholder = placeholder;
    _label.text = text;
    _text = text;
}
#pragma mark - private
/**
 *  创建验证码视图
 */
- (void)captchaView
{
    CaptchaView * captcha = [[CaptchaView alloc] initWithColor:[UIColor whiteColor]];
    UIView * line = [UIView new];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    captcha.delegate = self;
    [self addSubview:captcha];
    [self addSubview:line];
    
    __weak typeof(self) weakSelf = self;
    [captcha mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).mas_offset(5).priority(900);
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-5).priority(900);
        make.right.equalTo(weakSelf.mas_right);
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.2f);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@1);
        make.top.equalTo(weakSelf.mas_top).mas_offset(5).priority(900);
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-5).priority(900);
        make.right.equalTo(captcha.mas_left);
    }];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldchangeValue) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  根据UITextFieldDelegate 以及通知实现监听
 */
- (void)textFieldchangeValue
{
    self.text = _textField.text;
    if([self.delegate respondsToSelector:@selector(verificationCode:)] && self.delegate && _securityCode)
    {
        BOOL result = ![_securityCode compare:self.text options:NSCaseInsensitiveSearch];
        [self.delegate verificationCode:result];
    }
    if([self.delegate respondsToSelector:@selector(currentTextString:textField:)] && self.delegate && !_securityCode)
    {
        [self.delegate currentTextString:self.text textField:self];
    }
}

#pragma mark - CaptchaViewDelegate
- (void)currentCaptcha:(NSString *)captchaStr
{
    _securityCode = captchaStr;
}

#pragma mark - setter Method
- (void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = title;
    width.mas_equalTo([title sizeWithAttributes:@{NSFontAttributeName:_label.font}].width);
    
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
}
- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    _textField.secureTextEntry = secureTextEntry;
}
- (void)setSideline:(BOOL)sideline
{
    _sideline = sideline;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    if(!_sideline) return;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc"]setStroke];
    CGContextSetLineWidth(ctx, .5f);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextStrokePath(ctx);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end
