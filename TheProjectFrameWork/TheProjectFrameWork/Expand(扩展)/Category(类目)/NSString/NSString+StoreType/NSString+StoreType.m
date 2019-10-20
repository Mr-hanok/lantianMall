//
//  NSString+StoreType.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/10/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NSString+StoreType.h"

@implementation NSString (StoreType)
+ (NSString *)StoreType:(NSInteger)type
{
    NSString * store = nil;
    switch (type) {
        case 1:
            store = @"旗舰店";
            break;
        case 2:
            store = @"中国货品专区店";
            break;
        case 3:
            store = @"马来西亚特产店";
            break;
        case 4:
            store = @"C2C店";
            break;
        default:
            return nil;
            break;
    }
    return LaguageControl(store);
}
@end
