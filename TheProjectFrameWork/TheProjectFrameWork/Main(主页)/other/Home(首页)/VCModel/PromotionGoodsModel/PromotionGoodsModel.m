//
//  PromotionGoodsModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PromotionGoodsModel.h"

@implementation PromotionGoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goodsID":@"id"};
}
@end


@implementation PromotionGoodsScrollModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"scrollID":@"id",@"value":@"ad_type_value",@"type":@"ad_type"};
}

-(void)TestDic{
    NSDictionary * dic = [NSDictionary dictionary];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];
}
@end