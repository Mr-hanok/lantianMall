//
//  AttentGoodsModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface AttentGoodsModel : BaseModel
/** 关注id */
@property(strong,nonatomic) NSString * attentsId;
/** 关注类型 */
@property(strong,nonatomic) NSString * attentstype;
/** 商品id */
@property(strong,nonatomic) NSString * attentgoodsID;
/** 商品名称 */
@property(strong,nonatomic) NSString * attentgoods_name;
/** 商品图片 */
@property(strong,nonatomic) NSString * attentgoods_main_photo;
/** <#注释#> */
@property(strong,nonatomic) NSString * attentgoods_collect;
/** 商品评价等级 */
@property(strong,nonatomic) NSString * attentgoodsdescription_evaluate;
/** 商品价格 */
@property(strong,nonatomic) NSString * attentgoods_price;
/** 商品店铺价格 */
@property(strong,nonatomic) NSString * attentstore_price;
/** 店铺id */
@property(strong,nonatomic) NSString * attentstoreID;
/** 商店名称 */
@property(strong,nonatomic) NSString * attentstore_name;
/** 店铺信用等级 */
@property(strong,nonatomic) NSString * attentstore_credit;
/** 店铺logo */
@property(strong,nonatomic) NSString * attentstore_logo;
/** 活动价格 */
@property(strong,nonatomic) NSString * activity_price;
/** 活动标题 */
@property(strong,nonatomic) NSString * activity_title;










@end
