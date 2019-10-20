//
//  DetailedRegisterViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DetailedRegisterViewController.h"
#import "RegisterTextField.h"
#import "LoginButton.h"
#import "UserAgreementButton.h"
#import "TableViewPromptHeaderView.h"
#import "ComplaintItemsView.h"
#import "ShufflingInternalWebViewController.h"
#import "CountDownButton.h"
@interface DetailedRegisterViewController ()<UserAgreementButtonDelegate,SelectePhoneTextFieldDelegate,ComplaintItemsViewDelegate,RegisterTextFielDelegate>
{
    TableViewPromptHeaderView * _prompt;
    RegisterTextField * _accountTF;
    RegisterTextField * _phoneTF;
    RegisterTextField * _passWordTF;
    RegisterTextField * _againWordTF;
    RegisterTextField * _authCodeTF;
    RegisterTextField * _tuiJianNumTF;

    
    UserAgreementButton * _userAgreement;
    LoginButton * _registerButton;
    CountDownButton * _countButton;
    NSString * _title;
    NSString * _accountTitle;
    NSString * _accountPlaceholder;
    
}
@end
@implementation DetailedRegisterViewController
- (void)viewDidLoad
{
    
    [self loadLoginView];
    [super viewDidLoad];
}
- (void)loadLoginView
{
    _prompt = [[TableViewPromptHeaderView alloc] init];
    _accountTF = [[RegisterTextField alloc] initWithPlaceholder:@"用户名" isVerify:NO];
    _accountTF.delegate = self;
    _phoneTF = [[RegisterTextField alloc] initWithPlaceholder:@"手机号码" isVerify:NO];
    _phoneTF.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _againWordTF = [[RegisterTextField alloc] initWithPlaceholder:@"请再次确认密码" isVerify:NO];
    _tuiJianNumTF = [[RegisterTextField alloc]initWithPlaceholder:@"请输入推荐码(选填)" isVerify:NO];
    _passWordTF = [[RegisterTextField alloc] initWithPlaceholder:@"请输入密码" isVerify:NO];
    _authCodeTF = [[RegisterTextField alloc] initWithPlaceholder:@"验证码" isVerify:NO];
    _authCodeTF.textField.keyboardType = UIKeyboardTypeNumberPad;

    _countButton = [[CountDownButton alloc] initWithInterval:60 Target:self Sel:@selector(clickSendAuthCode)];
    _passWordTF.secureTextEntry = YES;
    _againWordTF.secureTextEntry = YES;
    _prompt.text = nil;
    __weak typeof(self) weakSelf = self;
    _userAgreement = [[UserAgreementButton alloc] initWithTitle:[LaguageControl languageWithString:@"我已阅读并接受了《用户协议》"] keyWord:[LaguageControl languageWithString:@"《用户协议》"]];
    
    _userAgreement.delegate = self;
    _registerButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf clickRegister];
    } title:@"注册并登录"];
    [_registerButton settingButtonSelectWithSelected:YES];
    [self.view addSubview:_prompt];
    [self.view addSubview:_accountTF];
    [self.view addSubview:_phoneTF];
    [self.view addSubview:_authCodeTF];
    [self.view addSubview:_passWordTF];
    [self.view addSubview:_againWordTF];
    [self.view addSubview:_userAgreement];
    [self.view addSubview:_registerButton];
    [self.view addSubview:_countButton];
    [self.view addSubview:_tuiJianNumTF];
    _tuiJianNumTF.hidden = YES;
//    _phoneTF.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationBarView.logoImageView.hidden = YES;
    self.title = LaguageControl(@"会员注册");
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    void (^layoutBlock)(MASConstraintMaker *make) = ^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.height.mas_equalTo(kScaleHeight(40));
    };
    [_prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kScaleHeight(10));
    }];
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_prompt.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    
   
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_accountTF.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_authCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.top.equalTo(_phoneTF.mas_bottom).mas_offset(kScaleHeight(15));
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneTF.mas_bottom).mas_offset(kScaleHeight(15));
        make.height.mas_equalTo(kScaleHeight(40));
        make.left.equalTo(_authCodeTF.mas_right).mas_offset(kScaleWidth(6));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(0.3f);
    }];
    
    [_passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_authCodeTF.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_againWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_passWordTF.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_tuiJianNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_againWordTF.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_userAgreement mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.height.mas_equalTo(_userAgreement.height + 4);
        make.top.equalTo(_tuiJianNumTF.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_userAgreement.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    [self.view layoutIfNeeded];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_countButton stopTimeing];
}

#pragma mark - registertextfildDelegate
-(void)didEndEditTextString:(NSString *)text textField:(RegisterTextField *)textFd{
    if (text.length == 0) {
        return;
    }
}
#pragma mark - other Delegate
/**
 *  点击用户协议
 */
- (void)userAgreementRedirect
{
    ShufflingInternalWebViewController * controller = [[ShufflingInternalWebViewController alloc] init];
    controller.requestURl = [NSString stringWithFormat:@"%@/doc_agree",KAppRootUrl];
    controller.title = LaguageControl(@"用户协议");
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
/**
 *  选择是否已经阅读用户协议
 */
- (void)userAgreementClickWithButton:(UIButton *)sender
{
   
}
- (void)complaintItemWithTitle:(NSString *)title
{
//    [_phoneTF chaneAreaCode:title];
}
#pragma mark - clickEvent
/**
 *   发送验证码
 */
- (void)clickSendAuthCode
{
    if(_phoneTF.text.length != 11)
    {
        [HUDManager showWarningWithText:@"请输入正确的手机号"];
        return;
    }
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍等"];
    
    [NetWork PostNetWorkSendMessageWith:MessageCodeTypeRegister mobile:_phoneTF.text  successBlock:^(NSDictionary *dic) {
        [_countButton startTimer];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        
    }];
    
//    [NetWork PostNetWorkWithUrl:@"/getMsgCode" with:@{@"phone":_phoneTF.text} successBlock:^(NSDictionary *dic) {
//        [HUDManager hideHUDView];
//    } FailureBlock:^(NSString *msg) {
//        [HUDManager hideHUDView];
//    } errorBlock:^(id error) {
//        [HUDManager hideHUDView];
//        [HUDManager showWarningWithError:error];
//    }];
}
/**
 *   点击了注册
 */
- (void)clickRegister
{
    /**
     *  判断是否勾选了协议
     */
    if(!_userAgreement.selected)
    {
        [HUDManager showWarningWithText:@"请阅读用户协议"];
        return;
    }
    /**
     *  用户名不能为空
     */
    if(_accountTF.text.length == 0)
    {
        [HUDManager showWarningWithText:@"请输入账户名"];
        return;
    }
    if(![NSString validateAccount:_accountTF.text])
    {
        [HUDManager showWarningWithText:@"账号由4-20位数字或字母组成"];
        return;
    }
    
    /**
     *  手机号判断
     */
    if(_phoneTF.text.length != 11)
    {
        [HUDManager showWarningWithText:@"请输入正确的手机号"];
        return;
    }
    if(![NSString validatePassWord:_passWordTF.text])
    {
        [HUDManager showWarningWithText:@"密码长度不符合要求,请输入6-20位数字字母和特殊符号组合"];
        return;
    }
    /**
     *  两次密码是否相同
     */
    if(![_passWordTF.text isEqualToString:_againWordTF.text])
    {
        [HUDManager showWarningWithText:@"两次密码输入不一致,请重新输入"];
        return;
    }
    /**验证用户名是否重复*/
//    [self getdataUserTegisterWithUserName:_accountTF.text isCompany:NO isSuccessBlock:^(BOOL issuccess) {
//        if (issuccess) {
//            
//
//        }
//    }];
    [self authCodeSwitch:^(BOOL isSwitch) {
        [self userRegisterSwitch:isSwitch];
    }];

}
- (void)authCodeSwitch:(void(^)(BOOL isSwitch))block
{
    [NetWork PostNetWorkWithUrl:@"/getMsgSwitch" with:nil successBlock:^(NSDictionary *dic) {
        if(block)
        {
            block([dic[@"data"] boolValue]);
        }
    } errorBlock:^(NSString *error) {
        block(NO);
    }];
}
- (void)userRegisterSwitch:(BOOL)isSwitch
{
    if((_authCodeTF.text == nil || _authCodeTF.text.length != 6) /** && isSwitch == YES*/)
    {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:@"请输入验证码"];
        return;
    }
    NSMutableDictionary * parame = [@{@"userName":_accountTF.text,
                                      @"password":_passWordTF.text,
                                       @"regType":@(2),
                                          @"code":_authCodeTF.text? _authCodeTF.text:@"",
                                        @"mobile":_phoneTF.text,
                                      @"referralCode":_tuiJianNumTF.text?:@""
                                      } mutableCopy];
    
//    if(isSwitch)
//    {
//        [parame setObject:_authCodeTF.text forKey:@"code"];
//    }else
//    {
//        [parame removeObjectForKey:@"code"];
//    }
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
    [NetWork PostNetWorkWithUrl:@"/register" with:parame successBlock:^(NSDictionary * content) {
        if([content[@"status"] integerValue] == 1)
        {
            [self login];
        }else
        {
            [HUDManager showWarningWithError:content[@"message"]];
        }
    } errorBlock:^(NSString *error) {
        
//        [HUDManager showWarningWithError:@"请检查网络"];
        [HUDManager hideHUDView];
    }];
    
}
- (void)login
{
    [NetWork PostNetWorkWithUrl:@"/user_login" with:@{@"loginName":_phoneTF.text,@"password":_passWordTF.text} successBlock:^( NSDictionary * content) {
        if([content[@"status"] integerValue] == 1)
        {
            [HUDManager showWarningWithText:@"注册并登录成功"];
            [HUDManager hideHUDView];
            [[UserAccountManager shareUserAccountManager] loginWithUserDic:content[@"data"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"kRegisterSuccessNoti" object:nil userInfo:@{@"value":@YES}];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [HUDManager hideHUDView];
        }
    } errorBlock:^(NSString *error) {
        [HUDManager showWarningWithError:error];
        [HUDManager hideHUDView];
    }];
}

#pragma mark -NetWork
/**<#注释#>*/
-(void)getdataUserTegisterWithUserName:(NSString *)userName
                               isCompany:(BOOL)iscompany
                          isSuccessBlock:(void (^) (BOOL issuccess))sublock{
    NSDictionary * parms = @{@"store_subject":iscompany? @"2":@"1",
                             @"userName":userName,
                             };
    
    [NetWork PostNetWorkWithUrl:@"/verify/info" with:parms successBlock:^(NSDictionary *dic) {
        
        sublock(YES);
        
    } FailureBlock:^(NSString *msg) {
        sublock(NO);
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        sublock(NO);
    }];
}


@end
