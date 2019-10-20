//
//  StoreOrderModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "GoodsOrderModel.h"
#import "VipPriceModel.h"

@interface StoreOrderModel : BaseModel
/** 店铺购物车id */
@property(strong,nonatomic) NSString * storeCartID;
/** 店铺id */
@property(strong,nonatomic) NSString * storeId;
/** 店铺名称 */
@property(strong,nonatomic) NSString * storeName;
/** 总价 */
@property(strong,nonatomic) NSString * totalPrice;
/** 商品数量 */
@property(strong,nonatomic) NSString * goodsCount;
/** 商品 */
@property(strong,nonatomic) NSArray<GoodsOrderModel*> * goodsCarts;
/** 留言 */
@property(strong,nonatomic) NSString * leaveMessage;
/** 配送方式 */
@property(strong,nonatomic) NSString * sendtype;
/** 配送时间 */
@property(strong,nonatomic) NSString * sendtime;
/** 运费 */
@property(strong,nonatomic) NSString * storeShipPrice;

/** 及时送运费价格 */
@property(strong,nonatomic) NSString * zoomtotalPrice;
/** 及时送运费价格 */
@property(strong,nonatomic) NSString * zoomPrice;





/** 是否显示及时送 */
@property(assign,nonatomic) BOOL isShow;

@property(strong,nonatomic) NSArray * etList;

@property (nonatomic, strong) VipPriceShopModel *vipshopmodel;
@end
