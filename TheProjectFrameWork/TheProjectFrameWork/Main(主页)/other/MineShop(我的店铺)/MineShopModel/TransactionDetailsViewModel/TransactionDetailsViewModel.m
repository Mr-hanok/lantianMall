//
//  TransactionDetailsViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "TransactionDetailsViewModel.h"
#import "TransactionDetailsModel.h"

@implementation TransactionDetailsViewModel
{
    NSMutableDictionary * _params;
    NSInteger currentPage;
}
- (void)getTransactionDetailsCompleteHandle:(completeBlock)block
{
    currentPage = 1;
    _params = [@{@"user_id":kUserId,@"type":@(1),@"balance_type":@(2),@"begin":@(currentPage)} mutableCopy];
    [NetWork PostNetWorkWithUrl:@"/my_balance" with:_params successBlock:^(NSDictionary *dic) {
        _dataArray = [TransactionDetailsModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        _dataArray = nil;
        block(msg);
    } errorBlock:^(id error) {
        _dataArray = nil;
        block(error);
    }];
}
- (void)getTransactionDetailsPageCompleteHandle:(completeBlock)block
{
    [_params setObject:@(currentPage) forKey:@"begin"];
    [NetWork PostNetWorkWithUrl:@"/my_balance" with:_params successBlock:^(NSDictionary *dic) {
        _dataArray = [TransactionDetailsModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        _dataArray = nil;
        block(msg);
    } errorBlock:^(id error) {
        _dataArray = nil;
        block(error);
    }];
}
@end
