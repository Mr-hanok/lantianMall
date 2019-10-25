//
//  ChangeLoginPwdOptionViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ChangeLoginPwdOptionViewController.h"
#import "DefaultTableViewCell.h"
#import "PopVerifyView.h"
#import "TableViewPromptHeaderView.h"
#import "ZPYVerifyContactsSingle.h"
#import "ChangeLoginPwdViewController.h"
static NSString * optionCell = @"ChangeOptionCell";
@interface ChangeLoginPwdOptionViewController ()<UITableViewDelegate,UITableViewDataSource,PopVerifyViewDelegate>
@property (nonatomic , weak) UITableView * optionTableView;

@property (nonatomic , strong) NSArray * options;
@end

@implementation ChangeLoginPwdOptionViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.optionTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"修改登录密码";
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.options.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:optionCell];
    [cell loadWithTitle:self.options[indexPath.row]];
    if (indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 0;
    }
    return kScaleHeight(44);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case ChangeLoginPwdOptionsPhone:
        {
            if([UserAccountManager shareUserAccountManager].userModel.mobile)
            {
                PopVerifyView * view = [[ZPYVerifyContactsSingle shareVerifyContacts] verifyPopViewWithKey:[UserAccountManager shareUserAccountManager].userModel.mobile type:PopVerifyTypesPhone Template:                [[NSNumber numberWithInteger:MessageCodeTypeChangePwd]stringValue]];
                view.delegate = self;
                [view displayToWindow];
            }else
            {
               [HUDManager showWarningWithText:@"没设置手机号"];
            }
          
        }
            break;
        case ChangeLoginPwdOptionsEmail:
        {
            if([UserAccountManager shareUserAccountManager].userModel.email)
            {
                PopVerifyView * view = [[ZPYVerifyContactsSingle shareVerifyContacts] verifyPopViewWithKey:[UserAccountManager shareUserAccountManager].userModel.email type:PopVerifyTypesEmail Template:@"email_edit_loginpwd_notify"];
                view.delegate = self;
                [view displayToWindow];
            }else
            {
                [HUDManager showWarningWithText:@"没设置邮箱"];
            }
            
        }
            break;
        case ChangeLoginPwdOptionsOldPwd:
        {
            Class vc = NSClassFromString(@"OldPwdChangeLoginPwdViewController");
            [self.navigationController pushViewController:[vc new] animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 验证delegate 

- (void)popVerifyPassWith:(PopVerifyView *)verifyView
{
    ChangeLoginPwdViewController * controller = [[ChangeLoginPwdViewController alloc] init];
    controller.phone = [UserAccountManager shareUserAccountManager].userModel.mobile;
    controller.code = verifyView.verifyCode;
    [self.navigationController pushViewController:controller animated:YES];
}




#pragma mark - getter and setter
- (UITableView *)optionTableView
{
    if(!_optionTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        TableViewPromptHeaderView * headerView = [TableViewPromptHeaderView new];
        headerView.text = @"您正在修改账户的登录密码，请选择修改方式";
        headerView.frame = (CGRect){0,0,0,headerView.height + 10};
        tableview.tableHeaderView = headerView;
        tableview.backgroundColor = [UIColor clearColor];
        tableview.tableFooterView = [UIView new];
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:optionCell];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        __weak typeof(self) weakSelf = self;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        _optionTableView = tableview;
    }
    return _optionTableView;
}
- (NSArray *)options
{
    if(!_options)
    {
        _options = @[@"通过手机号修改密码",@"通过邮箱修改密码",@"通过旧密码修改密码"];

    }
    return _options;
}
@end
