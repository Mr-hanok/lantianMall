//
//  HomeGoodsDetial.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface HomeGoodsDetial : BaseModel
@property(strong,nonatomic) NSString * goodsId;

@property(strong,nonatomic) NSString * imgName;

@property(strong,nonatomic) NSString * imgPath;

@property(strong,nonatomic) NSString * goodsName;

@property(strong,nonatomic) NSString * storePrice;

@property(strong,nonatomic) NSString * goodsPrice;

@property(strong,nonatomic) NSString * recomend;

@property(strong,nonatomic) NSString * goods_inventory;

@property(strong,nonatomic) NSString * activity_title;

//@property(strong,nonatomic) NSString * activity_price;

@property (nonatomic, copy) NSString *activity_tag;
@end
