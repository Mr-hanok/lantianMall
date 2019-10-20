//
//  UIColor+NSString.h
//  iplaza
//
//  Created by Tozy on 13-4-27.
//  Copyright (c) 2013年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NSString)
//以#开头的字符串（不区分大小写），如：#ffFFff，若需要alpha，则传#abcdef255，不传默认为1
+ (UIColor *)colorWithString:(NSString *)name;
@end
