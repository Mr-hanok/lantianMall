//
//  OrderDetailViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
@class BuyerOrderModel;
@interface OrderDetailViewController : LeftViewController

@property(assign,nonatomic) OrderTypes orderType;
@property(strong,nonatomic) BuyerOrderModel * buyOrderModel;
@property(strong,nonatomic) NSString * orderId;

@end
