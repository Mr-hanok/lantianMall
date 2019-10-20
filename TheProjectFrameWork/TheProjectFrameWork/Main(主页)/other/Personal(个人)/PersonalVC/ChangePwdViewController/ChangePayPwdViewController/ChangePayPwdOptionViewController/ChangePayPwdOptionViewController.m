//
//  ChangePayPwdOptionViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ChangePayPwdOptionViewController.h"
#import "TableViewPromptHeaderView.h"
#import "DefaultTableViewCell.h"
#import "ForgetPayPassWordViewController.h"
#import "OldPwdChangePayViewController.h"
static NSString * changePayPwdCellId = @"changePayPwdCellId";
@interface ChangePayPwdOptionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , weak) UITableView * changePayPwdOptionTableView;
@property (nonatomic , strong) NSArray * dataArray;
@end
@implementation ChangePayPwdOptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.changePayPwdOptionTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"修改支付密码"];
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
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:changePayPwdCellId];
    [cell loadWithTitle:self.dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * controller = nil;
    if(indexPath.row)
    {// 忘记支付密码
        ForgetPayPassWordViewController * view = [[ForgetPayPassWordViewController alloc] init];
        view.role = UserRoleTypeBuyer;
        controller = view;
    }else
    {// 通过原密码修改密码
        OldPwdChangePayViewController * view = [[OldPwdChangePayViewController alloc] init];
        view.role = UserRoleTypeBuyer;
        controller = view;
    }
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - getter and setter
- (UITableView *)changePayPwdOptionTableView
{
    if(!_changePayPwdOptionTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        TableViewPromptHeaderView * headerLabel = [[TableViewPromptHeaderView alloc] init]/*@"您正在修改账户支付密码,请选择修改方式."*/;
        TableViewPromptHeaderView * footerLabel = [[TableViewPromptHeaderView alloc] init/*@"如无法自助修改,请拨打人工客服400-000-5500转7,由客服协助您进行修改"*/];
        headerLabel.text = @"您正在修改账户支付密码，请选择修改方式";
        footerLabel.text = @"如无法自助修改，请拨打人工客服 400-000-5500转7，由客服协助您进行修改";
        footerLabel.attributedText = [self attributedWithOriginalString:footerLabel.text];
        
        headerLabel.frame = (CGRect){0,0,0,headerLabel.height + 10};
        footerLabel.frame = (CGRect){0,0,0,footerLabel.height + 15};
        
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:changePayPwdCellId];
        tableview.tableHeaderView = headerLabel;
        tableview.tableFooterView = footerLabel;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor clearColor];
        tableview.separatorColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        
        _changePayPwdOptionTableView = tableview;
    }
    return _changePayPwdOptionTableView;
}
- (NSArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = @[@"通过原密码修改密码",@"忘记支付密码"];
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
