//
//  MineWalletViewController.m
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineWalletViewController.h"
#import "MineWalletCell.h"
#import "MineBalanceViewController.h"
#import "ShopModel.h"
#import "MineRechargeManagerViewController.h"
#import "MineRebateViewController.h"
#import "AccoutTiXianManagerController.h"

static NSString * MineWalletCellId = @"MineWalletCell";
@interface MineWalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , weak) UITableView * walletTableView;
@end

@implementation MineWalletViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"账户余额";
    [self.walletTableView reloadData];
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(!_buyer && !_model.goldRechargeSwitch)
//    {
//        return 2;
//    }
//    return 3;
    if(!_buyer && !_model.goldRechargeSwitch)
    {
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:MineWalletCellId];
    MineWalletOptions option = indexPath.row;
    switch (option) {
        case 0:
            cell.image = [UIImage imageNamed:@"yue"];
            cell.title = @"账户余额";
            cell.value = [NSString stringWithFormat:@"%.2f",_buyer?([[UserAccountManager shareUserAccountManager].userModel.accountBalance doubleValue]):self.model.blance];
            break;
        case 1:
        {
            if(!_buyer && !_model.goldRechargeSwitch)
            {
                cell.image = [UIImage imageNamed:@"chongzhi"];
                cell.title = @"充值管理";
            }else
            {
                cell.image = [UIImage imageNamed:@"chongzhi"];
                cell.title = @"充值管理";
//                cell.image = [UIImage imageNamed:@"fanli"];
//                cell.title = _buyer?@"我的返利":@"账户金币";
//                cell.value = [NSString stringWithFormat:@"%.2f",_buyer?[UserAccountManager shareUserAccountManager].userModel.rebateTotal:self.model.glod];
            }
        }
            
            break;
        case 2:
            cell.image = [UIImage imageNamed:@"chongzhi"];
            cell.title = @"提现管理";
            break;
            
        default:
            cell.image = [UIImage imageNamed:@"jiaoyimingxi"];
            cell.title = @"交易明细";
            break;
    }
    [cell updateConstraintsIfNeeded];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineWalletOptions option = indexPath.row;
    UIViewController * controller;
    switch (option) {
        case 0:
        {
            MineBalanceViewController * balance = [[MineBalanceViewController alloc] init];
            balance.type = 1;
            balance.shopmodel = self.model;
            balance.buyer = _buyer;
            controller = balance;
        }
            
            break;
        case 1:
        {
            if(!_buyer)
            {
//                if(!self.model.goldRechargeSwitch)
//                {
//                    MineRechargeManagerViewController * view = [MineRechargeManagerViewController new];
//                    view.role = _buyer?1:2;
//                    controller = view;
//                }else
//                {
//                   
//                    MineBalanceViewController * balance = [[MineBalanceViewController alloc] init];
//                    balance.type = 2;
//                    balance.shopmodel = self.model;
//                    balance.buyer = _buyer;
//                    controller = balance;
//                }
                
                MineRechargeManagerViewController * view = [MineRechargeManagerViewController new];
                view.role = _buyer?1:2;
                controller = view;

                
            }else
            {
                MineRechargeManagerViewController * view = [MineRechargeManagerViewController new];
                view.role = _buyer?1:2;
                controller = view;
//                MineRebateViewController * view = [[MineRebateViewController alloc] init];
//                controller = view;
            }
        }
            break;
        case 2:
        {
            /**提现管理*/
            AccoutTiXianManagerController * view = [AccoutTiXianManagerController new];
            view.role = _buyer?1:2;
            controller = view;
        }
            
            break;
        default:
        {
        }
            break;
    }
    if(controller)
    {
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark - setter and getter
- (UITableView *)walletTableView
{
    if(!_walletTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        tableview.rowHeight = kScaleHeight(80);
        [tableview registerClass:[MineWalletCell class] forCellReuseIdentifier:MineWalletCellId];
        [self.view addSubview:tableview];
        __weak typeof(self) weakSelf = self;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view.mas_top).mas_offset(weakSelf.topLayoutGuide.length);
        }];
        _walletTableView = tableview;
    }
    return _walletTableView;
}
@end
