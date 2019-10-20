//
//  HUDManager.m
//  yilingdoctorCRM
//
//  Created by zhangxi on 14/10/28.
//  Copyright (c) 2014年 yuntai. All rights reserved.
//

#import "HUDManager.h"

static MBProgressHUD *HUDView;
@implementation HUDManager

+ (void)showWarningWithText:(NSString *)text {
    [HUDManager hideHUDView];
    if ([text isKindOfClass:[NSNull class]]) {
        return;
    }
    if (!text.length)
    {
        
    }
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//    hud.labelText = LaguageControl(text);
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.f];;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = NO;
    hud.margin = 12.f;
    if (!text) {
        text =@"";
    }
    if (text.length>10&&text)
    {
        [hud hide:YES afterDelay:1.5];
    }
    else{
        [hud hide:YES afterDelay:1.0];
    }
}

+ (void)showWarningWithText:(NSString *)text andTime:(float) addTime{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [HUDManager hideHUDView];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.detailsLabelText = text;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = NO;
    hud.margin = 12.f;
    if (text.length>10) {
        [hud hide:YES afterDelay:text.length/10];
    }
    else{
        [hud hide:YES afterDelay:addTime];
    }
}
+ (void)showLoadingHUDView:(UIView*)view
{
    [HUDManager hideHUDView];
    HUDView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUDView.mode = MBProgressHUDModeIndeterminate;
    HUDView.margin = 18.f;
    HUDView.opacity = 0.55;
//    HUDView.dimBackground = YES;
    HUDView.detailsLabelText = @"努力加载中";
    HUDView.minShowTime = 0.3;
    HUDView.detailsLabelFont = [UIFont boldSystemFontOfSize:14];
}



+ (void)showLoadingHUDView:(UIView*)view withText:(NSString *)text {
    [HUDManager hideHUDView];

    HUDView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUDView.mode = MBProgressHUDModeIndeterminate;
    HUDView.margin = 18.f;
    HUDView.opacity = 0.55;
    HUDView.dimBackground = YES;
    HUDView.detailsLabelText = text;
    if (text.length>10) {
        HUDView.minShowTime = 1;

    }
    else{
        HUDView.minShowTime = 0.3;
    }
 
    HUDView.detailsLabelFont = [UIFont boldSystemFontOfSize:14];
}

+ (void)hideHUDView
{
    [HUDView hide:YES];
}

+ (void)showWarningWithError:(id)error
{
    if(error == nil || [error isKindOfClass:[NSNull class]])
    {
        return;
    }
    if([error isKindOfClass:[NSString class]])
    {
        NSString * err = error;
        if(err.length == 0)
        {
            return;
        }
        [self showWarningWithText:err];
        return;
    }
    if([error isKindOfClass:[NSError class]])
    {
        NSError * err = error;
        if(err.code == -1004 || err.code == -999 || err.code == -1011 || err.code == -1001)
        {
//            [self showWarningWithText:@"请检查网络"];
        }else
        {
            [self showWarningWithText:@"未知错误"];
        }
        return;
    }
}
@end
