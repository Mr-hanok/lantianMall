//
//  SetPayPassWordViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SetPayPassWordViewController.h"
#import "TableViewPromptHeaderView.h"
#import "RegisterTextField.h"
#import "LoginButton.h"
@interface SetPayPassWordViewController ()<RegisterTextFielDelegate>
{
    TableViewPromptHeaderView * _headerLabel;
    RegisterTextField * _payPassWord;
    RegisterTextField * _authPayPassWord;
    TableViewPromptHeaderView * _footerLabel;
    LoginButton * _commitButton;
    
    NSString * payPassWord;
    NSString * authPayPassWord;
}
@end
@implementation SetPayPassWordViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewLoadSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"设置支付密码");
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kTopSpace + kScaleHeight(10));
        make.left.equalTo(weakSelf.view.mas_left);
        make.width.mas_equalTo(weakSelf.view.mas_width);
    }];
    [_payPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_headerLabel.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [_authPayPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_payPassWord.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [_footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_authPayPassWord.mas_bottom).mas_offset(kScaleHeight(10));
        make.right.left.equalTo(weakSelf.view);
    }];
    [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_footerLabel.mas_bottom).mas_offset(kScaleHeight(10));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
    }];
}
- (void)viewLoadSubviews
{
    _headerLabel = [[TableViewPromptHeaderView alloc] init];
    _payPassWord = [[RegisterTextField alloc] initWithText:nil placeholder:@"输入密码"];
    _payPassWord.delegate = self;
    _authPayPassWord = [[RegisterTextField alloc] initWithText:nil placeholder:@"再次输入密码"];
    _authPayPassWord.delegate = self;
    _footerLabel = [[TableViewPromptHeaderView alloc] init];
    __weak typeof(self) weakSelf = self;
    _commitButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf finish];
    } title:@"完成"];
    [self.view addSubview:_headerLabel];
    [self.view addSubview:_payPassWord];
    [self.view addSubview:_authPayPassWord];
    [self.view addSubview:_footerLabel];
    [self.view addSubview:_commitButton];
    [self loadViewWords];
 
}
- (void)loadViewWords
{
    _headerLabel.text = @"设置支付密码可以保障您的账户安全";
    _payPassWord.secureTextEntry = YES;
    _payPassWord.sideline = YES;
    _authPayPassWord.sideline = YES;
    _authPayPassWord.secureTextEntry = YES;
    _footerLabel.text = @"请输入6位数字";
}
/**
 *  完成
 */
- (void)finish
{
    
    NSString * url = nil;
    if(_isCreat)
    { // 创建支付密码
        url = @"/buyer/save_paypwd";
    }else
    { // 修改支付密码
        url = @"/updatePayPwdByUser";
    }
    
    NSMutableDictionary * parmas = [@{@"user_id":kUserId,@"pay_pwd":authPayPassWord} mutableCopy];

    [NetWork PostNetWorkWithUrl:url with:parmas successBlock:^(NSDictionary *dic) {
        [HUDManager showWarningWithText:@"设置支付密码成功"];
        if(_buyer)
        {
            UserModel * user = [UserAccountManager shareUserAccountManager].userModel;
            user.isPayPassWord = YES;
            [[UserAccountManager shareUserAccountManager] loginWithModel:user];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager showWarningWithError:error];
    }];

}

#pragma mark - other Delegate
- (void)currentTextString:(NSString *)text textField:(RegisterTextField *)textField
{
    if([textField isEqual:_payPassWord])
    {// 第一次密码
        payPassWord = textField.text;
    }else
    {// 确认密码
        authPayPassWord = textField.text;
    }
    BOOL isFinish = payPassWord.length == 6 && ([payPassWord isEqualToString:authPayPassWord]);
    [_commitButton settingButtonSelectWithSelected:isFinish];
}
@end
