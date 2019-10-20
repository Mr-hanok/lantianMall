//
//  ScreenDetialModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ScreenDetialModel.h"

@implementation ScreenDetialModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"detialID" :@"id",
             @"detialName":@"name",
             @"detialStandName":@"value",
             };
}
@end
