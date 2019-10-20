//
//  MineAccountBalanceViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineAccountBalanceViewModel.h"
#import "AccountBalanceModel.h"
@implementation MineAccountBalanceViewModel
{
    NSInteger role;
    NSInteger balanceType;
    NSInteger currentPage;
}
- (void)getMineAccountBalanceDataWithBuyer:(BOOL)buyer type:(NSInteger)type complete:(completeBlock)block
{
    // balance_type = 1 买家
    // balance_type = 2 卖家
    // type = 1 收入
    // type = 2 支出
    // type = 0 全部
    if(buyer)
    {
        role = 1;
    }else
    {
        role = 2;
//        if(type == 1)
//        {
//            type = 2;
//        }else if(type == 2)
//        {
//            type = 1;
//        }
    }
    currentPage = 1;
    balanceType = type;
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍候"];
    [NetWork PostNetWorkWithUrl:@"/my_balance" with:@{@"user_id":kUserId,@"type":@(type),@"balance_type":@(role),@"begin":@(currentPage)} successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        _balanceArray = [[AccountBalanceModel mj_objectArrayWithKeyValuesArray:dic[@"data"]] copy];
        _balance = [dic[@"balance"] doubleValue];
        if (buyer)
        {
            [UserAccountManager shareUserAccountManager].userModel.accountBalance = dic[@"balance"];
            [[UserAccountManager shareUserAccountManager] saveAccountDefaults];
        }
        currentPage++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        _balanceArray = nil;
        block(msg);
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        _balanceArray = nil;
        block(nil);
    }];
}

- (void)getMineAccountGoldDataWithType:(NSInteger)type complete:(completeBlock)block
{
    // type = 1 收入      type = 2 支出        type = 0 全部
    currentPage = 1;
    balanceType = type;
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍候"];
    [NetWork PostNetWorkWithUrl:@"/my_gold" with:@{@"user_id":kUserId,@"type":@(type),@"begin":@(currentPage)} successBlock:^(NSDictionary *dic) {
        _balanceArray = [[AccountBalanceModel mj_objectArrayWithKeyValuesArray:dic[@"data"]] copy];
        currentPage ++;
        [HUDManager hideHUDView];
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
        [HUDManager hideHUDView];
    } errorBlock:^(id error) {
        block(nil);
        [HUDManager hideHUDView];
    }];
}

@end
