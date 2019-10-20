//
//  NSString+HidePhone.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/10/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HidePhone)
+ (NSString *)hidePhoneArcaCode:(NSString *)code phone:(NSString *)phone;
+ (NSString *)hidePhone:(NSString *)phone;
@end
