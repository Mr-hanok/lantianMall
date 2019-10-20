//
//  GoodsDetialModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "GoodsParameterModel.h"

@interface GoodsDetialModel : BaseModel

/** 商品iD */
@property(strong,nonatomic) NSString * goodsID;
/** 商品名称 */
@property(strong,nonatomic) NSString * goods_name;
/** 商品原价 */
@property(strong,nonatomic) NSString * goods_price;
/** 商店价格 */
@property(strong,nonatomic) NSString * store_price;
/** 库存 */
@property(strong,nonatomic) NSString * goods_inventory;
/** 商品详情 */
@property(strong,nonatomic) NSString * goods_details;
/** 商品点击数量 */
@property(strong,nonatomic) NSString * goods_click;
/** 商品收藏数量 */
@property(strong,nonatomic) NSString * goods_collect;
/** 商品所属店铺ID */
@property(strong,nonatomic) NSString * goods_Store_ID;
/** 商品所属店铺名称 */
@property(strong,nonatomic) NSString * goods_Store_Name;
/** 商品所属店铺ID */
@property(strong,nonatomic) NSString * store_userId;
/** 商品所属店铺名称 */
@property(strong,nonatomic) NSString * store_userName;

/** 商品图片 */
@property(strong,nonatomic) NSString * goodsImageUrl;


/** 商品编号 */
@property(strong,nonatomic) NSString * goods_serial;
/** 商品重量 */
@property(strong,nonatomic) NSString * goods_weight;
/** 商标 */
@property(strong,nonatomic) NSString * goods_brand_name;
/** 商品长度 */
@property(strong,nonatomic) NSString * goods_length;
/** 商品宽度 */
@property(strong,nonatomic) NSString * goods_width;
/** 商品高度 */
@property(strong,nonatomic) NSString * goods_height;




/** 轮播图 */
@property(strong,nonatomic) NSArray * photos;

@property(strong,nonatomic) NSString * favorite;
/** 活动价格 */
//@property(strong,nonatomic) NSString * activity_price;
/** 活动标题 */
@property(strong,nonatomic) NSString * activity_title;
@property(strong,nonatomic) NSString * activity_desc;

/** 规格数组 */
@property(strong,nonatomic) NSArray <GoodsParameterModel*> *parameterArray;
@property(strong,nonatomic) NSArray <GoodsParameterModel*> *gsf1;

/**展示的价格*/
@property (nonatomic, copy) NSString *showPrice;

@property (nonatomic, strong) NSArray *skuArray;
/**上下架状态*/
@property (nonatomic, assign)NSInteger goods_status;

@end
