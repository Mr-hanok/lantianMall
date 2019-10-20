//
//  ChangeLoginPwdViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  修改登录密码

#import "ChangeLoginPwdViewController.h"
#import "TextFieldTableCell.h"
#import "LoginButton.h"
#import "TableViewPromptHeaderView.h"
static NSString * TextFieldTableCellId = @"TextFieldTableCell";
@interface ChangeLoginPwdViewController ()<UITableViewDelegate,UITableViewDataSource,TextFieldTableCellDelegate>
@property (nonatomic , weak) UITableView * passWordTableView;
@property (nonatomic , weak) LoginButton * finish;

@end
@interface ChangeLoginPwdViewController ()
{
    NSString * _newPassWord; ///< 新密码
    NSString * _newAgainPassWord; ///< 确认的新密码
}
@end
@implementation ChangeLoginPwdViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.passWordTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.finish];
    self.title = LaguageControl(@"修改登录密码");
}

- (void)clickFinish
{
    
    if(![NSString validatePassWord:_newPassWord])
    {
        [HUDManager showWarningWithText:@"密码长度不符合要求,请输入6-20位数字字母和特殊符号组合"];
        return;
    }
    
    if(![NSString validatePassWord:_newAgainPassWord])
    {
        [HUDManager showWarningWithText:@"密码长度不符合要求,请输入6-20位数字字母和特殊符号组合"];
        return;
    }

    [HUDManager showWarningWithText:@"请稍候"];
    [NetWork PostNetWorkWithUrl:@"/reset_password" with:@{@"newPassword":_newPassWord,@"bak_reset_type":@(1),@"user_id":kUserId} successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:dic[@"message"]];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:error];
    }];
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableCell * cell = [tableView dequeueReusableCellWithIdentifier:TextFieldTableCellId];
    cell.delegate = self;
    if(indexPath.row)
    {
        [cell loadTextFieldTag:101 placeholder:@"确定登录密码"];
    }else
    {
        [cell loadTextFieldTag:100 placeholder:@"新登录密码"];
    }

    return cell;
}
- (void)textFieldValueChange:(UITextField *)textField
{
    if(textField.tag == 100)
    {
        _newPassWord = textField.text;
    }else
    {
        _newAgainPassWord = textField.text;
    }
    [self.finish settingButtonSelectWithSelected:(_newPassWord.length >= 6 && [_newPassWord isEqualToString:_newAgainPassWord])];

}
#pragma getter and setter
- (UITableView *)passWordTableView
{
    if(!_passWordTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.bounces = NO;
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview registerClass:[TextFieldTableCell class] forCellReuseIdentifier:TextFieldTableCellId];
        tableview.rowHeight = kScaleHeight(40);
        
        TableViewPromptHeaderView * headerLabel = [[TableViewPromptHeaderView alloc] init];
        headerLabel.text = @"设置登录密码可以保证您的账户安全";
        TableViewPromptHeaderView * footerLabel = [[TableViewPromptHeaderView alloc] init];
        footerLabel.text = @"请输入6-20个英文字母/数字/符号";
        CGRect headerRect = (CGRect){0,0,0,headerLabel.height + 10};
        CGRect footerRect = (CGRect){0,0,0,footerLabel.height + 15};
        headerLabel.frame = headerRect;
        footerLabel.frame = footerRect;
        tableview.tableHeaderView = headerLabel;
        tableview.tableFooterView = footerLabel;
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        _passWordTableView = tableview;
    }
    return _passWordTableView;
}
- (LoginButton *)finish
{
    if(!_finish)
    {
        __weak typeof(self) weakSelf = self;
        LoginButton * sender = [[LoginButton alloc] initWithActionBlock:^(id sender) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf clickFinish];
        } title:@"完成"];
        [self.view addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
            make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
            make.height.mas_equalTo(kScaleHeight(40));
            make.centerY.equalTo(weakSelf.view);
        }];
        _finish = sender;
    }
    return _finish;
}
@end
