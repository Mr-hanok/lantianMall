//
//  ShopGoodsManagerModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopGoodsManagerModel : NSObject
@property (nonatomic , assign) NSInteger goodsId;
@property (nonatomic , copy) NSString * goodsName;
@property (nonatomic , copy) NSString * imgName;
@property (nonatomic , copy) NSString * imgPath;
@property (nonatomic , assign) BOOL recomend;
@property (nonatomic , assign) CGFloat goodsPrice;
@property (nonatomic , assign) NSInteger goods_inventory;
@property (nonatomic , assign) CGFloat storePrice;
@end
