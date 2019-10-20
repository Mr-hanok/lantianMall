//
//  MineHeaderLanguageView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  我的 页面 选择语言控件

#import <UIKit/UIKit.h>
@protocol MineHeaderLanguageViewDelegate <NSObject>
@optional
- (void)mineHeaderLanguage:(LanguageTypes)language;
@end
@interface MineHeaderLanguageView : UIView
- (instancetype)initWithCurretnStr:(NSString *)current;
@property (nonatomic , copy) NSString * currentTitle;
@property (nonatomic , strong) UIImage * currentImage;
@property (nonatomic , weak) id <MineHeaderLanguageViewDelegate>delegate;
@end
