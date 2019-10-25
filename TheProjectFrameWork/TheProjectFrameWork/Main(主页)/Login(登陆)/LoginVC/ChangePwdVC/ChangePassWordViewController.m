//
//  ChangePassWordViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "RegisterTextField.h"
#import "LoginButton.h"
@interface ChangePassWordViewController ()<RegisterTextFielDelegate>
{
    UILabel * _label;
    RegisterTextField * _newPwdTF;
    RegisterTextField * _confirmPwdTF;
    LoginButton * _completeButton;
}
@end
@implementation ChangePassWordViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLoginView];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    void (^layoutBlock) (MASConstraintMaker *make) = ^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.height.mas_equalTo(kScaleHeight(40));
    };
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.view).mas_offset(kScaleWidth(12));
    }];
    [_newPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_label.mas_bottom).mas_offset(kScaleHeight(14));
    }];
    [_confirmPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_newPwdTF.mas_bottom).mas_offset(kScaleHeight(14));
    }];
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_confirmPwdTF.mas_bottom).mas_offset(kScaleHeight(43));
    }];
}
- (void)loadLoginView
{
    _label = [UILabel new];
    _label.text = [LaguageControl languageWithString:@"请设置新的登录密码"];
    _label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    _label.textColor = [UIColor colorWithString:@"#616161"];
    _newPwdTF = [[RegisterTextField alloc] initWithPlaceholder:@"6-20位不能与旧密码相同" isVerify:NO];
    _confirmPwdTF = [[RegisterTextField alloc] initWithPlaceholder:@"请再次确认密码" isVerify:NO];
    _newPwdTF.secureTextEntry = YES;
    _confirmPwdTF.secureTextEntry = YES;
    __weak typeof(self) weakSelf = self;
    _completeButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf changePassWord];
    } title:@"完成"];
    _newPwdTF.delegate = self;
    _confirmPwdTF.delegate = self;
    [self.view addSubview:_label];
    [self.view addSubview:_newPwdTF];
    [self.view addSubview:_confirmPwdTF];
    [self.view addSubview:_completeButton];
}
- (void)currentTextString:(NSString *)text textField:(RegisterTextField *)textField
{
    if (_newPwdTF.text.length >=6 && _confirmPwdTF.text.length >=6 && [_newPwdTF.text isEqualToString:_confirmPwdTF.text] && _newPwdTF.text.length <= 20)
    {
        [_completeButton settingButtonSelectWithSelected:YES];
    }else
    {
        [_completeButton settingButtonSelectWithSelected:NO];
    }
}

/**
 *  点击完成（修改密码）
 */
- (void)changePassWord
{
    [HUDManager showLoadingHUDView:self.view];
    [NetWork PostNetWorkWithUrl:@"/reset_password_p" with:@{@"newPassword":_confirmPwdTF.text,@"mobile":self.phone?:@"",@"code":self.code?:@""} successBlock:^(NSDictionary *dic) {
        /**
         *  找回密码成功
         */
        [HUDManager showWarningWithText:@"修改密码成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager showWarningWithError:error];
    }];
}
@end
