//
//  BindFaceBookViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BindFaceBookViewController.h"
#import "RegisterTextField.h"
#import "UserAgreementButton.h"
#import "LoginButton.h"
@interface BindFaceBookViewController ()
{
    UILabel * prompt;
    RegisterTextField * _accountTF;
    RegisterTextField * _passWordTF;
    RegisterTextField * _phoneTF;
    RegisterTextField * _emailTF;
    UserAgreementButton * _agreement;
    LoginButton * _registerButton;
}
@end
@implementation BindFaceBookViewController
#pragma mark - life cycle 
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"绑定联系方式");
}
- (void)loadSubviews{
    prompt = [[UILabel alloc] initWithText:@"*手机号和电子邮箱可任选一种方式进行绑定"];
    prompt.textColor = [UIColor colorWithString:@"#cccccc"];
    prompt.textAlignment = NSTextAlignmentLeft;
    _accountTF = [[RegisterTextField alloc] initWithText:@"FaceBook" placeholder:[LaguageControl languageWithString:@"facebook账号"]];
    _passWordTF = [[RegisterTextField alloc] initWithText:LaguageControl(@"密码") placeholder:[LaguageControl languageWithString:@"请输入密码"]];
    _phoneTF = [[RegisterTextField alloc] initWithText:LaguageControl(@"手机号") placeholder:[LaguageControl languageWithString:@"请输入手机号"]];
    _emailTF = [[RegisterTextField alloc] initWithText:LaguageControl(@"电子邮箱") placeholder:[LaguageControl languageWithString:@"请输入电子邮箱"]];
    _agreement = [[UserAgreementButton alloc] initWithTitle:[LaguageControl languageWithString:@"我已阅读并接受了《用户协议》"] keyWord:[LaguageControl languageWithString:@"《用户协议》"]];
    __weak typeof(self) weakSelf = self;
    _registerButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf bindFaceBook];
    } title:@"注册并登录"];
    [self.view addSubview:prompt];
    [self.view addSubview:_accountTF];
    [self.view addSubview:_passWordTF];
    [self.view addSubview:_phoneTF];
    [self.view addSubview:_emailTF];
    [self.view addSubview:_agreement];
    [self.view addSubview:_registerButton];
    
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
    [prompt mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kScaleHeight(6)+kTopSpace);
    }];
    [_accountTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(prompt.mas_bottom).mas_offset(kScaleHeight(6));
    }];
    [_passWordTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_accountTF.mas_bottom).mas_offset(kScaleHeight(15));
        
    }];
    [_phoneTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_passWordTF.mas_bottom).mas_offset(kScaleHeight(15));
        
    }];
    [_emailTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_phoneTF.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_agreement mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.height.mas_equalTo(_agreement.height+ 4);
        make.top.equalTo(_emailTF.mas_bottom).mas_offset(kScaleHeight(3));
    }];
    [_registerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
         make.top.equalTo(_agreement.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    [_accountTF justifiedAlignment];
    [_passWordTF justifiedAlignment];
    [_emailTF justifiedAlignment];
    [_phoneTF justifiedAlignment];
}

- (void)bindFaceBook
{

}
@end
