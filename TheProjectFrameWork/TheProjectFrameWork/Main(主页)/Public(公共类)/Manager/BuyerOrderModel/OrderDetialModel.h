//
//  OrderDetialModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "DetialOrderGoodsModel.h"

@interface OrderDetialModel : BaseModel

@property(strong,nonatomic) NSString * order_status;

/** 数据库生成ID */
@property(strong,nonatomic) NSString * orderId;

@property(strong,nonatomic) NSString * order_id;
/** 下单时间 */
@property(strong,nonatomic) NSString * addTime;
/** 店铺名称 */
@property(strong,nonatomic) NSString * store_name;
/** 电话 */
@property(strong,nonatomic) NSString * telphone;
/** 地区 */
@property(strong,nonatomic) NSString * area;
/** 填写地址 */
@property(strong,nonatomic) NSString * address;
/** 税费 */
@property(strong,nonatomic) NSString * taxes;
/** 支付方式 */
@property(strong,nonatomic) NSString * payment;

@property(strong,nonatomic) NSArray<DetialOrderGoodsModel*> * gcs;
/** 收件人 */
@property(strong,nonatomic) NSString * consignee;
/** 邮编 */
@property(strong,nonatomic) NSString * postCode;
/** 邮寄地址 */
@property(strong,nonatomic) NSString * sendAddress;



/** 发票地址 */
@property(strong,nonatomic) NSString * invoAddress;

/** 发票姓名 */
@property(strong,nonatomic) NSString * invoName;

/** 发票电话 */
@property(strong,nonatomic) NSString * invoMobile;
/** 发票邮编 */
@property(strong,nonatomic) NSString * invoZip;

/** 电话 */
@property(strong,nonatomic) NSString * phone;
/** 配送方式 */
@property(strong,nonatomic) NSString * transport;
/**配送时间  */
@property(strong,nonatomic) NSString * shipTime;
/** 发票号 */
//@property(strong,nonatomic) NSString * invoice;
/** 物流公司 */
@property(strong,nonatomic) NSString * logicCompany;
/** 物流单号 */
@property(strong,nonatomic) NSString * shipCode;
/** 物流状态  */
@property(strong,nonatomic) NSString * orderStatus;
/** 总价 */
@property(strong,nonatomic) NSString * totalPrice;
/** 实际金额 */
@property(strong,nonatomic) NSString * disbursements;
/** 下单时间 */
@property(strong,nonatomic) NSString * makeOrderTime;
/** 支付时间 */
@property(strong,nonatomic) NSString * payTime;
/** 店铺id */
@property(strong,nonatomic) NSString * store_id;
/** 配送信息 */
@property(strong,nonatomic) NSString * transInfo;
/** 用户id */
@property(strong,nonatomic) NSString * userID;
/** 用户名 */
@property(strong,nonatomic) NSString * userName;

/** 物流公司 */
@property(strong,nonatomic) NSString * company;
/** 物流单号 */
@property(strong,nonatomic) NSString * num;
/** 判读发货方式 */
@property(assign,nonatomic) BOOL  type;
/** 运费 */
@property(strong,nonatomic) NSString * actual_Shipment;

/** 会员类型 */
@property(strong,nonatomic) NSString * userGrade;

/** yes: 已评价  */
@property (nonatomic , assign) BOOL evaluate;
/** 是否支持线下下支付 */
@property (nonatomic , assign) BOOL lineType;
/** 店铺用户名 */
@property(strong,nonatomic) NSString *store_userName;
/** 店铺用户ID */
@property(strong,nonatomic) NSString *store_userId;

/**0 实物，1 虚拟*/
@property (nonatomic, assign) BOOL goods_type;
/**退款之前的状态字段*/
@property (nonatomic, copy) NSString *before_refund_status;

/**满减金额*/
@property (nonatomic, copy) NSString *fullcutPrice;
/**店铺优惠券*/
@property (nonatomic, copy) NSString *store_coupon_amount;
/**平台优惠券*/
@property (nonatomic, copy) NSString *mall_coupon_amount;

/**发票抬头*/
@property (nonatomic, copy) NSString *invoice;
/**营业税号*/
@property (nonatomic, copy) NSString *taxPayerNum;
/**发票类型 0 个人 1 公司 2 不开*/
@property (nonatomic, copy) NSString *invoiceType;

@property (nonatomic, copy) NSString *msg;
/**最后金额*/
@property (nonatomic, copy) NSString *couponTotalPrice;


@end
