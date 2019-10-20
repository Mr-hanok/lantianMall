//
//  HUDManager.h
//  yilingdoctorCRM
//
//  Created by zhangxi on 14/10/28.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HUDManager : NSObject

+ (void)showWarningWithText:(NSString *)text;
+ (void)showLoadingHUDView:(UIView*)view;
+ (void)showLoadingHUDView:(UIView*)view withText:(NSString *)text;
+ (void)hideHUDView;

+ (void)showWarningWithText:(NSString *)text andTime:(float) addTime;
+ (void)showWarningWithError:(id)error;
@end
