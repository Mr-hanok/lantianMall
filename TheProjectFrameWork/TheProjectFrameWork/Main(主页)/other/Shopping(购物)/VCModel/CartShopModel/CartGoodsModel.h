//
//  CartGoodsModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
/**购物车商品Model*/
@interface CartGoodsModel : BaseModel
/** 商品在购物车id */
@property(strong,nonatomic) NSString * goodsCartId;
/** 商品id */
@property(strong,nonatomic) NSString * goodsId;
/** 商品名称 */
@property(strong,nonatomic) NSString * goods_name;
/** 商品URL */
@property(strong,nonatomic) NSString * goodsUrl;
/** 商品价格 */
@property(strong,nonatomic) NSString * price;
/** 商品规格 */
@property(strong,nonatomic) NSString * spec_info;
/** 商品数量 */
@property(strong,nonatomic) NSString * count;
/** 税费 */
@property(strong,nonatomic) NSString * tax_rate;
/** 库存 */
@property(strong,nonatomic) NSString * goods_inventory;
/** 商品状态 */
@property(strong,nonatomic) NSString * goods_status;






@end
