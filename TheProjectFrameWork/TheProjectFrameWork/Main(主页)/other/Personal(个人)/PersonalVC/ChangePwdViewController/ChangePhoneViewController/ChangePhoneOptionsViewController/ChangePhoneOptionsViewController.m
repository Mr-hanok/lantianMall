//
//  ChangePhoneOptionsViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ChangePhoneOptionsViewController.h"
#import "DefaultTableViewCell.h"
#import "TableViewPromptHeaderView.h"
#import "PopVerifyView.h"
#import "IdentityAuthViewController.h"
#import "BindingPhoneViewController.h"
#import "MineShopAccountModel.h"
#import "ZPYVerifyContactsSingle.h"
static NSString * tableviewCellId = @"tableviewCellId";
@interface ChangePhoneOptionsViewController ()<UITableViewDelegate,UITableViewDataSource,PopVerifyViewDelegate>
@property (nonatomic , weak) UITableView * changePhoneTableView;
@property (nonatomic , strong) NSArray * dataArray;
@end
@implementation ChangePhoneOptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.changePhoneTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:_type?@"修改绑定邮箱":@"修改绑定手机"];
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScaleHeight(44);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableviewCellId];
    [cell loadWithTitle:self.dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row)
    {// 不能接受验证码
        if(_buyer)
        {
            if(![UserAccountManager shareUserAccountManager].userModel.isPayPassWord)
            {
                [HUDManager showWarningWithText:@"未设置支付密码"];
                return;
            }
            
        }else
        {
            if(!_shopUserModel.isPay)
            {
                [HUDManager showWarningWithText:@"未设置支付密码"];
                return;
            }
        }
        IdentityAuthViewController * view = [[IdentityAuthViewController alloc] init];
        view.type = _type;
        view.buyer = _buyer;
        view.shopModel = _shopUserModel;
        [self.navigationController pushViewController:view animated:YES];
    }else
    {// 可以接受验证码
        NSString * sender = nil;
        if(_buyer)
        {
            if(_type)
            {
                if([UserAccountManager shareUserAccountManager].userModel.email.length == 0)
                {
                    [HUDManager showWarningWithText:@"未设置邮箱"];
                    return;
                }
                sender = [UserAccountManager shareUserAccountManager].userModel.email;
            }else
            {
                if([UserAccountManager shareUserAccountManager].userModel.mobile == 0)
                {
                    [HUDManager showWarningWithText:@"未设置手机号"];
                    return;
                }
                sender = [UserAccountManager shareUserAccountManager].userModel.mobile;
            }
        }else
        {
            if(_type)
            {
                if(_shopUserModel.store_email == 0)
                {
                    [HUDManager showWarningWithText:@"未设置邮箱"];
                    return;
                }
                sender = _shopUserModel.store_email;
            }else
            {
                if(_shopUserModel.store_telephone == 0)
                {
                    [HUDManager showWarningWithText:@"未设置手机号"];
                    return;
                }
                sender = _shopUserModel.store_telephone;
            }
        }
        PopVerifyView * view = [[ZPYVerifyContactsSingle shareVerifyContacts] verifyPopViewWithKey:sender type:_type Template:_type?@"email_edit_email_notify":[[NSNumber numberWithInteger:MessageCodeTypeChangePwd]stringValue]];
        view.delegate = self;
        [view displayToWindow];
    }
}
#pragma mark - popVerifyViewDelegate

- (void)popVerifyPassWith:(PopVerifyView *)verifyView
{
    BindingPhoneViewController * binging = [[BindingPhoneViewController alloc] init];
    binging.type = verifyView.type;
    binging.buyer = _buyer;
    binging.shopModel = _shopUserModel;
    [self.navigationController pushViewController:binging animated:YES];

}

- (void)validationEmail:(NSString *)email code:(NSString *)code completed:(void (^) (BOOL successful , id error))completed
{
    [NetWork PostNetWorkWithUrl:@"/buyer/validation_email" with:@{@"email":email,@"code":code} successBlock:^(NSDictionary *dic) {
        if([dic[@"status"] boolValue])
        {
            completed (YES , nil);
        }else
        {
            completed(NO, dic[@"message"]);
        }
    } FailureBlock:^(NSString *msg) {
        completed(NO, msg);
    } errorBlock:^(id error) {
        completed(NO , error);
    }];
}
#pragma mark - getter and setter
- (UITableView *)changePhoneTableView
{
    if(!_changePhoneTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        TableViewPromptHeaderView * headerLabel = [[TableViewPromptHeaderView alloc] init]/*@"您正在修改账户支付密码,请选择修改方式."*/;
        TableViewPromptHeaderView * footerLabel = [[TableViewPromptHeaderView alloc] init/*@"如无法自助修改,请拨打人工客服400-000-5500转7,由客服协助您进行修改"*/];
        
        headerLabel.text = _type?@"您正在修改账户绑定邮箱，请选择修改方式":@"您正在修改账户绑定手机号，请选择修改方式";
        footerLabel.text = @"如无法自助修改，请拨打人工客服 400-000-5500转7，由客服协助您进行修改";
        footerLabel.attributedText = [self attributedWithOriginalString:footerLabel.text];
        headerLabel.frame = (CGRect){0,0,0,headerLabel.height + 10};
        footerLabel.frame = (CGRect){0,0,0,footerLabel.height + 15};
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:tableviewCellId];
        tableview.tableHeaderView = headerLabel;
        tableview.tableFooterView = footerLabel;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor clearColor];
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        
        _changePhoneTableView = tableview;
    }
    return _changePhoneTableView;
}
- (NSArray *)dataArray
{
    if(!_dataArray)
    {
        if(_type)
        {
        _dataArray = @[@"原邮箱号能接收验证码",@"原邮箱号不能接收验证码"];
        }else
        {
        _dataArray = @[@"原手机号能接收验证码",@"原手机号不能接收验证码"];
        }
        
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
