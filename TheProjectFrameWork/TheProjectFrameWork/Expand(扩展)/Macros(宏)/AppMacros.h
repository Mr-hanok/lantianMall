//
//  AppMacros.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#ifndef AppMacros_h
#define AppMacros_h

/** 语言国际化 */
#define LaguageControl(str) [LaguageControl languageWithString:str]

#define LaguageControl11(str) [NSString stringWithFormat:@"  %@  ",str]
/** 语言国际化拼接 */
#define LaguageControlAppend(str) [LaguageControl(str) stringByAppendingString:@": "]
/** 语言国际化多字符拼接 */
#define LaguageControlAppendStrings(str,appendStr) [LaguageControlAppend(str) stringByAppendingString:LaguageControl(appendStr)];

/** 系统字体 */
#define KSystemFont(Size) [UIFont systemFontOfSize:(Size)]



#define kDefaultGoodsImgV   @"defaultImgForGoods"
#define kDefaultGoodsImgH   @"defaultImgForGoods"
#define kDefaultBannerImage   @"defaultImgbanner"
#define kDefaultGoodsDetail   @"defaultImgGoodsdetail"
//
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define Kwindow [UIApplication sharedApplication].keyWindow 
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define kTopSpace self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height
// Tabbar高度
#define KTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
// 导航栏高度
#define kNavigaTionBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height+44)
// CollectionViewCell高度
#define KPersonalCollectionViewCellHeight 80

#define KArc4andomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
#define KAppRootNaVigationColor kNavigationColor
#define KArc4andomPrices [NSString stringWithFormat:@"%u",arc4random()%255] ;


#define kBGColor            [UIColor colorWithString:@"#ECECEC"]    //灰色背景
#define KDeepBlueColor     [UIColor colorWithString:@"#4694d1"]//深蓝色
#define kOrangeColor       [UIColor colorWithString:@"#f39800"]//橘色
#define kLigihtOrageColor  [UIColor colorWithString:@"#b0a79e"]//浅橘色
#define KSepLineColor      [UIColor colorWithString:@"#efefef"]//分割线颜色浅浅灰

#define KMingChuColor      [UIColor colorWithString:@"#4273E1"]
#define kTextDeepDarkColor [UIColor colorWithString:@"#555555"]//深灰色
#define kTextMiddleDarkColor [UIColor colorWithString:@"#898989"]//中灰色
#define kTextLightDarkColor [UIColor colorWithString:@"#c9caca"]//浅灰色
#define kMutButtonSelectGrayColor [UIColor colorWithString:@"#DCDCDD"]//浅灰色
#define kNavigationBackColor  [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.f]

#define kNavigationColor       [UIColor colorWithString:@"#EF7432"]
#define kNavigationCGColor     [UIColor colorWithString:@"#EF7432"].CGColor

#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#define kDefaultPageSize  @"10"

//对弱引用self
#define WeakSelf(self)  __weak typeof(self) weakSelf = self;
//对弱引用的self 进行强引用
#define StrongSelf(weakSelf) __strong typeof(weakSelf) strongSelf = weakSelf
#endif /* AppMacros_h */
