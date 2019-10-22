//
//  FindPwdOptionsViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "FindPwdOptionsViewController.h"
#import "TableViewPromptHeaderView.h"
#import "DefaultTableViewCell.h"
static NSString * DefaultTableViewCellID = @"DefaultTableViewCell";
@interface FindPwdOptionsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) UITableView * findPwdOptinsTableView;

@end
@implementation FindPwdOptionsViewController
{
    NSInteger type;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.findPwdOptinsTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"选择找回方式"];
}
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScaleHeight(44);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DefaultTableViewCellID];
    if(indexPath.row)
    {
        [cell loadWithTitle:[LaguageControl languageWithString:@"通过邮箱找回登录密码"]];
    }else
    {
        [cell loadWithTitle:[LaguageControl languageWithString:@"通过手机号找回登录密码"]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserModel * nowUser = nil;
    
    if([UserAccountManager shareUserAccountManager].loginStatus)
    {
        nowUser = [UserAccountManager shareUserAccountManager].userModel;
    }else
    {
        nowUser = _user;
    }
    if(indexPath.row)
    {// 邮箱方式
        if(nowUser.email.length == 0)
        {
            [HUDManager showWarningWithText:@"该账户未绑定邮箱"];
        }else
        {
            type = 1;
            [self sendEmail];
        }
    }else
    {// 手机号方式
        if(nowUser.mobile.length == 0)
        {
            [HUDManager showWarningWithText:@"该账户未绑定手机号"];
        }else
        {
            type = 2;
            [self sendPhone];
        }
    }

}
- (void)sendEmail
{
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
    UserModel * nowUser = nil;

    if([UserAccountManager shareUserAccountManager].loginStatus)
    {
        nowUser = [UserAccountManager shareUserAccountManager].userModel;
    }else
    {
        nowUser = _user;
    }
    [NetWork PostNetWorkWithUrl:@"/sendEmail" with:@{@"email":nowUser.email,@"type":@"email_edit_loginpwd_notify"} successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        [self performSegueWithIdentifier:@"findPassWord" sender:dic[@"message"]];
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:error];
    }];

}
- (void)sendPhone
{
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
    UserModel * nowUser = nil;
    if([UserAccountManager shareUserAccountManager].loginStatus)
    {
        nowUser = [UserAccountManager shareUserAccountManager].userModel;
    }else
    {
        nowUser = _user;
    }
//    [NetWork PostNetWorkWithUrl:@"/send_mobile_message" with:@{@"mobile":[nowUser.mobile stringByReplacingOccurrencesOfString:@"+" withString:@""],@"type":@"sms_edit_loginpwd__notify"} successBlock:^(NSDictionary *dic) {
//        [HUDManager hideHUDView];
//        [self performSegueWithIdentifier:@"findPassWord" sender:nil];
//    } FailureBlock:^(NSString *msg) {
//        [HUDManager showWarningWithError:msg];
//    } errorBlock:^(id error) {
//        [HUDManager showWarningWithError:error];
//    }];
    
    [NetWork PostNetWorkSendMessageWith:MessageCodeTypeChangePwd mobile:[nowUser.mobile stringByReplacingOccurrencesOfString:@"+" withString:@""]  successBlock:^(NSDictionary *dic) {
        [self performSegueWithIdentifier:@"findPassWord" sender:nil];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        
    }];
    
//    [NetWork PostNetWorkWithUrl:@"/getMsgCode" with:@{@"phone":[nowUser.mobile stringByReplacingOccurrencesOfString:@"+" withString:@""]} successBlock:^(NSDictionary *dic) {
//        [HUDManager hideHUDView];
//        [self performSegueWithIdentifier:@"findPassWord" sender:nil];
//    } FailureBlock:^(NSString *msg) {
//        [HUDManager hideHUDView];
//        [HUDManager showWarningWithError:msg];
//    } errorBlock:^(id error) {
//        [HUDManager hideHUDView];
//        [HUDManager showWarningWithError:error];
//    }];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"findPassWord"])
    {
        id vc = segue.destinationViewController;
        [vc setValue:_user forKeyPath:@"user"];
        [vc setValue:@(type) forKeyPath:@"type"];
        [vc setValue:sender forKey:@"code"];
    }
}
#pragma mark private Method
/**
 *  把字符串中数字的颜色改变
 *
 *  @return <#return value description#>
 */
- (NSMutableAttributedString *)attributedWithOriginalString:(NSString *)originalString
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:originalString];
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"-"];
    for (NSInteger i = 0; i < originalString.length; i++) {
        NSString * t = [originalString substringWithRange:NSMakeRange(i, 1)];
        if([number containsObject:t])
        {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:kNavigationColor} range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}

#pragma mark - setter and getter
- (UITableView *)findPwdOptinsTableView
{
    if(!_findPwdOptinsTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        TableViewPromptHeaderView * headerLabel = [[TableViewPromptHeaderView alloc] init]/*@"您正在修改账户支付密码,请选择修改方式."*/;
        TableViewPromptHeaderView * footerLabel = [[TableViewPromptHeaderView alloc] init/*@"如无法自助修改,请拨打人工客服400-000-5500转7,由客服协助您进行修改"*/];
        headerLabel.text = @"您正在找回账户密码，请选择找回方式。";
        footerLabel.text = @"如无法自助修改，请拨打人工客服 400-000-5500转7，由客服协助您进行修改";
        footerLabel.attributedText = [self attributedWithOriginalString:footerLabel.text];
        headerLabel.frame = (CGRect){0, 0, 0, headerLabel.height + 10};
        footerLabel.frame = (CGRect){0, 0, 0, footerLabel.height + 15};
        
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:DefaultTableViewCellID];
        tableview.tableHeaderView = headerLabel;
        tableview.tableFooterView = footerLabel;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor clearColor];
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
    }
    return _findPwdOptinsTableView;
}
@end
