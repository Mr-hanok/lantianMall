//
//  AccountRechargeView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AccountRechargeView.h"
@interface AccountRechargeView ()
{
}
@end
@implementation AccountRechargeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc"] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end


@interface AccountRechargeTypeView ()
{
    UIButton * _sender;
}
@end
@implementation AccountRechargeTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        UIButton * sender = [UIButton buttonWithType:UIButtonTypeCustom];
        sender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIImageView * accessory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
        sender.titleLabel.font = self.titleLabel.font;
        [sender addTarget:self action:@selector(selectRechargeType) forControlEvents:UIControlEventTouchUpInside];
        accessory.contentMode = UIViewContentModeScaleAspectFit;
        [sender setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
        [sender setTitle:[LaguageControl languageWithString:@"支付宝"] forState:UIControlStateNormal];
        [self addSubview:sender];
        [self addSubview:accessory];
        __weak typeof(self) weakSelf = self;
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(20));
            make.right.equalTo(accessory.mas_left);
        }];
        [accessory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(5));
            make.width.mas_equalTo(kScaleWidth(15));
        }];
        _sender = sender;
    }
    return self;
}
#pragma mark - other Delegate
- (void)RechargeTypePopViewWithType:(NSInteger)type
{
//    if(type)
//    {
//        [_sender setTitle:LaguageControl(@"银行卡/信用卡") forState:UIControlStateNormal];
//    }else
//    {
//        [_sender setTitle:LaguageControl(@"网银") forState:UIControlStateNormal];
//    }
    
    switch (type) {
        case 0:
            [_sender setTitle:LaguageControl(@"支付宝") forState:UIControlStateNormal];

            break;
            
        case 1:
            [_sender setTitle:LaguageControl(@"微信") forState:UIControlStateNormal];

            break;
        
        case 3:
            [_sender setTitle:LaguageControl(@"网银") forState:UIControlStateNormal];

            break;
            
        case 2:
            [_sender setTitle:LaguageControl(@"银行卡/信用卡") forState:UIControlStateNormal];

            break;
    }
    [_sender setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
}
- (void)selectRechargeType
{
    if([_delegate respondsToSelector:@selector(accountRechargeTypeSelectWithView:)])
    {
       [_delegate accountRechargeTypeSelectWithView:self];
    }
}
- (NSString *)content
{
   return _sender.currentTitle;
}
@end


@interface AccountRechargeMoneyView ()<UITextFieldDelegate>
{
    UITextField * textField;
}
@end

@implementation AccountRechargeMoneyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        textField = [[UITextField alloc] init];
        [self addSubview:textField];
        __weak typeof(self) weakSelf = self;
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right);
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(20));
            make.top.bottom.equalTo(weakSelf);

        }];
        textField.font = weakSelf.titleLabel.font;
        textField.placeholder = [LaguageControl languageWithString:@"输入充值金额"];
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextField) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)changeTextField
{
    _value = [textField.text doubleValue];
}
@end



@interface AccountRechargeRemarkView ()<UITextFieldDelegate>
{
    UITextField * textField;
}
@end
@implementation AccountRechargeRemarkView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        textField = [[UITextField alloc] init];
        [self addSubview:textField];
        __weak typeof(self) weakSelf = self;
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right);
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(20));
            make.top.bottom.equalTo(weakSelf);
            
        }];
        textField.font = weakSelf.titleLabel.font;
        textField.placeholder = [LaguageControl languageWithString:@"输入充值备注"];
        textField.delegate = self;
    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextField) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)changeTextField
{
    _value = textField.text;
}


@end
