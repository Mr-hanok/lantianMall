//
//  MineShopRefundViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopRefundViewModel.h"
#import "ShopRefundModel.h"
@implementation MineShopRefundViewModel
{
    NSInteger currentPage;
}
- (void)getMineShopRefundDataCompleteHandle:(completeBlock)block
{
    currentPage = 1;
    [NetWork PostNetWorkWithUrl:@"/buyer/refund" with:@{@"user_id":kUserId,@"currentPage":@(currentPage)} successBlock:^(NSDictionary *dic) {
        _refundList = [ShopRefundModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)getPageShopRefundDataCompleteHandle:(completeBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/buyer/refund" with:@{@"user_id":kUserId,@"currentPage":@(currentPage)} successBlock:^(NSDictionary *dic) {
        NSArray * tempArray = [ShopRefundModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [_refundList addObjectsFromArray:tempArray];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
@end
