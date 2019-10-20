//
//  SearchModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface SearchModel : BaseModel
/** 店铺id */
@property(strong,nonatomic) NSString * storeID;
/** 店铺名称 */
@property(strong,nonatomic) NSString * storename;
/** 店铺logo */
@property(strong,nonatomic) NSString * store_logo;
/** 关注数量 */
@property(strong,nonatomic) NSString * favorite_count;
/** 商品数组 */
@property(strong,nonatomic) NSMutableArray * goodsArray;

@end
