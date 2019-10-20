//
//  NSString+HidePhone.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/10/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NSString+HidePhone.h"

@implementation NSString (HidePhone)
+ (NSString *)hidePhoneArcaCode:(NSString *)code phone:(NSString *)phone
{
    NSString * hideString = [phone stringByReplacingCharactersInRange:(NSRange){2,4} withString:@"****"];
    return [NSString stringWithFormat:@"%@%@",code,hideString];
}

+ (NSString *)hidePhone:(NSString *)phone
{
    NSString * hideString = [phone copy];
    if([NSString verifyPhoneWithPhone:phone])
    {
        return hideString = [phone stringByReplacingCharactersInRange:(NSRange){3,4} withString:@"****"];
    }
    if([phone hasPrefix:@"+60"])
    {
        hideString = [phone stringByReplacingCharactersInRange:(NSRange){5,4} withString:@"****"];

    }
    if([phone hasPrefix:@"+65"])
    {
        hideString = [phone stringByReplacingCharactersInRange:(NSRange){5,4} withString:@"****"];

    }
    if([phone hasPrefix:@"+673"])
    {
        hideString = [phone stringByReplacingCharactersInRange:(NSRange){6,4} withString:@"****"];

    }
    return hideString;
}
@end
