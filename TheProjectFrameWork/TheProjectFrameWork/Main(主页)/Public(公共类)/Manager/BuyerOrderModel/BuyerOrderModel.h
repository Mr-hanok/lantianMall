//
//  BuyerOrderModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "OrderGoodsModel.h"

@interface BuyerOrderModel : BaseModel

/** 数据库生成id */
@property(strong,nonatomic) NSString * buyoderid;
/** 总数量 */
@property(strong,nonatomic) NSString * totalcount;
/** 总价 */
@property(strong,nonatomic) NSString * total;
/** 订单生成展示id */
@property(strong,nonatomic) NSString * order_id;
/** 下单时间 */
@property (nonatomic , copy) NSString * addTime;
/** 店铺名称 */
@property(strong,nonatomic) NSString * store_name;
/** 店铺id */
@property(strong,nonatomic) NSString * store_id;
/** 买家申请退款 */
@property(strong,nonatomic) NSString * refunding;
/** 订单状态 */
@property(strong,nonatomic) NSString * status;
/** 总共价格 */
@property(strong,nonatomic) NSString * totalPrice;
/** 退款金额 */
@property(strong,nonatomic) NSString * refundAmount;
/** yes: 已评价  */
@property (nonatomic , assign) BOOL evaluate;

/** 是否支付线下支付 */
@property (nonatomic , assign) BOOL lineType;

/** 判读平台发货或者商家自己发货 */
@property(assign,nonatomic) BOOL type;

/** 商品数组 */
@property(strong,nonatomic) NSArray <OrderGoodsModel *> * gcpList;

/** 店铺用户ID */
@property(strong,nonatomic) NSString * store_userId;
/** 店铺用户名 */
@property(strong,nonatomic) NSString * store_userName;
/**0 实物，1 虚拟*/
@property (nonatomic, assign) BOOL goods_type;
/**退款之前的状态字段*/
@property (nonatomic, copy) NSString *before_refund_status;
/**运费*/
@property (nonatomic, copy) NSString *shipPrice;
@end
