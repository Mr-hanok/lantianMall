//
//  MineShopAccountModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopAccountModel.h"

@implementation MineShopAccountModel
+ (void)getMineShopAccountInfoWithStoreID:(NSInteger)store_id complete:(completeBlock)complete
{
    [NetWork PostNetWorkWithUrl:@"/store_class/my_account" with:@{@"user_id":kUserId,@"store_id":@(store_id)} successBlock:^(NSDictionary *dic) {
        MineShopAccountModel * model = [MineShopAccountModel mj_objectWithKeyValues:dic[@"data"]];
        complete(model,nil);
    } FailureBlock:^(NSString *msg) {
        complete(nil,msg);
    } errorBlock:^(id error) {
        complete(nil,error);
    }];
}
@end
