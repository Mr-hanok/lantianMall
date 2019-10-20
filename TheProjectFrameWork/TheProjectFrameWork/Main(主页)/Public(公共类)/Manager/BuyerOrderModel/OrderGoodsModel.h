//
//  OrderGoodsModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface OrderGoodsModel : BaseModel
/** 购物车id */
@property(strong,nonatomic) NSString * goodsCartId;
/** 商品ID */
@property (nonatomic , copy) NSString * goods_id;

/** 商品图片 */
@property(strong,nonatomic) NSString * goodsMainPhotos;
/** 商品名称 */
@property(strong,nonatomic) NSString * goodsName;
/** 店铺价格 */
@property(strong,nonatomic) NSString * storePrice;
/** 现价 */
@property(strong,nonatomic) NSString * gcPrice;
/** 规格 */
@property(strong,nonatomic) NSString * specInfo;
/** 数量 */
@property(strong,nonatomic) NSString * count;

@end
