//
//  AccountCellModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AccountCellModel.h"

@implementation AccountCellModel
- (instancetype)initWithTitle:(NSString *)title
                        value:(NSNumber *)value
                       prompt:(NSString *)prompt
                  isAccessory:(NSNumber *)isAccessory
{
    self = [super init];
    if(self)
    {
        _title = title;
        _value = [value doubleValue];
        _prompt = prompt;
        _isAccessory = [isAccessory boolValue];
    }
    return self;
}
@end
