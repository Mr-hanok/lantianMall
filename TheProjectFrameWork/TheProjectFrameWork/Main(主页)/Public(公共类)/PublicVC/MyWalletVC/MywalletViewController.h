//
//  MywalletViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface MywalletViewController : LeftViewController
@property (weak, nonatomic) IBOutlet UIButton *determineButton;

@property(copy,nonatomic) NSString * orderButton;

/** 订单号 */
@property(copy,nonatomic) NSString * orderNumber;

/** 支付状态 */
@property(copy,nonatomic) NSString * orderPaytype;

/** 需要支付金额 */
@property(copy,nonatomic) NSString * orderPayMoney;

/** 积分订单 */
@property (nonatomic, assign) BOOL isIntegralOrder;

/** 线下支付 */
@property (nonatomic, assign) BOOL isOffline;
/**是否是商品*/
@property (nonatomic, assign) BOOL isGoods;

@end

@interface PayTypeModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *modeid;
@property (nonatomic, assign) BOOL open;

@end
