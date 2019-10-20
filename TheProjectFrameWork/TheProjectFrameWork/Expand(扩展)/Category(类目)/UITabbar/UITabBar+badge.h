//
//  UITabBar+badge.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index withBadgeValue:(NSString*)badgevaluse;   //显示小红点

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
