//
//  CaptchaView.h
//  test
//
//  Created by TheMacBook on 16/6/21.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CaptchaViewDelegate <NSObject>
@optional
/** 返回最新验证码*/
- (void)currentCaptcha:(NSString *)captchaStr;
@end
@interface CaptchaView : UIView

@property (nonatomic , weak) id <CaptchaViewDelegate> delegate;///< CaptchaViewDelegate

/**
 *  初始化view 可带背景颜色
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithColor:(UIColor *)color;

- (void)refresh;

@end
