//
//  RegisterTextField.m
//  test
//
//  Created by TheMacBook on 16/6/24.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "RegisterTextField.h"
#import "CaptchaView.h"

@interface RegisterTextField ()<UITextFieldDelegate,CaptchaViewDelegate>

@end

@implementation RegisterTextField
- (instancetype)initWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
{
    self = [super init];
    if(self)
    {
      
        _label.text = [LaguageControl languageWithString:text];
        _textField.placeholder = [LaguageControl languageWithString:placeholder];
        _text = [LaguageControl languageWithString:text];
        __weak typeof(self) weakSelf = self;

        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.mas_width).multipliedBy(0.02f);
        }];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithString:@"#e6e6e6"].CGColor;
    }
    return self;
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder
                           isVerify:(BOOL)isVerify
{
    self = [super init];
    if(self)
    {
        _textField.placeholder = [LaguageControl languageWithString:placeholder];
        if(isVerify) [self captchaView];
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithString:@"#e6e6e6"].CGColor;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self) return nil;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor whiteColor];
    _label = [UILabel new];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    _textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.font = _label.font;
    [self addSubview:_textField];
    [self addSubview:_label];
    __weak typeof(self) weakSelf = self;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).offset(10).priority(1000);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(weakSelf);
        make.left.equalTo(_label.mas_right).offset(8);
        make.width.greaterThanOrEqualTo(weakSelf.mas_width).multipliedBy(0.5f);

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

- (void)justifiedAlignment
{
    if(!([LaguageControl shareControl].type == LanguageTypesChinese))
    {
        return;
    }
    [self layoutIfNeeded];
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:_label.text];
    
    //计算文字大小，参数一定要符合相应的字体和大小
    CGSize attributeSize = [attributeString.string sizeWithAttributes:@{NSFontAttributeName:_label.font}];
    
    //计算字符间隔
    CGSize frame = _label.frame.size;
    NSNumber *wordSpace = [NSNumber numberWithInt:(frame.width-attributeSize.width)/(attributeString.length-1)];
    
    //添加属性
    [attributeString addAttribute:NSKernAttributeName value:wordSpace range:NSMakeRange(0, attributeString.length)];
    _label.lineBreakMode = NSLineBreakByClipping;
    _label.attributedText = attributeString;
}
- (void)removeTextString
{
    _text = nil;
    _textField.text = nil;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldchangeValue) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_delegate respondsToSelector:@selector(didEndEditTextString:textField:)]) {
        
        [_delegate didEndEditTextString:textField.text textField:self];
    }
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
    _title = [LaguageControl languageWithString:title];
    _label.text = [LaguageControl languageWithString:title];
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [LaguageControl languageWithString:placeholder];
    _textField.placeholder = [LaguageControl languageWithString:placeholder];
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

@interface SelectePhoneTextField ()<UITextFieldDelegate>

@end
@implementation SelectePhoneTextField
{
    SelectAreaButton * areaCode;
    UITextField * phoneTextField;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        areaCode = [SelectAreaButton buttonWithType:UIButtonTypeCustom];
        phoneTextField = [[UITextField alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:areaCode];
        [self addSubview:phoneTextField];
        __weak typeof(self) weakSelf = self;
        [areaCode mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.f);
            make.width.mas_equalTo(8);
            make.top.left.bottom.equalTo(weakSelf);
        }];
        [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.top.equalTo(weakSelf);
            make.left.equalTo(areaCode.mas_right);
        }];
        areaCode.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        [areaCode setTitleColor:[UIColor colorWithString:@"#666666"] forState:UIControlStateNormal];
        phoneTextField.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
//        [areaCode setImage:[UIImage imageNamed:@"xialajiantou"] forState:UIControlStateNormal];
//        [areaCode addTarget:self action:@selector(changeAreaCodeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super init];
    phoneTextField.placeholder = LaguageControl(placeholder);
    phoneTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    phoneTextField.delegate = self;
    [areaCode setTitle:title forState:UIControlStateNormal];
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithString:@"#e6e6e6"].CGColor;
    
    return self;
}
- (void)chaneAreaCode:(NSString *)code
{
    [areaCode setTitle:code forState:UIControlStateNormal];
}
- (void)changeAreaCodeWithButton:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(selectPhoneChangeArea:)])
    {
        [_delegate selectPhoneChangeArea:self];
    }
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
    if([_delegate respondsToSelector:@selector(selectPhoneTextChange:)])
    {
        [_delegate selectPhoneTextChange:self];
    }
}
- (NSString *)phone
{
    return phoneTextField.text;
}
- (NSString *)areaPhoneCode
{
//    _areaPhoneCode = [areaCode.currentTitle stringByReplacingOccurrencesOfString:@"+" withString:@""];
    return areaCode.currentTitle;
}
@end

@implementation SelectAreaButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return (CGRect){contentRect.size.width * 0.15f,contentRect.size.height * 0.4f,contentRect.size.width * 0.15,contentRect.size.height * 0.2f};
}

@end
