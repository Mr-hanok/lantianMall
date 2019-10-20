//
//  OldPwdChangePayViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OldPwdChangePayViewController.h"
#import "TableViewPromptHeaderView.h"
#import "RegisterTextField.h"
#import "LoginButton.h"
@interface OldPwdChangePayViewController ()<RegisterTextFielDelegate>
{
    TableViewPromptHeaderView * _headerView;
    TableViewPromptHeaderView * _footerView;
    RegisterTextField * _oldPwdTextField;
    RegisterTextField * _newPwdTextField;
    RegisterTextField * _againNewPwdTextField;
    LoginButton * _commitButton;
}

@end
@implementation OldPwdChangePayViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"设置支付密码"];
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    void (^layoutBlock)(MASConstraintMaker * make) = ^(MASConstraintMaker * make){
        make.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleHeight(44));
    };
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(navBarHeight + kScaleHeight(10)).priority(750);
    }];
    [_oldPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_headerView.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [_newPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_oldPwdTextField.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_againNewPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_newPwdTextField.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.top.equalTo(_againNewPwdTextField.mas_bottom).mas_offset(kScaleHeight(10));

    }];
    [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_footerView.mas_bottom).mas_offset(kScaleHeight(10));
        make.height.mas_equalTo(kScaleHeight(40));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
    }];

}
/**
 *  初始化控件
 */
- (void)loadSubviews
{
    _headerView = [[TableViewPromptHeaderView alloc] init];
    _oldPwdTextField = [[RegisterTextField alloc] initWithText:nil placeholder:@"输入原密码"];
    _newPwdTextField = [[RegisterTextField alloc] initWithText:nil placeholder:@"输入密码"];
    _againNewPwdTextField = [[RegisterTextField alloc] initWithText:nil placeholder:@"再次输入密码"];
    _footerView = [[TableViewPromptHeaderView alloc] init];
    __weak typeof(self) weakSelf = self;
    _commitButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setupPayPassWord];
    } title:@"完成"];
    _oldPwdTextField.delegate = self;
    _newPwdTextField.delegate = self;
    _againNewPwdTextField.delegate = self;
    [self loadTitleInfo];
    [self.view addSubview:_headerView];
    [self.view addSubview:_oldPwdTextField];
    [self.view addSubview:_newPwdTextField];
    [self.view addSubview:_againNewPwdTextField];
    [self.view addSubview:_footerView];
    [self.view addSubview:_commitButton];

}

/**
 *  给控件的文字赋值
 */
- (void)loadTitleInfo
{
    _headerView.text = @"设置支付密码可以保障您的账户安全";
    _footerView.text = @"请输入6个英文字母/数字/符号";
    _oldPwdTextField.placeholder = @"输入原密码";
    _newPwdTextField.placeholder = @"输入密码";
    _againNewPwdTextField.placeholder = @"再次输入密码";
    _oldPwdTextField.sideline = YES;
    _newPwdTextField.sideline = YES;
    _againNewPwdTextField.sideline = YES;
    _oldPwdTextField.secureTextEntry = YES;
    _newPwdTextField.secureTextEntry = YES;
    _againNewPwdTextField.secureTextEntry = YES;
}

#pragma mark - RegisterTextFielDelegate
-(void)currentTextString:(NSString *)text textField:(RegisterTextField *)textField
{
    BOOL result = (_oldPwdTextField.text.length == 6) && (_newPwdTextField.text.length == 6) && ([_newPwdTextField.text isEqualToString:_againNewPwdTextField.text]);
    [_commitButton settingButtonSelectWithSelected:result];
    
}
/**
 *  点击完成（设置支付密码）
 */
- (void)setupPayPassWord
{
   
//    if(![NSString judgePassWordLegal:_newPwdTextField.text])
//    {
//        [HUDManager showWarningWithText:@"密码太过简单"];
//        return;
//    }
    [NetWork PostNetWorkWithUrl:@"/buyer/update_payPwdByPassword" with:@{@"user_id":kUserId,@"password":_oldPwdTextField.text,@"pay_pwd":_newPwdTextField.text} successBlock:^(NSDictionary *dic) {
        [HUDManager showWarningWithText:@"修改支付密码成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } FailureBlock:^(NSString * msg) {
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(NSError * error) {
        [HUDManager showWarningWithError:error];
    }];
}
#pragma mark - setter and getter

@end
