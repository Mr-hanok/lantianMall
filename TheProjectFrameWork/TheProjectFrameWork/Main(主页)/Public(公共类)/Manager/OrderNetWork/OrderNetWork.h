//
//  OrderNetWork.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderNetWork : NSObject

/**
 *  获取买家订单
 *
 *  @param types        <#types description#>
 *  @param begin        <#begin description#>
 *  @param successblock <#successblock description#>
 */
+(void)GETBuyerOrderWith:(OrderTypes)types andbeginPage:(NSInteger)begin andblcok:(void (^)(NSDictionary * dic))successblock ;

/**
 *  获取卖家订单
 *
 *  @param types        <#types description#>
 *  @param begin        <#begin description#>
 *  @param successblock <#successblock description#>
 */
+(void)GETSellerOrderWith:(SellerOrderTypes)types andbeginPage:(NSInteger)begin andblcok:(void (^)(NSDictionary * dic))successblock ;

@end
