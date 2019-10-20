//
//  OldPwdChangeLoginPwdViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OldPwdChangeLoginPwdViewController.h"
#import "TextFieldTableCell.h"
#import "LoginButton.h"
#import "TableViewPromptHeaderView.h"
static NSString * cellId = @"textFieldCell";
@interface OldPwdChangeLoginPwdViewController ()<UITableViewDelegate,UITableViewDataSource,TextFieldTableCellDelegate>

@property (nonatomic , weak) UITableView * passWordTableView;

@property (nonatomic , weak) LoginButton * changePwdButton;


@end

@interface OldPwdChangeLoginPwdViewController ()
{
    NSString * _oldPassWord; ///< 原密码
    NSString * _newPassWord; ///< 新密码
    NSString * _newAgainPassWord; ///< 确认的新密码
}
@end

@implementation OldPwdChangeLoginPwdViewController

#pragma mark - lift cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.passWordTableView reloadData];
    [self.changePwdButton settingButtonSelectWithSelected:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"修改登录密码";
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.delegate = self;
    switch (indexPath.row) {
        case OldPwdChangePwdOptionOldPwd:
           [cell loadTextFieldTag:OldPwdChangePwdOptionOldPwd placeholder:@"原登录密码"];
            break;
        case OldPwdChangePwdOptionNewPwd:
            [cell loadTextFieldTag:OldPwdChangePwdOptionNewPwd placeholder:@"新登录密码"];
            break;
        case OldPwdChangePwdOptionNewAgain:
            [cell loadTextFieldTag:OldPwdChangePwdOptionNewAgain placeholder:@"确定登录密码"];
            break;
        default:
            break;
    }
    return cell;
}
#pragma mark - TextFieldTableCellDelegate
- (void)textFieldValueChange:(UITextField *)textField
{
    switch (textField.tag) {
        case OldPwdChangePwdOptionOldPwd:
            _oldPassWord = textField.text;
            break;
        case OldPwdChangePwdOptionNewPwd:
            _newPassWord = textField.text;
            break;
        case OldPwdChangePwdOptionNewAgain:
            _newAgainPassWord = textField.text;
            break;
        default:
            break;
    }
    if((_oldPassWord.length >= 6 && _newAgainPassWord.length >= 6 && _newAgainPassWord.length >= 6 ))
    {
        [self.changePwdButton settingButtonSelectWithSelected:YES];
    }else
    {
        [self.changePwdButton settingButtonSelectWithSelected:NO];
    }
}

#pragma mark - event respond
/**
 *  修改密码方法
 */
- (void)changeLoginPassWord
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


    if (![_newPassWord isEqualToString:_newAgainPassWord]) {
        [HUDManager showWarningWithText:@"两次密码输入不一致,请重新输入"];
        return;
    }
    [HUDManager showWarningWithText:@"请稍候"];
    [NetWork PostNetWorkWithUrl:@"/reset_password" with:@{@"newPassword":_newPassWord,@"oldPassword":_oldPassWord,@"bak_reset_type":@(3),@"user_id":@([UserAccountManager shareUserAccountManager].userModel.userId)} successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:dic[@"message"]];
        //  修改成功
        [self.navigationController popToRootViewControllerAnimated:YES];
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:error];
    }];
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
        [tableview registerClass:[TextFieldTableCell class] forCellReuseIdentifier:cellId];
        tableview.rowHeight = kScaleHeight(44);
        NSString * footerText = [NSString stringWithFormat:@"%@",LaguageControl(@"请输入6-20个英文字母/数字/符号")];
        TableViewPromptHeaderView * footerLabel = [[TableViewPromptHeaderView alloc] init];
        footerLabel.text = footerText;
        footerLabel.frame = (CGRect){0,0,0,footerLabel.height + 10};
        tableview.tableHeaderView = footerLabel;
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        _passWordTableView = tableview;
    }
    return _passWordTableView;
}
- (LoginButton *)changePwdButton
{
    if(!_changePwdButton)
    {
        __weak typeof(self) weakSelf = self;
        LoginButton * button = [[LoginButton alloc] initWithActionBlock:^(id sender) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf changeLoginPassWord];
        } title:@"修改密码"];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
            make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
            make.bottom.equalTo(weakSelf.view.mas_bottom).mas_offset(-kScaleHeight(12));
            make.height.mas_equalTo(kScaleHeight(40));
        }];
        _changePwdButton = button;
    }
    return _changePwdButton;
}
@end
