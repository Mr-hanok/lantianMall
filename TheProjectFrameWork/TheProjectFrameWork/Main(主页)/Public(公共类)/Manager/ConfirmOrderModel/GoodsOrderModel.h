//
//  GoodsOrderModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsOrderModel : BaseModel
/** 商品购物车id */
@property(strong,nonatomic) NSString * goodsCartID;
/** 商品id */
@property(strong,nonatomic) NSString * goodsid;
/** 商品url */
@property(strong,nonatomic) NSString * goodsUrl;
/** 优惠后价格 */
@property(strong,nonatomic) NSString * price;
/** 原来价格 */
@property(strong,nonatomic) NSString * goods_price;

/** 商品规格 */
@property(strong,nonatomic) NSString * spec_info;
/** 商品数量 */
@property(strong,nonatomic) NSString * count;
/** 商品名称 */
@property(strong,nonatomic) NSString * goods_name;
/** 商品税率 */
@property(strong,nonatomic) NSString * goodstax_rate;
/** 税费 */
@property(strong,nonatomic) NSString * goodstaxes;
/** 是否是虚拟物品 0 实物 1 虚拟  */
@property(strong,nonatomic) NSString * goods_choice_type
;






@end
