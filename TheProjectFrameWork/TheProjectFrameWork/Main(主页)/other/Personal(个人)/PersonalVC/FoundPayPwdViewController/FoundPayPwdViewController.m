//
//  FoundPayPwdViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "FoundPayPwdViewController.h"
#import "TableViewPromptHeaderView.h"
#import "DefaultTableViewCell.h"
#import "PopVerifyView.h"
#import "SetPayPassWordViewController.h"
#import "ZPYVerifyContactsSingle.h"
//#import "VerifyContactsSingle.h"
static NSString * DefaultTableViewCellId = @"DefaultTableViewCell";
@interface FoundPayPwdViewController ()<UITableViewDelegate,UITableViewDataSource,PopVerifyViewDelegate>
@property (nonatomic , weak) UITableView * foundPayPwdTableView;

@end
@implementation FoundPayPwdViewController
#pragma mark - lift cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.foundPayPwdTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"创建支付密码");
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DefaultTableViewCellId];
    if(indexPath.row)
    {
//        [cell loadWithTitle:@"通过邮箱创建支付密码"];

    }else
    {
        [cell loadWithTitle:@"通过手机号创建支付密码"];

    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString * senderStr = indexPath.row?[UserAccountManager shareUserAccountManager].userModel.email:[UserAccountManager shareUserAccountManager].userModel.mobile;
    
    if([senderStr isKindOfClass:[NSNull class]] || senderStr.length == 0)
    {
        
        if(indexPath.row)
        {
            [HUDManager showWarningWithText:@"未设置邮箱"];
        }else
        {
            [HUDManager showWarningWithText:@"未设置手机号"];
        }
        return;
    }

    PopVerifyView * pop = [[ZPYVerifyContactsSingle shareVerifyContacts] verifyPopViewWithKey:senderStr type:indexPath.row Template:[[NSNumber numberWithInteger:MessageCodeTypeChangePayPwd] stringValue]];

//    PopVerifyView * pop = [[ZPYVerifyContactsSingle shareVerifyContacts] verifyPopViewWithKey:senderStr type:indexPath.row Template:@"email_create_pay_password_notify"];
    pop.delegate = self;
    [pop displayToWindow];
    
}

/**
 *  验证通过
 */
- (void)popVerifyPassWith:(PopVerifyView *)verifyView
{
    SetPayPassWordViewController * setPayPwd = [[SetPayPassWordViewController alloc] init];
    setPayPwd.buyer = YES;
    setPayPwd.isCreat = YES;
    setPayPwd.code = verifyView.text;
    [self.navigationController pushViewController:setPayPwd animated:YES];
    
}



#pragma mark - setter and getter
- (UITableView *)foundPayPwdTableView
{
    if(!_foundPayPwdTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        tableview.backgroundColor = [UIColor clearColor];
        TableViewPromptHeaderView * headerLabel = [[TableViewPromptHeaderView alloc] init];
        headerLabel.text = @"您正在创建账户支付密码,请选择创建方式";
        headerLabel.frame = (CGRect){0,0,0,headerLabel.height + 10};
        tableview.tableHeaderView = headerLabel;
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:DefaultTableViewCellId];
        [self.view addSubview:tableview];
        _foundPayPwdTableView = tableview;
    }
    return _foundPayPwdTableView;
}
@end
