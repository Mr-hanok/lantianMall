//
//  AdressAreaModel.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AdressAreaModel.h"

@implementation AdressAreaModel
+(NSDictionary*)mj_replacedKeyFromPropertyName

{
    
    return @{
             
             @"areaId" : @"id",
             
             };
    
}

+ (NSDictionary *)objectClassInArray{
    
    return @{
             
             @"childs" : [AdressAreaModel class],
             
             };
    
}
@end
