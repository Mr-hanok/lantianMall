//
//  NSString+ComplaintsStatus.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NSString+ComplaintsStatus.h"

@implementation NSString (ComplaintsStatus)
+ (NSString *)ComplaintStatus:(NSInteger)status
{
    NSString * statusStr = nil;
    switch (status) {
        case 0:
            statusStr = [LaguageControl languageWithString:@"新投诉"];
            break;
        case 1:
            statusStr = [LaguageControl languageWithString:@"待申诉"];
            break;
        case 2:
            statusStr = [LaguageControl languageWithString:@"对话中"];
            break;
        case 3:
            statusStr = [LaguageControl languageWithString:@"待仲裁"];
            break;
        case 4:
            statusStr = [LaguageControl languageWithString:@"已完成"];
            break;
        default:
            break;
    }
    return statusStr;
}
@end
