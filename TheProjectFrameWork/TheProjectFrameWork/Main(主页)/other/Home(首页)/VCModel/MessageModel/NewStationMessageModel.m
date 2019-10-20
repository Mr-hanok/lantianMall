//
//  NewStationMessageModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/10/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NewStationMessageModel.h"

@implementation NewStationMessageModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"messageID" : @"id",
             @"messageaddtime" : @"addTime",
             @"messageContent" : @"content",
             };
}
@end
