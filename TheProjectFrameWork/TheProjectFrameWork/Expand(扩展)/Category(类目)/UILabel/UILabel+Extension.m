//
//  UILabel+Extension.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "UILabel+Extension.h"
#import <CoreText/CoreText.h>
@implementation UILabel (Extension)
- (instancetype)initWithText:(NSString *)text{
    self = [super init];
    if(self)
    {
        self.text = [LaguageControl languageWithString:text];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
    }
    return self;
}
@end
