//
//  PayOnLineViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface PayOnLineViewController : LeftViewController

@property(strong,nonatomic) NSString * payurls;
/** 支付类型 */
@property(strong,nonatomic) NSString * onLinePayType;
/** 支付订单 */
@property(strong,nonatomic) NSString * orderNumber;
/** 付款金额 */
@property(strong,nonatomic) NSString * orderMoney;
/** 是否使用余额 */
@property(assign,nonatomic) BOOL  useRebate;
/** 检查支付状态 */
@property(strong,nonatomic) NSString * payOrderID;


@end
