//
//  MineBalanceViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  钱包余额

#import "MineBalanceViewController.h"
#import "PropertyDetailsScrollView.h"
#import "PropertyView.h"
#import "MineAccountBalanceViewModel.h"
#import "ShopModel.h"
#import "AccountRechargeViewController.h"

@interface MineBalanceViewController ()<PropertyBalanceViewDelegate,PropertyDetailsScrollViewDelegate>
@property (nonatomic , weak) PropertyBalanceView * headerView;
@property (nonatomic , weak) PropertyDetailsScrollView * contentView;
@property (nonatomic , strong) MineAccountBalanceViewModel * model;
@end
@implementation MineBalanceViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    if(_type == 1)//账户
    {
        if(_buyer)
        {
            self.headerView.value = [[UserAccountManager shareUserAccountManager].userModel.accountBalance doubleValue];
        }else
        {
            self.headerView.value = self.shopmodel.blance;
        }
        [self.model getMineAccountBalanceDataWithBuyer:_buyer type:0 complete:^(id error) {
            [HUDManager hideHUDView];
            if(error)
            {
//                [HUDManager showWarningWithError:error];
                return ;
            }else
            {
                if(_buyer)
                {
                    [UserAccountManager shareUserAccountManager].userModel.accountBalance = [NSString stringWithFormat:@"%.2lf",_model.balance];
                    self.headerView.value = [[UserAccountManager shareUserAccountManager].userModel.accountBalance doubleValue];
                    [[UserAccountManager shareUserAccountManager] saveAccountDefaults];
                }else
                {
                    self.headerView.value = _model.balance;
                    
                }
            }
            [self.contentView reloadWithArray:self.model.balanceArray withIsGold:NO];
        }];

    }
    if(_type == 2)//金币
    {
        self.headerView.value = self.shopmodel.glod;
        [self.model getMineAccountGoldDataWithType:0 complete:^(id error) {
            if(error)
            {
//                [HUDManager showWarningWithError:error];
                return ;
            }
            [self.contentView reloadWithArray:self.model.balanceArray withIsGold:YES];

        }];
    }

    self.contentView.backgroundColor = [UIColor whiteColor];
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(_type == 1)
    {
        self.title = self.headerView.title;
        if(_buyer)
        {
            self.headerView.value = [[UserAccountManager shareUserAccountManager].userModel.accountBalance doubleValue];
        }else
        {
            self.headerView.value = self.shopmodel.blance;
        }
    }
    if(_type == 2)
    {
        self.title = self.headerView.title;
        self.headerView.value = self.shopmodel.glod;
    }
}

#pragma mark - otherDelegate
- (void)propertyBalanceRechargeWithTag:(NSInteger)tag
{
    if(_type == 1)
    {
        
        if (tag == 101) {
            /**充值*/
            AccountRechargeViewController *vc = [[AccountRechargeViewController alloc]init];
            vc.FatherVC = self;
            vc.buyer = _buyer;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            /**提现*/
            [self pushWithVCClassName:@"AccountTiXianViewController" properties:nil];
        }
        
    }
    if(_type == 2)
    {
    }
  
}
- (void)propertyDetailsScrollClickWithType:(NSInteger)type
{
    
    if(_type == 1)//账户
    {
        [self.model getMineAccountBalanceDataWithBuyer:_buyer type:type complete:^(id error) {
            [self.contentView reloadWithArray:self.model.balanceArray withIsGold:NO];
        }];
    }
    if(_type == 2)//金币
    {
        [self.model getMineAccountGoldDataWithType:type complete:^(id error) {
            [self.contentView reloadWithArray:self.model.balanceArray withIsGold:YES];
        }];
    }
}
#pragma mark - setter and getter
- (PropertyBalanceView *)headerView
{
    if(!_headerView)
    {
        PropertyBalanceView * header = [[PropertyBalanceView alloc] initWithFrame:CGRectZero withTyep:_type];
        header.delegate = self;
        [self.view addSubview:header];
        __weak typeof(self) weakSelf = self;
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view.mas_top);
            make.right.left.equalTo(weakSelf.view);
            make.height.mas_equalTo(kScaleHeight(150));
        }];
        if(_type == 1)
        {
            header.title = @"账户余额";
            header.accessTitle = @"充值";
        }
        if(_type == 2)
        {
            header.title = @"金币余额";
            header.accessTitle = @"金币兑换";
        }
        _headerView = header;
    }
    return _headerView;
}
- (PropertyDetailsScrollView *)contentView
{
    if(!_contentView)
    {
        PropertyDetailsScrollView * view = [[PropertyDetailsScrollView alloc] init];
        view.delegate = self;
        [self.view addSubview:view];
        __weak typeof(self) weakSelf = self;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.left.equalTo(weakSelf.view);
            make.top.equalTo(_headerView.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        _contentView = view;
    }
    return _contentView;
}
- (MineAccountBalanceViewModel *)model
{
    if(!_model)
    {
        _model = [[MineAccountBalanceViewModel alloc] init];
    }
    return _model;
}
@end
