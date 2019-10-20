//
//  messageModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"messageID" : @"id",
             @"messageTime" : @"addTime",
             @"messageTitle":@"title",
             @"messageContent" : @"content",
             };
}
@end
