//
//  BaseMacros.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#ifndef BaseMacros_h
#define BaseMacros_h

/** 获取App版本 */
#define KVersion    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/** 获取系统版本 */
#define KsyetenVersion [[UIDevice currentDevice] systemVersion]

// 根显示窗口
#define KeyWindow [UIApplication sharedApplication].keyWindow
// 设备判断
#define KDeViceCheck  [UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad
// 判断是否为空对象
#define KIS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]
// 是否IOS7
#define KisIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否小于IOS7
#define KisIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否是iOS8以上
#define KisIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 屏幕宽度
#define KScreenBoundWidth [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define KScreenBoundHeight [UIScreen mainScreen].bounds.size.height
// 屏幕尺寸
#define kScreenFreameBound [UIScreen mainScreen].bounds
// 状态栏高度
#define kStatusHeight  [[UIApplication sharedApplication] statusBarFrame].size.height

#define kScaleWidth(width) KScreenBoundWidth * (width/375.0f) /* 根据5s的比例算宽度 */
#define kScaleHeight(height) KScreenBoundWidth * (height/375.0f)/* 根据5s的比例算高度 */
#define kAppAsiaFontSize(size) KScreenBoundWidth * (size/375.0f)
#define fixHegit(m) [UIScreen mainScreen].bounds.size.width/375.0f*(m)

#endif /* BaseMacros_h */
