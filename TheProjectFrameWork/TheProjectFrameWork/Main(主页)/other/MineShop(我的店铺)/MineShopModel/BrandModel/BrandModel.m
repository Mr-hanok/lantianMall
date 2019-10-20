//
//  BrandModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"image":@"brandlogoname",@"brandID":@"id"};
}
@end
