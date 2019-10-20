//
//  OrderManagerNetWork.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderManagerNetWork.h"

@implementation OrderManagerNetWork

/**
 *  删除订单
 *
 *  @param orderID 订单ID
 *  @param block   <#block description#>
 */
+(void)DelegateOrder:(NSString*)orderID  ResultBlock:(void (^)(BOOL success))block
{
    NSDictionary * dic = @{@"id":orderID,
                           @"user_id":kUserId,};
    [NetWork PostNetWorkWithUrl:@"/order_delete" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             block(YES);
         }
         else
         {
             [HUDManager showWarningWithText:dic[@"message"]];
             block(NO);

         }
     } errorBlock:^(NSString *error)
    {
        block(NO);
        
     }];
    
}
/**
 *  发货
 *
 *  @param orderID 订单ID
 *  @param block   <#block description#>
 */
+(void)SendGoods:(NSString*)orderID ResultBlock:(void (^)(BOOL success))block{
    NSDictionary *dic = @{@"of_id":orderID,
                          @"user_id":kUserId,
                          @"order_seller_intro":@"",
                          @"state_info":@""};
    [NetWork PostNetWorkWithUrl:@"/seller/order_shipping_save" with:dic successBlock:^(NSDictionary *dic)
     {
        if ([dic[@"status"] boolValue])
        {
            block(YES);
        }
        else
        {
            block(NO);
        }
    } errorBlock:^(NSString *error) {
        block(NO);
    }];
}
/**
 *  取消订单
 *
 *  @param orderID 订单ID
 *  @param content 取消原因
 *  @param block   <#block description#>
 */
+(void)CancelOrder:(NSString *)orderID Content:(NSString *)content ResultBlock:(void (^)(BOOL))block
{
    NSDictionary * dic =@{@"id":orderID,
                          @"user_id":kUserId,
                          @"state_info":content,
                          @"other_state_info":@"",};
    [NetWork PostNetWorkWithUrl:@"/order_cancel" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue ])
         {
             block(YES);
         }
         else
         {
             [HUDManager showWarningWithText:dic[@"message"]];
             block(NO);
         }
     } errorBlock:^(NSString *error)
    {
        [HUDManager showWarningWithText:error];
         block(NO);

     }];
}
/**
 *  确认收货
 *
 *  @param orderID 订单ID
 *  @param block   <#block description#>
 */

+(void)ConfirmAcceptOrder:(NSString*)orderID ResultBlock:(void (^)(BOOL success))block
{
    NSDictionary * dic =@{@"orderId":orderID,};
    [NetWork PostNetWorkWithUrl:@"/Confirm_receipt" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             block(YES);
         }
         else
         {
             block(NO);
 
         }
     } errorBlock:^(NSString *error)
     {
         block(NO);
     }];

}
/**
 *  买家申请退款
 *
 *  @param orderID 订单ID
 *  @param content 买家申请退款原因
 *  @param block   回调
 */

+(void)ArefundOrder:(NSString*)orderID Content:(NSString*)content ResultBlock:(void (^)(BOOL success))block
{
    NSDictionary * dic = @{@"of_id":orderID,
                           @"content":content,
                           @"user_id":kUserId};
    [NetWork PostNetWorkWithUrl:@"/buyer/buyer_refund_save" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             block(YES);
             [HUDManager showWarningWithText:@"申请退款成功"];
         }
         else
         {
             block(NO);
             [HUDManager showWarningWithText:dic[@"message"]];
         }
     } errorBlock:^(NSString *error)
     {
         block(NO);
     }];
}
+(void)CancelArefundMoney:(NSString*)orderID Content:(NSString*)content ResultBlock:(void (^)(BOOL success))block
{
    NSDictionary * dic = @{@"of_id":orderID,
                           @"refund_log":content,
                           @"refund_type":@"",
                           @"user_id":kUserId};
    [NetWork PostNetWorkWithUrl:@"/buyer/buyer_cancel_refund" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue])
         {
             block(YES);
         }
         else
         {
             block(NO);
             [HUDManager showWarningWithText:dic[@"message"]];
         }
     } errorBlock:^(NSString *error)
     {
         block(NO);
     }];
    
}


@end
