//
//  PopVerifyView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopVerifyView.h"
#import "RegisterTextField.h"
#import "CountDownButton.h"
#import "ZPYVerifyContactsSingle.h"
#import "NSString+HidePhone.h"
@interface PopVerifyView ()<CountDownButtonDelegate,RegisterTextFielDelegate>

@property (nonatomic , weak) UIView * displayView;
@property (nonatomic , weak) CountDownButton * getCode;
@end
@interface PopVerifyView ()

@end
@implementation PopVerifyView
{
    RegisterTextField * verifyTF;
}
+ (PopVerifyView *)creatPopVerifyWithType:(PopVerifyTypes)type
                                   sender:(NSString *)sender
{
    PopVerifyView * view = [PopVerifyView new];
    view.type = type;
    view.frame = kScreenFreameBound;
    UIView * backgroundView = [UIView new];
    backgroundView.frame = view.frame;
    UIView * displayView = [UIView new];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.618f];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(removeFromWindow)];
    [backgroundView addGestureRecognizer:tap];
    [view addSubview:backgroundView];
    [view addSubview:displayView];
    __weak typeof(view) weakSelf = view;
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(8));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
        make.center.equalTo(weakSelf);
        make.height.equalTo(displayView.mas_width).multipliedBy(0.618f);
    }];
    displayView.layer.cornerRadius = 5;
    displayView.backgroundColor = [UIColor whiteColor];
    view.alpha = 0;
    view.senderString = sender;
    view.displayView = displayView;
    [view setupWithType:type];// 设置内容
    [view layoutIfNeeded];
    return view;
}

- (void)setupWithType:(PopVerifyTypes)type
{
    UILabel * titleLabel = [[UILabel alloc] initWithText:type?[LaguageControl languageWithString:@"验证邮箱"]:[LaguageControl languageWithString:@"验证手机号"]];
    NSString * promptStr = [NSString stringWithFormat:@"%@%@: %@ %@",LaguageControl(@"输入"),!type?LaguageControl(@"手机号"):LaguageControl(@"邮箱"),!type?[NSString hidePhone:self.senderString]:self.senderString,LaguageControl(@"接收的验证码")];
    UIView * topLine = [UIView new];
    UILabel * promptLabel = [[UILabel alloc] initWithText:promptStr];
    promptLabel.numberOfLines = 2;
    verifyTF = [[RegisterTextField alloc] initWithPlaceholder:@"请输入验证码" isVerify:NO];
    verifyTF.delegate = self;
    _getCode.delegate = self;
    CountDownButton * getCode = [[CountDownButton alloc] initWithInterval:60 Target:self Sel:@selector(getCodeTime)];
    UIView * bottomLine = [UIView new];
    UIView * midLine = [UIView new];
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchDown];
    [okButton addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:[LaguageControl languageWithString:@"取消"] forState:UIControlStateNormal];
    [okButton setTitle:[LaguageControl languageWithString:@"确定"] forState:UIControlStateNormal];
    [self.displayView addSubview:titleLabel];
    [self.displayView addSubview:promptLabel];
    [self.displayView addSubview:verifyTF];
    [self.displayView addSubview:getCode];
    [self.displayView addSubview:cancelButton];
    [self.displayView addSubview:okButton];
    [self.displayView addSubview:topLine];
    [self.displayView addSubview:bottomLine];
    [self.displayView addSubview:midLine];
    UIColor * titleColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9f];

    titleLabel.textColor = titleColor;
    titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(18)];
    promptLabel.textColor = [UIColor grayColor];
    promptLabel.textAlignment = NSTextAlignmentLeft;
    [cancelButton setTitleColor:titleColor forState:UIControlStateNormal];
    [okButton setTitleColor:titleColor forState:UIControlStateNormal];
    UIColor * lineColor = [UIColor colorWithString:@"#a3a3a3122"];
    topLine.backgroundColor = lineColor;
    midLine.backgroundColor = lineColor;
    bottomLine.backgroundColor = lineColor;
    getCode.delegate = self;
    __weak typeof(self.displayView) weakSelf = self.displayView;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.25f);
    }];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(kScaleHeight(8));
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(8));
        make.right.equalTo(weakSelf.mas_right);
    }];
    [verifyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(promptLabel.mas_left);
        make.height.mas_equalTo(kScaleHeight(40));
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.6f);
        make.top.equalTo(promptLabel.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
        make.left.equalTo(verifyTF.mas_right).mas_offset(kScaleWidth(5));
        make.height.equalTo(verifyTF.mas_height);
        make.top.equalTo(verifyTF.mas_top);
    }];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(weakSelf);
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(weakSelf);
        make.size.equalTo(cancelButton);
        make.left.equalTo(cancelButton.mas_right).mas_offset(1);
    }];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5f);
        make.right.left.equalTo(weakSelf);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5f);
        make.right.left.equalTo(weakSelf);
        make.bottom.equalTo(okButton.mas_top);
    }];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(okButton.mas_height);
        make.width.mas_equalTo(1);
        make.left.equalTo(cancelButton.mas_right);
        make.bottom.equalTo(weakSelf);
    }];
    _getCode = getCode;
}


/**
 *  显示至窗口
 */
- (void)displayToWindow
{
    [KeyWindow addSubview:self];
    [verifyTF removeTextString];
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
    }];
}
/**
 *  从窗口上移除
 */
- (void)removeFromWindow
{
    [UIView animateWithDuration:0.25f animations:^{
         self.alpha = 0;
        if(!_getCode.isStart)
        {
            [_getCode invalidateTimer];
            [[ZPYVerifyContactsSingle shareVerifyContacts] removeVerifyPopView:self key:self.senderString];
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/**
 *  验证成功
 */
- (void)verifySuccess
{
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
        [_getCode invalidateTimer];
        [[ZPYVerifyContactsSingle shareVerifyContacts]removeVerifyPopView:self key:self.senderString];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/**
 *  点击了取消
 */
- (void)cancel
{
    [self removeFromWindow];
}
/**
 *  点击了确定
 */
- (void)clickOK
{
    if(!self.text || self.text.length == 0)
    {
        return;
    }
    if(_type == PopVerifyTypesEmail)
    { // 邮箱
        [self validationEmail:self.senderString code:self.text completed:^(BOOL successful, id error) {
            if(successful)
            {
                if([_delegate respondsToSelector:@selector(popVerifyPassWith:)])
                {
                    [_delegate popVerifyPassWith:self];
                    [self verifySuccess];
                }
            }else
            {
                [HUDManager showWarningWithError:error];
            }
        }];
    }else
    { // 手机
        [self validationPhone:self.senderString code:self.text completed:^(BOOL successful, id error) {
            if(successful)
            {
                if([_delegate respondsToSelector:@selector(popVerifyPassWith:)])
                {
                    [_delegate popVerifyPassWith:self];
                    [self verifySuccess];
                }
            }else
            {
                [HUDManager showWarningWithError:error];
            }
        }];
    }
}
/**
 *  获取验证码
 */
- (void)getCodeTime
{
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍等"];
    if(self.type == PopVerifyTypesEmail)
    {
        [NetWork PostNetWorkWithUrl:@"/sendEmail" with:@{@"email":self.senderString,@"type":self.templateString} successBlock:^(NSDictionary *dic) {
            self.verifyCode = dic[@"message"];
            [HUDManager hideHUDView];
        } FailureBlock:^(NSString *msg) {
            [HUDManager hideHUDView];
            [HUDManager showWarningWithError:msg];
        } errorBlock:^(id error) {
            [HUDManager hideHUDView];
            [HUDManager showWarningWithError:error];
        }];
    }else
    {
//        [NetWork PostNetWorkWithUrl:@"/send_mobile_message" with:@{@"mobile":[self.senderString stringByReplacingOccurrencesOfString:@"+" withString:@""],@"type":self.templateString} successBlock:^(NSDictionary *dic) {
//            self.verifyCode = dic[@"message"];
//            [HUDManager hideHUDView];
//        } FailureBlock:^(NSString *msg) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:msg];
//        } errorBlock:^(id error) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:error];
//        }];
        
        
        [NetWork PostNetWorkSendMessageWith:[self.templateString integerValue]  mobile:[self.senderString stringByReplacingOccurrencesOfString:@"+" withString:@""] successBlock:^(NSDictionary *dic) {
            self.verifyCode = dic[@"message"];
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithError:msg];

        } errorBlock:^(id error) {
            
        }];
        
//        [NetWork PostNetWorkWithUrl:@"/getMsgCode" with:@{@"phone":[self.senderString stringByReplacingOccurrencesOfString:@"+" withString:@""]} successBlock:^(NSDictionary *dic) {
//            [HUDManager hideHUDView];
//            self.verifyCode = dic[@"message"];
//        } FailureBlock:^(NSString *msg) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:msg];
//        } errorBlock:^(id error) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:error];
//        }];
        
    }
}
- (void)start
{
    [_getCode startTimer];
}

#pragma mark - delegate Method
- (void)countDownStop
{
    _verifyCode = nil;
    if (!self.superview)
    {
        if(_otherDelegate && [_otherDelegate respondsToSelector:@selector(popVerifyTimeToCompleteAndNoSuperView:)])
        {
            [_otherDelegate popVerifyTimeToCompleteAndNoSuperView:self];
        }
    }
}
- (void)currentTextString:(NSString *)text textField:(id)textField
{
    _text = text;
}
#pragma mark - NetWork Verify Method
/**
 *  验证邮箱验证码
 */
- (void)validationEmail:(NSString *)email code:(NSString *)code completed:(void (^) (BOOL successful , id error))completed
{

    [NetWork PostNetWorkWithUrl:@"/buyer/validation_email" with:@{@"email":email,@"code":code} successBlock:^(NSDictionary *dic) {
        if([dic[@"status"] boolValue])
        {
            completed (YES , nil);
        }else
        {
            completed (NO, dic[@"message"]);
        }
    } FailureBlock:^(NSString *msg) {
        completed (NO , msg);
    } errorBlock:^(id error) {
        completed (NO , error);
    }];
}
/**
 *  验证手机验证码
 */
- (void)validationPhone:(NSString *)phone code:(NSString *)code completed:(void (^) (BOOL successful , id error))completed
{
    NSString *usetype ;
    if ([self.templateString integerValue] ==2) {
        /**用户注册*/
        usetype = @"change_pwd";
    }else if ([self.templateString integerValue] ==3){
        /**修改登录密码*/
        usetype = @"change_pwd";

    }else if ([self.templateString integerValue] ==4){
        /**修改手机号码*/
        usetype = @"change_phone";

    }else if ([self.templateString integerValue] ==5){
        /**修改支付密码*/
        usetype = @"change_paypwd";
    }
    
    [NetWork PostNetWorkWithUrl:@"/buyer/validation_phone" with:@{@"phone_num":[phone stringByReplacingOccurrencesOfString:@"+" withString:@""],@"code":code,@"useType":usetype?:@""} successBlock:^(NSDictionary *dic) {
        if([dic[@"status"] boolValue])
        {
            completed (YES , nil);
        }else
        {
            completed (NO, dic[@"message"]);
        }
    } FailureBlock:^(NSString *msg) {
        completed (NO , msg);
    } errorBlock:^(id error) {
        completed (NO , error);
    }];
}
#pragma mark - setter and getter
- (void)setVerifyCode:(NSString *)verifyCode
{
    _verifyCode = verifyCode;
    [_getCode startTimer];
}
- (NSString *)text
{
    return _text;
}
@end
