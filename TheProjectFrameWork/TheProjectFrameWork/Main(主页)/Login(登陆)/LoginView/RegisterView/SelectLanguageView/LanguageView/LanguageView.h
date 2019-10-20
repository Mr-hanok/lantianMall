//
//  LanguageView.h
//  test
//
//  Created by ZengPengYuan on 16/6/24.
//  Copyright © 2016年 ZengPengYuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LanguageViewDelegate <NSObject>
@optional
- (void)languageWithCurrentLanguage:(LanguageTypes)language;
@end
@interface LanguageView : UIView
/**
 *  初始化对象
 *
 *  @param image image
 *  @param title title
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title;
- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                   titleColor:(UIColor *)color;
/**
 *   设置选中状态
 *
 *  @param status <#status description#>
 */
- (void)setStatusWithBool:(BOOL)status;
@property (nonatomic , copy) NSString * title;///< 文本
@property (nonatomic , assign) LanguageTypes language;

@property (nonatomic , weak) id <LanguageViewDelegate>delegate;
@end
