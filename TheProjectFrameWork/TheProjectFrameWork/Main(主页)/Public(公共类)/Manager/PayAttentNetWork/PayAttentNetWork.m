//
//  PayAttentNetWork.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PayAttentNetWork.h"

@implementation PayAttentNetWork

+(void)PayAttentNetWorkisGoods:(BOOL)goods withtypeid:(NSString *)theTypeID Success:(void (^)(BOOL))blcok
{
    if (!theTypeID)
    {
        theTypeID= @"1";
    }
    NSString * isgoods = @"1";
    if (goods) {
        isgoods = @"0";
    }
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        NSDictionary * dic = @{@"user_id":kUserId,@"follow_type":isgoods,@"type_id":theTypeID};
        [NetWork PostNetWorkWithUrl:@"/buyer/svaeFavoriteInfo" with:dic successBlock:^(NSDictionary *dic)
        {
            if ([dic[@"status"] boolValue])
            {
                blcok(YES);
                if([isgoods isEqualToString:@"0"])
                {
                    [UserAccountManager shareUserAccountManager].userModel.goodsCount = [dic[@"data"][@"size"] integerValue];
                }else
                {
                    [UserAccountManager shareUserAccountManager].userModel.storeCount = [dic[@"data"][@"size"] integerValue];
                }
                [[UserAccountManager shareUserAccountManager] saveAccountDefaults];
            }
            else{
                [HUDManager showWarningWithText:dic[@"message"]];
            }
        } errorBlock:^(NSString *error) {
            [HUDManager showWarningWithText:error];
            blcok(NO);
        }];
    }
    else
    {
        [HUDManager showWarningWithText:@"请先登录"];
    }
}
+(void)CancelPayAttentNetWorkisGoods:(BOOL)goods withtypeid:(NSString*)theTypeID Success:(void (^)(BOOL success))blcok
{
    NSString * isgoods = @"1";
    if (!theTypeID)
    {
        theTypeID= @"1";
    }
    if (goods)
    {
        isgoods = @"0";
    }
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        NSDictionary * dic = @{@"user_id":kUserId,@"follow_type":isgoods,@"type_id":theTypeID};
        [NetWork PostNetWorkWithUrl:@"/buyer/cancelFavoriteInfo" with:dic successBlock:^(NSDictionary *dic) {
            if ([dic[@"status"] boolValue]) {
                blcok(YES);
                if([isgoods isEqualToString:@"0"])
                {
                    [UserAccountManager shareUserAccountManager].userModel.goodsCount = [dic[@"data"][@"size"] integerValue];
                }else
                {
                    [UserAccountManager shareUserAccountManager].userModel.storeCount = [dic[@"data"][@"size"] integerValue];
                }
                [[UserAccountManager shareUserAccountManager] saveAccountDefaults];
            }
            else
            {
                [HUDManager showWarningWithText:dic[@"message"]];
            }
        } errorBlock:^(NSString *error) {
            [HUDManager showWarningWithText:error];
            blcok(NO);
        }];
    }
    else
    {
        [HUDManager showWarningWithText:@"请先登录"];
    }
}



@end
