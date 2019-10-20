//
//  NSString+OrderStatus.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/11/9.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OrderStatus)
+ (NSString *)orderStatus:(NSInteger)status;
+ (NSString *)balanceStatus:(NSInteger)status;

@end
