//
//  RetrievePwdViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RetrievePwdViewController.h"
#import "RegisterTextField.h"
#import "LoginButton.h"

@interface RetrievePwdViewController ()<RegisterTextFielDelegate>
{
    RegisterTextField * _userNameTF;
    RegisterTextField * _captchaTF;
    LoginButton * _nextBtn;
    BOOL _isTure;
    NSString * _userName;
}
@end

@implementation RetrievePwdViewController

#pragma mark life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLoginView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"找回密码");
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_captchaTF removeTextString];
    [_userNameTF removeTextString];
    [_nextBtn settingButtonSelectWithSelected:NO];
    _userName = nil;
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    void (^layoutBlock) (MASConstraintMaker * make) = ^(MASConstraintMaker * make){
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.height.mas_equalTo(kScaleHeight(40));
    };
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kScaleHeight(20));
    }];
    [_captchaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_userNameTF.mas_bottom).mas_offset(kScaleHeight(12));
    }];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_captchaTF.mas_bottom).mas_offset(kScaleHeight(40));
    }];
 
}

- (void)loadLoginView
{
    _userNameTF = [[RegisterTextField alloc] initWithPlaceholder:@"输入您的帐户"  isVerify:NO];
    _captchaTF = [[RegisterTextField alloc] initWithPlaceholder:@"请输入验证码" isVerify:YES];
    _userNameTF.delegate = self;
    _captchaTF.delegate = self;
    __weak typeof(self) weakSelf = self;
    _nextBtn = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf retrieveNextStep];
    } title:@"下一步"];
    [self.view addSubview:_userNameTF];
    [self.view addSubview:_captchaTF];
    [self.view addSubview:_nextBtn];
}
/**
 *  点击下一步
 */
- (void)retrieveNextStep
{
    [_nextBtn settingButtonSelectWithSelected:NO];
    [NetWork PostNetWorkWithUrl:@"/buyer/findPassword" with:@{@"userName":_userName} successBlock:^(NSDictionary *dic) {
        [_nextBtn settingButtonSelectWithSelected:YES];
        UserModel * user = [UserModel mj_objectWithKeyValues:dic[@"data"]];
        [self performSegueWithIdentifier:@"findPwdOptions" sender:user];
    } FailureBlock:^(NSString *msg) {
        [_nextBtn settingButtonSelectWithSelected:YES];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [_nextBtn settingButtonSelectWithSelected:YES];
        [HUDManager showWarningWithError:error];
    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"findPwdOptions"])
    {
        UIViewController * controller = segue.destinationViewController;
        [controller setValue:sender forKey:@"user"];
    }
}
#pragma mark - RegisterTextFielDelegate
- (void)verificationCode:(BOOL)isTure
{
    _isTure = isTure;
    [self nextButtonStatus];
}
- (void)currentTextString:(NSString *)text textField:(RegisterTextField *)textField
{
    _userName = text;
    [self nextButtonStatus];
}
#pragma mark - private method
/**
 *  判断下一步按钮的可点击状态
 */
- (void)nextButtonStatus
{
    BOOL status = _isTure;
    [_nextBtn settingButtonSelectWithSelected:status];
}
@end
