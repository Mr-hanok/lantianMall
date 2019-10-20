//
//  ImageModel.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"imageId" : @"id",
             };
}
@end
