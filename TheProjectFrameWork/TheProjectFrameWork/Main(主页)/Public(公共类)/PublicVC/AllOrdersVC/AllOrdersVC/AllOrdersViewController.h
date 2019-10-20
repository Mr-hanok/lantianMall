//
//  AllOrdersViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
/**
 *  头视图item对于内容
 */
typedef NS_ENUM(NSInteger, OrderTitleTypes) {
    /**
     *   全部订单
     */
    OrderTitleTypeAll = 0 << 0,
    /**
     *  已完成订单
     */
    OrderTitleTypeFinish = 1 << 1,
    /**
     *  已取消订单
     */
    OrderTitleTypeCancel = 2 << 2,
    /**
     *  退款中订单
     */
    OrderTitleTypeRefunding = 3 << 3,
    /**
     *  退款成功订单
     */
    OrderTitleTypeRefundFinish = 4 << 4,
    /**
     *  退款失败订单
     */
    OrderTitleTypeRefundFail = 5 << 5,
};
@interface AllOrdersViewController : LeftViewController

@property(assign,nonatomic) OrderTypes types;

@property(assign,nonatomic) BOOL isBuyer;


@end
