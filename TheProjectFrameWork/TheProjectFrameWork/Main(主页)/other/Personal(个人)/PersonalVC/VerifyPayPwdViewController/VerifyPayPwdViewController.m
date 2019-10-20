//
//  VerifyPayPwdViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "VerifyPayPwdViewController.h"
#import "VerifyPayInfoView.h"
#import "LoginButton.h"
#import "PopVerifyView.h"
@interface VerifyPayPwdViewController ()<PopVerifyViewDelegate>
{
    UILabel * _headerLabel;
    VerifyPayInfoView * _infoView;
    LoginButton * _verifyButton;
}
@end
@implementation VerifyPayPwdViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadViews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"请先验证身份";
}
- (void)loadViews
{
    _headerLabel = [[UILabel alloc] initWithText:@"为保障您的账户安全，请验证手机号，并确保该手机号为本人所有"];
    _headerLabel.textColor = [UIColor colorWithString:@"#a3a3a3200"];
    _headerLabel.textAlignment = NSTextAlignmentLeft;
    _headerLabel.numberOfLines = 0;
    _infoView = [[VerifyPayInfoView alloc] initWithTitle:@"邮箱账号" content:@"wodeyouxiang@*****"];
    __weak typeof(self) weakSelf = self;
    _verifyButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf verify];
    } title:@"验证"];
    [_verifyButton settingButtonSelectWithSelected:YES];
    [self.view addSubview:_headerLabel];
    [self.view addSubview:_infoView];
    [self.view addSubview:_verifyButton];
}
- (void)viewWillLayoutSubviews
{
    __weak typeof(self) weakSelf = self;
    void (^layoutBlock) (MASConstraintMaker *make) = ^(MASConstraintMaker *make){
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
    };
    [_headerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kTopSpace + kScaleHeight(8));
    }];
    [_infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.top.equalTo(_headerLabel.mas_bottom).mas_offset(kScaleHeight(5));
        
    }];
    [_verifyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_infoView.mas_bottom).mas_offset(kScaleHeight(15));
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [super viewWillLayoutSubviews];

}
#pragma mark - event respont
/**
 *  验证
 */
- (void)verify
{
    PopVerifyView * pop = [PopVerifyView creatPopVerifyWithType:PopVerifyTypesEmail sender:@"nideyouxiang@*****"];
    pop.delegate = self;
    [pop displayToWindow];
}
#pragma mark - other Delegate
/**
 *  验证通过
 */
- (void)popVerifyPassWith:(PopVerifyView *)verifyView
{
    
    Class vc = NSClassFromString(@"SetPayPassWordViewController");
    [self.navigationController pushViewController:[vc new] animated:YES];
}
/**
 *  获取验证码
 */
-(void)popVerifyGetCode:(PopVerifyView *)verifyView
{

}
@end
