//
//  GoodsEvaluationModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsEvaluationModel.h"

@implementation GoodsEvaluationModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"evaluationID" : @"id",
             };
}
@end
