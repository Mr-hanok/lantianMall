//
//  MineRechargeManagerViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineRechargeManagerViewModel.h"
#import "RechargeManagerModel.h"

@implementation MineRechargeManagerViewModel
{
    NSMutableDictionary * _params;
    NSInteger currentPage;
}
- (void)getMineRechargeManagerWithRole:(NSInteger)role completeHandle:(completeBlock)block
{
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍候"];
    currentPage = 1;
    _params = [@{@"user_id":kUserId,@"type":@(1),@"balance_type":@(role),@"begin":@(currentPage)} mutableCopy];
    [NetWork PostNetWorkWithUrl:@"/my_balance" with:_params successBlock:^(NSDictionary * dic) {
        NSArray * dataArray = [RechargeManagerModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        _dataArray = [dataArray mutableCopy];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString * msg) {
        _dataArray = nil;
        block(msg);
    } errorBlock:^(NSError * error) {
        _dataArray = nil;
        block(error);
    }];
}
- (void)getMineRechargeManagerPageCompleteHandle:(completeBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/my_balance" with:_params successBlock:^(NSDictionary * dic) {
        NSArray * dataArray = [RechargeManagerModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [_dataArray addObjectsFromArray:dataArray];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString * msg) {
        block(msg);
    } errorBlock:^(NSError * error) {
        block(error);
    }];
}
@end
