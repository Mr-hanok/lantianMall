//
//  CartShopModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "CartGoodsModel.h"
/**购物车店铺Model*/
@interface CartShopModel : BaseModel
/** 店铺购物车内id  */
@property(strong,nonatomic) NSString * cartShopId;
/** 店铺名称 */
@property(strong,nonatomic) NSString * storeName;
/** 店铺id */
@property(strong,nonatomic) NSString * storeId;
/** 总价 */
@property(strong,nonatomic) NSString * totalPrice;
/** 数量 */
@property(strong,nonatomic) NSString * goodsCount;

/**
 购物车内商品数量
 */
@property(strong,nonatomic) NSMutableArray <CartGoodsModel * > * goodsCarts;

@end
