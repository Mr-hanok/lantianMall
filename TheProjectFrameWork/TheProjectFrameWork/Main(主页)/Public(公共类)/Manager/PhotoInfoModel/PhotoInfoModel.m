//
//  PhotoInfoModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PhotoInfoModel.h"

@implementation PhotoInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"photoID":@"id"};
}
@end
