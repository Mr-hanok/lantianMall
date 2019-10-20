//
//  AreaModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2017/2/15.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"cities":@"CityModel"};
}
@end


@implementation CityModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"counties":@"TownModel"};
}

@end

@implementation TownModel



@end
