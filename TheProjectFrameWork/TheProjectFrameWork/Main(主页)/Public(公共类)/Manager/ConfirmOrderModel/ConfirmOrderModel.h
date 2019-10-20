//
//  ConfirmOrderModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "StoreOrderModel.h"
#import "VipPriceModel.h"

@interface ConfirmOrderModel : BaseModel

/** 收货人名称 */
@property(strong,nonatomic) NSString * addName;
/** 联系方式 */
@property(strong,nonatomic) NSString * addMobile;
/** 地址id */
@property(strong,nonatomic) NSString * addId;
/** 邮编 */
@property(strong,nonatomic) NSString * addZip;

/** 地址详情 */
@property(strong,nonatomic) NSString * addInfo;
/** 默认地址 */
@property(strong,nonatomic) NSString * addStatus;

/** 发票地址 */
@property(strong,nonatomic) NSString * addrInvoMobile;

/** 发票地址ID */
@property(strong,nonatomic) NSString * addrInvoId;
/** 发姓名 */
@property(strong,nonatomic) NSString * addrInvoName;
/** 邮编 */
@property(strong,nonatomic) NSString * addrInvoZip;


/** 发票地址详情 */
@property(strong,nonatomic) NSString * addInfoInvo;


/** 税费 */
@property(strong,nonatomic) NSString * ratesPrice;
/** 总价 */
@property(strong,nonatomic) NSString * totalPrice;
/** 运费 */
@property(strong,nonatomic) NSString * shipPrice;

/** 实际付款 */
@property(strong,nonatomic) NSString * paymentPrice;
/** <#注释#> */
@property(strong,nonatomic) NSMutableArray <StoreOrderModel*>* dateInfo;
/**满减金额*/
@property (nonatomic, copy) NSString *fullcutPrice;
/**活动优惠价格*/
@property (nonatomic, copy) NSString *vipPriceInfo;
/**平台优惠券*/
@property (nonatomic, strong) VipPriceShopModel *pingtaiVipModel;
@end
