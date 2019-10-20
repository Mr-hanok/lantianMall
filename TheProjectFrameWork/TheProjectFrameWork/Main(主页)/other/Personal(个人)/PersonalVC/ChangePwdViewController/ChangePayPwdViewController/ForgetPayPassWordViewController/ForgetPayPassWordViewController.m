//
//  ForgetPayPassWordViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ForgetPayPassWordViewController.h"
#import "TableViewPromptHeaderView.h"
#import "DefaultTableViewCell.h"
#import "PopVerifyView.h"
#import "SetPayPassWordViewController.h"
#import "ZPYVerifyContactsSingle.h"
static NSString * ForgetPayCellID = @"ForgetPayCellID";
@interface ForgetPayPassWordViewController ()<UITableViewDelegate,UITableViewDataSource,PopVerifyViewDelegate>
@property (nonatomic , weak) UITableView * forgetPayTableView;
@property (nonatomic , strong) NSArray * dataArray;
@end
@interface ForgetPayPassWordViewController ()
{
    PopVerifyView * _popVerifyView;
}
@end
@implementation ForgetPayPassWordViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.forgetPayTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"忘记密码");
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ForgetPayCellID];
    [cell loadWithTitle:self.dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserModel * user = [UserAccountManager shareUserAccountManager].userModel;

    if(indexPath.row)
    {
        if(user.email.length == 0)
        {
            [HUDManager showWarningWithText:@"没设置邮箱"];
            return;
        }
    }else
    {
        if(user.mobile.length == 0)
        {
            [HUDManager showWarningWithText:@"没设置手机"];
            return;
        }
    }
    _popVerifyView = [[ZPYVerifyContactsSingle shareVerifyContacts] verifyPopViewWithKey:indexPath.row?user.email:user.mobile type:indexPath.row Template:indexPath.row?@"email_find_pay_password_notify":[[NSNumber numberWithInteger:MessageCodeTypeChangePwd]stringValue]];
    _popVerifyView.delegate = self;
    [_popVerifyView displayToWindow];
}

#pragma mark - popVerifyViewDelegate

- (void)popVerifyPassWith:(PopVerifyView *)verifyView
{
    SetPayPassWordViewController * setPwd = [[SetPayPassWordViewController alloc] init];
    setPwd.isCreat = NO;
    [self.navigationController pushViewController:setPwd animated:YES];
}



#pragma mark - getter and setter
- (UITableView *)forgetPayTableView
{
    if(!_forgetPayTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        TableViewPromptHeaderView * headerLabel = [[TableViewPromptHeaderView alloc] init]/*@"您正在修改账户支付密码,请选择修改方式."*/;
        TableViewPromptHeaderView * footerLabel = [[TableViewPromptHeaderView alloc] init/*@"如无法自助修改,请拨打人工客服400-000-5500转7,由客服协助您进行修改"*/];
        headerLabel.text = @"您正在修改账户支付密码，请选择修改方式";
        footerLabel.text = @"如无法自助修改，请拨打人工客服 400-000-5500转7，由客服协助您进行修改";
        footerLabel.attributedText = [self attributedWithOriginalString:footerLabel.text];
        headerLabel.frame = (CGRect){0,0,0,headerLabel.height + 10};
        footerLabel.frame = (CGRect){0,0,0,footerLabel.height + 10};
        
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:ForgetPayCellID];
        tableview.tableHeaderView = headerLabel;
        tableview.tableFooterView = footerLabel;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor clearColor];
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        
        _forgetPayTableView = tableview;
    }
    return _forgetPayTableView;
}
- (NSArray *)dataArray
{
    if(!_dataArray)
    {
//        _dataArray = @[@"通过手机号找回支付密码",@"通过邮箱找回支付密码"];
        _dataArray = @[@"通过手机号找回支付密码"];
    }
    return _dataArray;
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
@end
