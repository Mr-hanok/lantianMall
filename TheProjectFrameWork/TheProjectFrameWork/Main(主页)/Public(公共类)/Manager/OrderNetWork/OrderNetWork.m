//
//  OrderNetWork.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderNetWork.h"

@implementation OrderNetWork
/**
 *  获取买家订单
 *
 *  @param types        <#types description#>
 *  @param begin        <#begin description#>
 *  @param successblock <#successblock description#>
 */
+(void)GETBuyerOrderWith:(OrderTypes)types andbeginPage:(NSInteger)begin andblcok:(void (^)(NSDictionary * dic))successblock
{
    switch (types) {
        case OrderTypesCanCel:
            
            break;
        case OrderTypesToSend:
            
            break;
        case OrderTypesToAccePt:
            
            break;
        case OrderTypesToPayment:
            
            break;
        case OrderTypesToEvaluation:
            
            break;
        case OrderTypesRefundFailure:
            
            break;
        case OrderTypesApplyRefunding:
            
            break;
        case OrderTypesAllTypes:
            
            break;
        case OrderTypesScuccess
            :
            break;
        case OrderTypesRefundSuccess
            :
        break;
        default:
            break;
    }
    
    NSDictionary * dic =  @{@"user_id":kUserId,
                            @"order_status":@"",
                            @"currentPage":@""};
    [NetWork PostNetWorkWithUrl:@"" with:dic successBlock:^(NSDictionary *dic)
    {
        successblock(dic);

    } errorBlock:^(NSString *error) {
        
    }];
}
/**
 *  获取卖家订单
 *
 *  @param types        types description
 *  @param begin        begin description
 *  @param successblock <#successblock description#>
 */
+(void)GETSellerOrderWith:(SellerOrderTypes)types andbeginPage:(NSInteger)begin andblcok:(void (^)(NSDictionary *))successblock
{
    NSDictionary * dic =  @{@"user_id":kUserId,
                            @"order_status":@"",
                            @"currentPage":@""};
    [NetWork PostNetWorkWithUrl:@"" with:dic successBlock:^(NSDictionary *dic)
     {
         successblock(dic);
         
     } errorBlock:^(NSString *error) {
         
     }];
}
@end
