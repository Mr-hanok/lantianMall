//
//  HomeGoodsDetial.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeGoodsDetial.h"

@implementation HomeGoodsDetial
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"storePrice":@"currentPrice"};
}
@end
