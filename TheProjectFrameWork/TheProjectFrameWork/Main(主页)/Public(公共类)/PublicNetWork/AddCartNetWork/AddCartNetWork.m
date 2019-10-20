//
//  AddCartNetWork.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddCartNetWork.h"

@implementation AddCartNetWork
+(void)AddCartNetWorkgoodid:(NSString*)goodsID number:(NSString*)number specifi:(NSString*)specifd block:(void (^)(BOOL success , NSString * number))block
{
    if (!goodsID) {
        
    }
    else
    {
    if (!specifd) {
        specifd= @"";
    }
    if (!number) {
        number = @"1";
    }
    NSDictionary * dic;
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        dic = @{@"goods_id":goodsID,
                @"user_id":kUserId,
                @"count":number,
                @"gsp":specifd,
                @"sku_id":specifd};
    }
    else
    {    dic = @{@"goods_id":goodsID,
                 @"user_id":@"",
                 @"count":number,
                 @"cart_session_id":[UserAccountManager shareUserAccountManager].cartUserID,
                 @"gsp":specifd,
                 @"sku_id":specifd};
    }
    [NetWork PostNetWorkWithUrl:@"/goods/add_cart" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             NSString * sting = [NSString stringWithFormat:@"%@",dic[@"data"][@"count"]];
             if ([sting integerValue]>99) {
                 sting = @"99+";
             }
             block(YES,sting);
//             NSString * badgeValue = sting;
//             [UserAccountManager shareUserAccountManager].cartnumber = badgeValue;
//             UITabBarController * tabController = (UITabBarController*)kRootViewController;
//             [tabController.tabBar showBadgeOnItemIndex:2 withBadgeValue:badgeValue];
         }
         else{
             [HUDManager showWarningWithText:dic[@"message"]];
         }
    } errorBlock:^(NSString *error) {
        [HUDManager showWarningWithText:error];
    }];
    }
    
}

@end
