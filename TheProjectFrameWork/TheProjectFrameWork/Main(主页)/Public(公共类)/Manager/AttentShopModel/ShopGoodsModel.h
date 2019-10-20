//
//  ShopGoodsModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface ShopGoodsModel : BaseModel
@property(strong,nonatomic) NSString * goods_name;
@property(strong,nonatomic) NSString * goodsID;
@property(strong,nonatomic) NSString * goods_logo;
@property (nonatomic, copy) NSString *activity_status;
@end
