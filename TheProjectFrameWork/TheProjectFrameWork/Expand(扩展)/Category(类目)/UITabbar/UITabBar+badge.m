//
//  UITabBar+badge.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "UITabBar+badge.h"
#define TabbarItemNums 5.0    //tabbar的数量 如果是5个设置为5.0

@implementation UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index withBadgeValue:(NSString*)badgevaluse{
    [self removeBadgeOnItemIndex:index];
    UILabel * label = [[UILabel alloc] init];
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    label.layer.cornerRadius = 7;//圆形
    label.layer.masksToBounds = YES;
    label.frame = CGRectMake(x-5, y-5, 15, 15);//圆形大小为10
    label.tag = 888+index;
    label.font = [UIFont systemFontOfSize:10];
    label.text = badgevaluse;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    [self bringSubviewToFront:label];
}//显示小红点

- (void)showBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UILabel *badgeView = [[UILabel alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.layer.masksToBounds = YES;
    badgeView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.7];//颜色：红色
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];
    [self bringSubviewToFront:badgeView];
}
- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}
//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
