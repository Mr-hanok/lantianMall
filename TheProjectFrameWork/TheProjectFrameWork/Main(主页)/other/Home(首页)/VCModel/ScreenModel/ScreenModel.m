//
//  ScreenModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ScreenModel.h"

@implementation ScreenModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"screenName" :@"name",
             @"screenArray":@"properties",
             @"screenPostName":@"postname",
             };
}
@end
