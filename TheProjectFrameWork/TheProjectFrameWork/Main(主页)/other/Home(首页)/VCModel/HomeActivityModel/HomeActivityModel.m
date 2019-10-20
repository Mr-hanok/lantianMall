//
//  HomeActivityModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeActivityModel.h"

@implementation HomeActivityModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"title":@"ac_title",@"activityID":@"acId",@"imgPath":@"ac_img"};
}
@end
