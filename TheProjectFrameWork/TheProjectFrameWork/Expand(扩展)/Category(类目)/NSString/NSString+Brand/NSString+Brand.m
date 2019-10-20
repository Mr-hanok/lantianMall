//
//  NSString+Brand.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NSString+Brand.h"

@implementation NSString (Brand)
+ (NSString *)BrandStatus:(NSInteger)status
{
    NSString * statusStr = nil;
    switch (status) {
        case -1:
            statusStr = LaguageControl(@"审核失败");
            break;
        case 0:
            statusStr = LaguageControl(@"审核中");
            break;
        case 1:
            statusStr = LaguageControl(@"审核成功");
        default:
            break;
    }
    return statusStr;
}
@end
