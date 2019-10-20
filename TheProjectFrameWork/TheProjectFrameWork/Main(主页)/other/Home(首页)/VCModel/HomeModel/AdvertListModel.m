//
//  AdvertListModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AdvertListModel.h"

@implementation AdvertListModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"advermodelID" :@"id",
             };
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if (oldValue == nil) return @"";
    if (oldValue == NULL) return @"";
    if ([oldValue isKindOfClass:[NSNull class]]) return @"";
    return oldValue;
}
@end
