//
//  ParameterDetialModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ParameterDetialModel.h"

@implementation ParameterDetialModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"parameterDetialID" : @"id",
             @"parameterDetialValues" : @"value",
             };
}
@end
