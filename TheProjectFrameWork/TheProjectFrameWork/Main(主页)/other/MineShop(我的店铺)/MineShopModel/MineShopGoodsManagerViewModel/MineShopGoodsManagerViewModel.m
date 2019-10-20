//
//  MineShopGoodsManagerViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopGoodsManagerViewModel.h"
#import "ShopGoodsManagerModel.h"

@implementation MineShopGoodsManagerViewModel

{
    NSMutableDictionary * parame;
    NSString * managerUrl;
    NSMutableArray * originalArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentPage = 1;
        _dataArray = [NSMutableArray array];
        originalArray = [NSMutableArray array];
    }
    return self;
}
- (void)getShopGoodsManagerCompletionHandle:(completionHandleBlock)blcok url:(NSString *)url
{
   self.currentPage = 1;
    parame = [@{@"user_id":kUserId,@"currentPage":@(self.currentPage)} mutableCopy];
    managerUrl = url;
    [NetWork PostNetWorkWithUrl:url with:parame successBlock:^(NSDictionary *dic) {
        _dataArray = [ShopGoodsManagerModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        originalArray = [_dataArray mutableCopy];
        self.currentPage ++;
        blcok(nil);
    } FailureBlock:^(NSString *msg) {
        [HUDManager  showWarningWithText:msg];
        blcok(nil);
    } errorBlock:^(NSError *error) {
        blcok(error);
    }];
}
- (void)getSearchShopGoodsWithText:(NSString *)text complete:(completionHandleBlock)block  url:(NSString *)url
{
    
    parame = [@{@"user_id":kUserId,@"currentPage":@(self.currentPage)} mutableCopy];
    managerUrl = url;
    if(text.length == 0 || text == nil)
    {
        
//        _dataArray = originalArray;
//        block(nil);
//        return;
    }
    [parame setObject:text?:@"" forKey:@"goods_name"];
    [NetWork PostNetWorkWithUrl:managerUrl with:parame successBlock:^(NSDictionary *dic) {
        if (self.currentPage == 1) {
            [_dataArray removeAllObjects];
        }
        NSArray *temparray = [ShopGoodsManagerModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        NSString *tempstr;
        if (temparray.count<10 && self.currentPage != 1) {
            tempstr = @"没有更多数据了";
        }
        [_dataArray addObjectsFromArray:temparray];
        originalArray = [_dataArray mutableCopy];
        self.currentPage++;
        block(tempstr);
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)getPageShopGoodsWithComplete:(completionHandleBlock)blcok
{
    
    [parame setObject:@(self.currentPage) forKey:@"currentPage"];
    [NetWork PostNetWorkWithUrl:managerUrl with:parame successBlock:^(NSDictionary *dic) {
        NSArray * newArray = [ShopGoodsManagerModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [_dataArray addObjectsFromArray:newArray];
        originalArray = [_dataArray mutableCopy];
        self.currentPage++;
        blcok(nil);
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(id error) {
        blcok(error);
    }];
}

- (void)deleteShopGoodsWithModel:(ShopGoodsManagerModel *)model complete:(completionHandleBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/seller/goods_delete" with:@{@"goods_id":@(model.goodsId)} successBlock:^(NSDictionary *dic) {
        if([_dataArray containsObject:model])
        {
            [_dataArray removeObject:model];
        }
        originalArray = [_dataArray mutableCopy];
        block(@"商品删除成功");
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)handleShopGoodsWithModel:(ShopGoodsManagerModel *)model complete:(completionHandleBlock)block
{
    [NetWork PostNetWorkWithUrl:@"/seller/goods_sale" with:@{@"user_id":kUserId,@"goods_ids":@(model.goodsId)} successBlock:^(NSDictionary *dic) {
        if([_dataArray containsObject:model])
        {
            [_dataArray removeObject:model];
        }
        originalArray = [_dataArray mutableCopy];
        block(@"操作成功");
    } FailureBlock:^(NSString *msg) {
        block(nil);
    } errorBlock:^(id error) {
        block(error);
    }];
}

- (void)recommendShopGoodsWithModel:(ShopGoodsManagerModel *)model complete:(completionHandleBlock)block
{
    NSString * recomendString = model.recomend?@"cancel_recommend":@"recommend";
    [NetWork PostNetWorkWithUrl:@"/seller/store_recommend" with:@{@"recommend":recomendString,@"goods_id":@(model.goodsId)} successBlock:^(NSDictionary *dic) {
        NSString *tempstr;
        if ([recomendString isEqualToString:@"cancel_recommend"]) {
            model.recomend = NO;
            tempstr = @"取消推荐成功";
        }else{
            model.recomend = YES;
            tempstr = @"推荐成功";
        }
        block(tempstr);
    } FailureBlock:^(NSString *msg) {
        block([NSError new]);
    } errorBlock:^(id error) {
        block(error);
    }];
}
@end
