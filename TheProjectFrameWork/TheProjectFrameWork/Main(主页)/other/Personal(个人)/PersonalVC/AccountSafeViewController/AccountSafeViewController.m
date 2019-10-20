//
//  AccountSafeViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  账户安全页面

#import "AccountSafeViewController.h"
#import "RegisterTableViewCell.h"
#import "ChangePhoneOptionsViewController.h"
#import "MineAccountPopView.h"
#import "ChangePayPwdOptionViewController.h"
#import "NSString+HidePhone.h"
#import "CountDownButton.h"
#import "AccountCellModel.h"

static NSString * accountSafeCell = @"accountSafeCell";

typedef NS_ENUM(NSInteger , AccountSafeOptions){
    /**
     *  登录密码
     */
    AccountSafeOptionLoginPwd = 0,
    /**
     *  手机号
     */
    AccountSafeOptionPhone = 1,
    /**
     *  支付密码
     */
    AccountSafeOptionPayPwd = 2,
    /**
     *  邮箱验证
     */
    AccountSafeOptionEmail = 3,
}
;
@interface AccountSafeViewController ()<UITableViewDelegate,UITableViewDataSource,MineAccountPopViewDelegate>

@property (nonatomic , weak) UITableView * accountSafeTableView;

@property (nonatomic , strong) NSArray * dataArray;
@end
@implementation AccountSafeViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.accountSafeTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"账户安全"];
}
#pragma mark - event Respond

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:accountSafeCell];
    
    [cell setText:self.dataArray[indexPath.row][@"title"] detailText:self.dataArray[indexPath.row][@"detail"] phone:self.dataArray[indexPath.row][@"phone"]];

    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kScaleHeight(80);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class vc;
    switch (indexPath.row) {
        case AccountSafeOptionLoginPwd:
            {
                vc = NSClassFromString(@"ChangeLoginPwdOptionViewController");
            }
            break;
        case AccountSafeOptionPhone:
            {
                if([UserAccountManager shareUserAccountManager].userModel.mobile.length == 0)
                {
                    AccountPhonePopView * phoneView = [[AccountPhonePopView alloc] init];
                    phoneView.delegate = self;
                    [phoneView displayFromWindow];
                }else
                {
                    ChangePhoneOptionsViewController * vc = [[ChangePhoneOptionsViewController alloc] init];
                    vc.type = PopVerifyTypesPhone;
                    vc.buyer = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }

            }
            break;
            case AccountSafeOptionPayPwd:
            {
                // 根据是否有支付密码 判断是否新建密码
                if([UserAccountManager shareUserAccountManager].userModel.isPayPassWord)
                {
                ChangePayPwdOptionViewController * vc = [[ChangePayPwdOptionViewController alloc] init];
//                    vc.buyer = YES;
//                    vc.type = PopVerifyTypesPhone;
                    [self.navigationController pushViewController:vc animated:YES];
                }else
                {
                    vc = NSClassFromString(@"FoundPayPwdViewController");
                }
                
            }
            break;
        case AccountSafeOptionEmail:
        {
            if([UserAccountManager shareUserAccountManager].userModel.email.length == 0)
            {
                AccountEmailPopView * emailView = [[AccountEmailPopView alloc] init];
                emailView.delegate = self;
                [emailView displayFromWindow];
            }else
            {
                ChangePhoneOptionsViewController * vc = [[ChangePhoneOptionsViewController alloc] init];
                vc.buyer = YES;
                vc.type = PopVerifyTypesEmail;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        default:
            break;
    }
   if(vc) [self.navigationController pushViewController:[vc new] animated:YES];
}
#pragma mark - popviewDelegate
/**
 *  获取验证码
 *
 *  @param popView <#popView description#>
 *  @param sender  <#sender description#>
 */
- (void)accountPop:(id)popView GetCode:(CountDownButton *)sender
{
    
}

/**
 *  点击确定
 *
 *  @param popView <#popView description#>
 *  @param info    <#info description#>
 */
- (void)accountPop:(MineAccountPopView *)popView SaveInfo:(AccountCellModel *)info
{
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍等"];
    /**绑定邮箱*/
    [NetWork PostNetWorkWithUrl:@"/buyer/bind_email" with:@{@"user_id":kUserId,@"email":info.prompt} successBlock:^(NSDictionary *dic) {
        [UserAccountManager shareUserAccountManager].userModel.email = info.prompt;
        [HUDManager showWarningWithText:@"修改信息成功"];
        [popView removeFromWindow];
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(NSError *error) {
        [HUDManager showWarningWithError:error];
    }];
    
}
#pragma mark - getter and setter
- (UITableView *)accountSafeTableView
{
    if(!_accountSafeTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview registerClass:[RegisterTableViewCell class] forCellReuseIdentifier:accountSafeCell];
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        __weak typeof(self) weakSelf = self;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        _accountSafeTableView = tableview;
    }
    return _accountSafeTableView;
}
- (NSArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = @[@{@"title":@"登录密码",@"detail":@"*建议您定期更改密码以保护账户安全",@"phone":@""},
  @{@"title":@"手机验证",@"detail":@"*建议您的认证手机已丢失或停用，请立即修改更正",@"phone":[UserAccountManager shareUserAccountManager].userModel.mobile?[NSString hidePhone:[UserAccountManager shareUserAccountManager].userModel.mobile]:@""},
  @{@"title":@"支付密码",@"detail":@"*建议您定期更改支付密码以保护账户安全",@"phone":@"",},
  /**@{@"title":@"邮箱认证",@"detail":@"*若您的认证信箱已停用，请立即修改更换",@"phone":@""}*/
        /*,@{@"title":@"子账户管理",@"detail":@"*建议您定期更改密码以保护账户安全",@"phone":@""}*/];
    }
    return _dataArray;
}
@end
