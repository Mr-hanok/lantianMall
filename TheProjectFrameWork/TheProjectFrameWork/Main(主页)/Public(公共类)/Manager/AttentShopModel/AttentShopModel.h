//
//  AttentShopModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "VipPriceModel.h"

@interface AttentShopModel : BaseModel
/** 店铺id */
@property(strong,nonatomic) NSString * attentshopID;
/** 店铺logo */
@property(strong,nonatomic) NSString * store_logo;
/** 店铺模板 */
@property(strong,nonatomic) NSString * store_template;
/** 店铺名称 */
@property(strong,nonatomic) NSString * store_name;
/** 店铺轮播数组 */
@property(strong,nonatomic) NSArray * storeSlideArray;
/** 关注数量 */
@property(strong,nonatomic) NSString * favorite_count;
/** <#注释#> */
@property(strong,nonatomic) NSArray * url;
/** <#注释#> */
@property(strong,nonatomic) NSArray * goodsInfoArray;


/** 描述相符 */
@property(strong,nonatomic) NSString * description_evaluate_halfyear;
/** 发货速度 */
@property(strong,nonatomic) NSString * ship_evaluate_halfyear;
/** 服务态度 */
@property(strong,nonatomic) NSString * service_evaluate_halfyear;
/** 管理类型 */
@property(strong,nonatomic) NSString * managed_self;
/** 店铺信用等级 */
@property(strong,nonatomic) NSString * store_credit;
/** 店铺等级 */
@property(strong,nonatomic) NSString * gradeName;
/** 店铺类型 */
@property(strong,nonatomic) NSString * storeType;
/** 是否关注 */
@property(strong,nonatomic) NSString * favorite;

/** 店铺用户ID */
@property(strong,nonatomic) NSString * store_userId;
/** 店铺用户名 */
@property(strong,nonatomic) NSString * store_userName;
/** 店铺条幅图片 */
@property(strong,nonatomic) NSString * store_banner;


@property (nonatomic, strong) NSArray *viePriceArray;





@end
