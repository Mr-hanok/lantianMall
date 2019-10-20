//
//  FaceBookUserModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "FacebookUserModel.h"

@implementation FacebookUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"FacebookID":@"id"};
}

@end
