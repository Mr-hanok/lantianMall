//
//  MineTableViewHeaderView.h
//  test
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//  我的页面tableviewHeaderView

#import <UIKit/UIKit.h>

@class MineTableViewHeaderView;
@protocol MineTableViewHeaderViewDelegate <NSObject>
/**
 *  点击了用户信息
 */
- (void)headerClickIcon;
- (void)mineTableViewHeader:(MineTableViewHeaderView *)header Language:(LanguageTypes)language;
- (void)mineTableViewHeaderAssisClickWithType:(NSInteger)type;
- (void)mineTableViewHeaderAccountManager;
@end
@interface MineTableViewHeaderView : UIView
@property (nonatomic , weak) id <MineTableViewHeaderViewDelegate> delegate;
/**
 *  更新数据以及切换语言
 */
- (void)updateViewInfo;
- (instancetype)initWithUserModel:(id)model;
- (void)settingLanguage:(LanguageTypes)language;
- (void)settingUserIconWithImage:(UIImage *)image;
@end
