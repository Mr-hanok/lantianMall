//
//  OrdereValuationDetailsViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  订单－评价详情(查看评价)

#import "LeftViewController.h"
typedef void(^completed)(id error);
@class OrdereValuationGoodsModel,OrdereValuationDetailsModel;
@interface OrdereValuationDetailsViewController : LeftViewController
@property (nonatomic , copy) NSString * orderId;

@end

@interface OrdereValuationDetailsViewModel : NSObject
@property (nonatomic , strong) OrdereValuationDetailsModel * model;
- (void)getOrderValuationDetailsInfoWithOrderID:(NSString *)orderID completed:(completed)completed;
@end


@interface OrdereValuationDetailsModel : NSObject
@property (nonatomic , copy) NSString * userIcon;
@property (nonatomic , copy) NSString * userName;
@property (nonatomic , assign) NSInteger userCredit;

@property (nonatomic , strong) NSArray <OrdereValuationGoodsModel *>* goodsInfo;

@end

@interface OrdereValuationGoodsModel : NSObject


@property (nonatomic , copy) NSString * imag1;
@property (nonatomic , copy) NSString * imag2;
@property (nonatomic , copy) NSString * imag3;
@property (nonatomic , copy) NSString * goodsName;
@property (nonatomic , copy) NSString * goodsIcon;
@property (nonatomic , copy) NSString * evaluateInfo;
@property (nonatomic , copy) NSString * addTime;
@property (nonatomic , assign) NSInteger evaluateBuyerVal;

@end