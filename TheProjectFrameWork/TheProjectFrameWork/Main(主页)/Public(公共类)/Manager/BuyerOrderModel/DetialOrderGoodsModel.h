//
//  DetialOrderGoodsModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface DetialOrderGoodsModel : BaseModel
@property(strong,nonatomic) NSString * goodsgcsID;
@property(strong,nonatomic) NSString * goodsID;
@property(strong,nonatomic) NSString * goods_name;
@property(strong,nonatomic) NSString * goodstax_rate;
@property(strong,nonatomic) NSString * goodsUrl;
@property(strong,nonatomic) NSString * price;
@property(strong,nonatomic) NSString * spec_info;
@property(strong,nonatomic) NSString * count;

@property (nonatomic, copy) NSString *youHuiPrice;
@property (nonatomic, copy) NSString *adjust_price;
@end
