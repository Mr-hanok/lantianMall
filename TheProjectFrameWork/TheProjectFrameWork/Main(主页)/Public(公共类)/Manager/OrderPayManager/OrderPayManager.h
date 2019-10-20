//
//  OrderPayManager.h
//  TheProjectFrameWork
//
//  Created by maple on 16/10/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderPayManager : NSObject

/** 订单支付 */
+(void)OrderPayWithOrderID:(NSString*)orderID andPayType:(NSString*)type With:(void(^)(BOOL success ,NSString * urls ,NSString* payType, NSString * paymoney ,NSString * orderPayID, NSString*error))block;
/**积分订单支付*/
+(void)IntegralOrderPayWithOrderID:(NSString *)orderID andPayType:(NSString *)type With:(void (^)(BOOL, NSString *, NSString *, NSString *,NSString * , NSString *))block;
/** 判断支付密码是否存在 */
+(void)CHeckPayPassWord:(void(^)(BOOL success ,NSString *payType, NSString* error))block;

@end
