//
//  ClassGoodsModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface ClassGoodsModel : BaseModel

/** 商品id */
@property(strong,nonatomic) NSString * classModelID;
/** 商品名称 */
@property(strong,nonatomic) NSString * classModelName;
/** 商店价格 */
@property(strong,nonatomic) NSString * storePrice;
/** 商品价格 */
@property(strong,nonatomic) NSString * goodsPrice;
/** 商品描述 */
@property(strong,nonatomic) NSString * goods_details;

@property(strong,nonatomic) NSString * goods_imageUrl;

@property(strong,nonatomic) NSString * description_evaluate;
/** 关注 */
@property(strong,nonatomic) NSString * favorite;
/** 活动价格 */
@property(strong,nonatomic) NSString * activity_price;
/** 活动标题 */
@property(strong,nonatomic) NSString * activity_title;

@property (nonatomic, copy) NSString *showPrice;


@end
