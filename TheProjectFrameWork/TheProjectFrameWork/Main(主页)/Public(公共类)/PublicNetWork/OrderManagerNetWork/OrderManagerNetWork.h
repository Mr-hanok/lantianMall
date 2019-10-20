//
//  OrderManagerNetWork.h
//  TheProjectFrameWork
//
//  Created by maple on 16/9/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderManagerNetWork : NSObject

/** 删除订单 */
+(void)DelegateOrder:(NSString*)orderID  ResultBlock:(void (^)(BOOL success))block;

/** 发货 */
+(void)SendGoods:(NSString*)orderID ResultBlock:(void (^)(BOOL success))block;

/** 取消订单 */
+(void)CancelOrder:(NSString*)orderID Content:(NSString*)content ResultBlock:(void (^)(BOOL success))block;

/** 确认收货 */
+(void)ConfirmAcceptOrder:(NSString*)orderID ResultBlock:(void (^)(BOOL success))block;

/** 买家申请退款 */
+(void)ArefundOrder:(NSString*)orderID Content:(NSString*)content ResultBlock:(void (^)(BOOL success))block;

/** 取消退款 */
+(void)CancelArefundMoney:(NSString*)orderID Content:(NSString*)content ResultBlock:(void (^)(BOOL success))block;





@end
