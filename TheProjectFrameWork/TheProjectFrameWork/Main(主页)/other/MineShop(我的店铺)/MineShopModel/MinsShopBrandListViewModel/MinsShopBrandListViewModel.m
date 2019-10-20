//
//  MinsShopBrandListViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MinsShopBrandListViewModel.h"
#import "BrandModel.h"

@implementation MinsShopBrandListViewModel
{
    NSInteger currentPage;
    NSMutableDictionary * parame;
}
- (void)getBrandListCompleteBlock:(completeBlock)block
{
    [self reloadBrandListPage];
    parame = [@{@"currentPage":@(currentPage),@"user_id":kUserId} mutableCopy];
    [NetWork PostNetWorkWithUrl:@"/seller/usergoodsbrand_list" with:parame successBlock:^(NSDictionary *dic) {
        _dataArray = [BrandModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)getPageListCompleteBlock:(completeBlock)block
{
    parame = [@{@"currentPage":@(currentPage),@"user_id":kUserId} mutableCopy];
    [NetWork PostNetWorkWithUrl:@"/seller/usergoodsbrand_list" with:parame successBlock:^(NSDictionary *dic) {
        _dataArray = [[_dataArray arrayByAddingObjectsFromArray:[BrandModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]] mutableCopy];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)updateBrandListCompleteBlock:(completeBlock)block
{
    parame = [@{@"currentPage":@(1),@"user_id":kUserId} mutableCopy];
    [NetWork PostNetWorkWithUrl:@"/seller/usergoodsbrand_list" with:parame successBlock:^(NSDictionary *dic) {
        _dataArray = [BrandModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)reloadBrandListPage
{
    currentPage = 1;
}
@end
