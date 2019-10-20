//
//  LaguageControl.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>


typedef NS_ENUM (NSInteger, LanguageTypes){
    LanguageTypesDefault = 0,
    LanguageTypesChinese = 1,
    LanguageTypesEnglish = 2,
    LanguageTypesMalas = 3,
};
typedef void(^ChangeLanguageBlock)(void);
@protocol LaguageControlDelegate <NSObject>

-(void)languageChanged;

@end
@interface LaguageControl : NSObject

@property(strong,nonatomic) UITabBarItem * MainTarBar;
@property(strong,nonatomic) UITabBarItem * IntegralMallTarBar;
@property(strong,nonatomic) UITabBarItem * CattTarBar;
@property(strong,nonatomic) UITabBarItem * PresonTarBar;
@property(strong,nonatomic) UITabBarItem * MoreTarBar;

@property(assign,nonatomic) LanguageTypes  type;
@property(strong,nonatomic) NSBundle * bundle;
@property(strong,nonatomic) NSString * thetypes;

@property(weak,nonatomic) id <LaguageControlDelegate> delegate;
@property (nonatomic , copy) ChangeLanguageBlock changeBackBlock;

/** 初始化单例 */
+(LaguageControl*)shareControl;
/** 获取字符信息 */
+(NSString*)languageWithString:(NSString*)string;

- (void)languageChangeComplete:(ChangeLanguageBlock)complete;



@end
