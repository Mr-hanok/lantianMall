//
//  ShopRefundModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopRefundModel : NSObject
@property (nonatomic , copy) NSString * userName;
@property (nonatomic , copy) NSString * order_id; // 订单编号
@property (nonatomic , copy) NSString * refund_id;

@property (nonatomic , copy) NSString * addTime;
@property (nonatomic , copy) NSString * refundLog; ///< 描述信息
@property (nonatomic , copy) NSString * payWay; ///< 支付方式
@property (nonatomic , assign) NSInteger isUseRebate; 

@end
