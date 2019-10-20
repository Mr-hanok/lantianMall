//
//  IdentityAuthViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "IdentityAuthViewController.h"
#import "TableViewPromptHeaderView.h"
#import "RegisterTextField.h"
#import "LoginButton.h"
#import "BindingPhoneViewController.h"
@interface IdentityAuthViewController ()<RegisterTextFielDelegate>
{
    TableViewPromptHeaderView * _headerView;
    RegisterTextField * _payPassWord;
    LoginButton * _commitButton;
}
@end
@implementation IdentityAuthViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewLoadSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"身份验证"];
}
- (void)viewWillLayoutSubviews
{
    __weak typeof(self) weakSelf = self;
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kTopSpace).priority(750);
        make.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(_headerView.height + 15);
    }];
    [_payPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_headerView.mas_bottom).mas_offset(kScaleHeight(2));
    }];
    [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_payPassWord.mas_bottom).mas_offset(kScaleHeight(10));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
    }];
    [_payPassWord justifiedAlignment];
}
- (void)viewLoadSubviews
{
    _headerView = [[TableViewPromptHeaderView alloc] init];
    _payPassWord = [[RegisterTextField alloc] initWithText:nil placeholder:@"输入您的支付密码"];
    _payPassWord.delegate = self;
    __weak typeof(self) weakSelf = self;
    _commitButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf next];
    } title:@"下一步"];
    [self.view addSubview:_headerView];
    [self.view addSubview:_payPassWord];
    [self.view addSubview:_commitButton];
    [self loadViewWords];
}
- (void)loadViewWords
{
    _headerView.text = @"输入原支付密码，完成身份验证";
    _payPassWord.title = nil;
    _payPassWord.placeholder = @"输入您的支付密码";
    _payPassWord.secureTextEntry = YES;
    _payPassWord.sideline = YES;
    
}

#pragma mark - RegisterTextFielDelegate
- (void)currentTextString:(NSString *)text textField:(id)textField
{
        if(text.length >= 6)
        {
            [_commitButton settingButtonSelectWithSelected:YES];
        }else
        {
            [_commitButton settingButtonSelectWithSelected:NO];
        }
}
#pragma mark event respond
/**
 *  点击下一步
 */
- (void)next
{
    //TODO:买家卖家同一个接口（目前） 暂时注释
    [NetWork PostNetWorkWithUrl:@"/buyer/pay_pwd" with:@{@"user_id":kUserId,@"pay_pwd":_payPassWord.text} successBlock:^(NSDictionary *dic) {
        BindingPhoneViewController  * view = [[BindingPhoneViewController alloc] init];
        view.type = _type;
        view.buyer = _buyer;
        view.shopModel = _shopModel;
        [self.navigationController pushViewController:view animated:YES];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:@"支付密码错误"];
    } errorBlock:^(NSError * error) {
        [HUDManager showWarningWithError:error];
    }];
}
@end
