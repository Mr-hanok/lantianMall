//
//  PromotionGoodsModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionGoodsModel : NSObject

@property (nonatomic , assign) NSInteger goodsID;
@property (nonatomic , copy) NSString * goods_name;
@property (nonatomic , copy) NSString * imgPath;
@property (nonatomic , assign) CGFloat goods_price;
@property (nonatomic , assign) CGFloat ag_price;

@end


@interface PromotionGoodsScrollModel : NSObject

@property (nonatomic , copy) NSString * img_url;
@property (nonatomic , copy) NSSet * scrollID;
@property (nonatomic , copy) NSString * addTime;
@property (nonatomic , copy) NSString * ad_url;
@property (nonatomic , copy) NSString * value;
@property (nonatomic , copy) NSString * type;


@end