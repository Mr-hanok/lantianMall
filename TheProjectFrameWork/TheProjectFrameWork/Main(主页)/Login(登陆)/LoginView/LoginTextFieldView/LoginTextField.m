//
//  LoginTextField.m
//  test
//
//  Created by TheMacBook on 16/6/21.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "LoginTextField.h"
#import "CaptchaView.h"
@interface LoginTextField ()<UITextFieldDelegate,CaptchaViewDelegate>
{

    NSString * _verificationCode;
    BOOL _authCode;
}
@end

@implementation LoginTextField
{
    CaptchaView * _captcha;
}
- (instancetype)initWithText:(NSString *)text
                  placeholder:(NSString *)placeholder
            isSecureTextEntry:(BOOL)SecureTextEntry
                   isAuthCode:(BOOL)authCode
{
    self = [super init];
    if(self)
    {
        if(authCode) [self captcha];
        _textLabel.text = text;
        _textField.placeholder = placeholder;
        _textField.secureTextEntry = SecureTextEntry;
        _authCode = authCode;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        _textLabel = [UILabel new];
        _textField = [UITextField new];
        _textField.delegate = self;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textField.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(16)];
        _textField.font = _textLabel.font;
        [self addSubview:_textLabel];
        [self addSubview:_textField];
 
        __weak typeof(self) weakSelf = self;

        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.width.equalTo(weakSelf).multipliedBy(0.01f);
            make.top.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-10);
        }];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_textLabel.mas_right).mas_offset(@20);
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-10);
        }];
    }
    return self;
}

- (void)captcha
{
    CaptchaView * captcha = [CaptchaView new];
    captcha.delegate = self;
    [self addSubview:captcha];
    _captcha = captcha;
    __weak typeof(self) weakSelf = self;
    [captcha mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-8);
        make.right.top.equalTo(weakSelf);
        make.width.equalTo(weakSelf).multipliedBy(0.25f);
        
    }];
}
- (void)justifiedAlignmentTitle
{
    if(!([LaguageControl shareControl].type == LanguageTypesChinese))
    {
        return;
    }
    [self layoutIfNeeded];
    CGSize size = _textLabel.frame.size;
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:_textLabel.text];
    CGSize attributeSize = [attributeString.string sizeWithAttributes:@{NSFontAttributeName:_textLabel.font}];
    NSNumber *wordSpace = [NSNumber numberWithInt:(size.width-attributeSize.width)/(attributeString.length-1)];
    [attributeString addAttribute:NSKernAttributeName value:wordSpace range:NSMakeRange(0, attributeString.length)];
    _textLabel.lineBreakMode = NSLineBreakByClipping;
    _textLabel.attributedText = attributeString;
}

- (void)refreshVerificationCode
{
    if(_captcha)
    {
        [_captcha refresh];
        _textField.text = nil;
    }
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 绘制底部直线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, 0, rect.size.height-1);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-1);
    CGContextSetRGBStrokeColor(context,
                               0.75f, 0.75f, 0.75f, .6f);
    CGContextStrokePath(context);
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValueWithTextField) name:UITextFieldTextDidChangeNotification object:textField];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -  CaptchaViewDelegate
- (void)currentCaptcha:(NSString *)captchaStr
{
    _verificationCode = captchaStr;
    [self changeValueWithTextField];
}
- (void)changeValueWithTextField
{
    // 用户名
    if(!_textField.secureTextEntry && !_authCode && [self.delegate respondsToSelector:@selector(currentUserNumber:)])
    {
        [self.delegate currentUserNumber:_textField.text];
    }
    // 密码
    if(_textField.secureTextEntry && [self.delegate respondsToSelector:@selector(currentPassWord:)])
    {
        [self.delegate currentPassWord:_textField.text];
    }
    // 验证码
    if(_authCode && [self.delegate respondsToSelector:@selector(verificationCode:)])
    {
        // 不区分大小写
        BOOL result = [_verificationCode compare:_textField.text options:NSCaseInsensitiveSearch];
        [self.delegate verificationCode:!result];
    }
    
}
@end
