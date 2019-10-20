//
//  PromotionGoodsViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PromotionGoodsViewModel.h"
#import "PromotionGoodsModel.h"
static NSInteger number = 10;
@implementation PromotionGoodsViewModel
{
    NSInteger pageCount;
    NSInteger searchPageCount;
    NSMutableDictionary * params;
    NSMutableDictionary * searchParams;
    NSInteger currentPage;
    NSInteger searchPage;
    NSMutableArray * originalDataArray;
    NSString * searchContent;
}
- (void)getPromotionGoodsWithID:(NSInteger)promotionID Complete:(completeBlock)block
{
    currentPage = 1;
    searchPage = 1;
    searchPageCount = -1;
    pageCount = -1;
    self.isFirstPage = YES;
    
    params = [@{@"act_id":@(promotionID)} mutableCopy];
    searchParams = [params mutableCopy];
    [params setValue:@(currentPage) forKey:@"begin"];
    [params setValue:@(number) forKey:@"max"];
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        [params setValue:kUserId?:@"" forKey:@"user_id"];
    }else{
        [params setValue:@"" forKey:@"user_id"];

    }
    
    [NetWork PostNetWorkWithUrl:@"/goods/getGoodsByActivity" with:params successBlock:^(NSDictionary *dic) {
        if (currentPage) {
            self.isFirstPage = YES;
        }else{
            self.isFirstPage = NO;
        }
        _dataArray = [PromotionGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"reList"]];
        _scrollIconArray = [PromotionGoodsScrollModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"advertList"]];
        pageCount = (NSInteger)ceil([dic[@"data"][@"rowCount"] doubleValue] / number);
        originalDataArray = [_dataArray mutableCopy];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];

}
- (void)searchPromotionGoodsWithSearchContent:(NSString *)content complete:(completeBlock)block
{
    if(content.length == 0 || content == nil)
    {
        _dataArray = originalDataArray;
        searchPage = 0;
        searchParams = [@{@"act_id":params[@"act_id"]} mutableCopy];
        block(nil);
        return;
    }
    searchContent = content;
    if(searchPageCount < searchPage && searchPageCount != -1)
    {
        block(nil);
        return;
    }
    [searchParams setValue:@(searchPage) forKey:@"begin"];
    [searchParams setValue:@(number) forKey:@"max"];
    [searchParams setObject:content forKey:@"goods_name"];
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        [searchParams setValue:kUserId?:@"" forKey:@"user_id"];
    }else{
        [searchParams setValue:@"" forKey:@"user_id"];
        
    }
    [NetWork PostNetWorkWithUrl:@"/goods/searchGoodsByActivity" with:searchParams successBlock:^(NSDictionary *dic) {
        NSArray * array = dic[@"data"][@"reList"];
        searchPageCount = (NSInteger)ceil([dic[@"data"][@"rowCount"] doubleValue] / number);
        if(array.count == 0)
        {
            block(dic[@"message"]);
        }else
        {
            if([searchContent isEqualToString:dic[@"data"][@"good_name"]])
            {
                _dataArray = nil;
                _dataArray = [PromotionGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"reList"]];
            }
        }
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}

- (void)getPromotionGoodsPageInfoComplete:(completeBlock)block
{
    if(pageCount < currentPage)
    {
        block(@"已经加载全部");
        return;
    }
    [params setValue:@(currentPage) forKey:@"begin"];
    [params setValue:@(number) forKey:@"max"];
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        [params setValue:kUserId?:@"" forKey:@"user_id"];
    }else{
        [params setValue:@"" forKey:@"user_id"];
        
    }
    [NetWork PostNetWorkWithUrl:@"/goods/getGoodsByActivity" with:params successBlock:^(NSDictionary *dic) {
        [_dataArray addObjectsFromArray:[PromotionGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"reList"]]];
        originalDataArray = [_dataArray mutableCopy];
        currentPage ++;
        block(nil);
    } FailureBlock:^(NSString *msg) {
        block(msg);
    } errorBlock:^(id error) {
        block(error);
    }];
}
- (void)getHeaderGoodsInfoCompleted:(completeBlock)completed
{
    currentPage = 1;
    [params setValue:@(currentPage) forKey:@"begin"];

    [NetWork PostNetWorkWithUrl:@"/goods/getGoodsByActivity" with:params successBlock:^(NSDictionary *dic) {
        _dataArray = [PromotionGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"reList"]];
        _scrollIconArray = [PromotionGoodsScrollModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"advertList"]];
        pageCount = (NSInteger)ceil([dic[@"data"][@"rowCount"] doubleValue] / number);
        originalDataArray = [_dataArray mutableCopy];
        completed(nil);
    } FailureBlock:^(NSString *msg) {
        completed(msg);
    } errorBlock:^(id error) {
        completed(error);
    }];
}
@end
