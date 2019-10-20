//
//  SelectLanguageView.h
//  test
//
//  Created by ZengPengYuan on 16/6/24.
//  Copyright © 2016年 ZengPengYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectLanguageViewDelegate <NSObject>
/** 点击时传递点击的语言字符串 */
- (void)selectLanguageCurrentLanguage:(LanguageTypes)language;
@end

@interface SelectLanguageView : UIView

@property (nonatomic , strong) NSArray * imageArray;

@property (nonatomic , strong) NSArray * titleArray;

@property (nonatomic , weak) id <SelectLanguageViewDelegate>delegate;

/**
 *  初始化视图
 *
 *  @param imageArray 图片数组
 *  @param titleArray 标题数组
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray
                            titles:(NSArray *)titleArray;

@end
