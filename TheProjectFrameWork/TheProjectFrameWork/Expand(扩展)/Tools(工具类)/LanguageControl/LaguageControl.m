//
//  LaguageControl.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LaguageControl.h"

@implementation LaguageControl
static LaguageControl * control = nil;

+(LaguageControl *)shareControl
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[LaguageControl alloc] init];
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        //1.第一步改变bundle的值
  
        NSString * type = [def objectForKey:@"userLanguageType"];
        control.type =[type integerValue];
        NSString * language = [def objectForKey:@"userLanguage"];
        if (!type) {
            language = [language substringToIndex:2];
            
            if ([language isEqualToString:@"zh"])
            {
                control.type =LanguageTypesChinese;

            }
            else if ([language isEqualToString:@"ms"])
            {
                control.type =LanguageTypesMalas;

            }
            else{
                language = @"en";
                control.type =LanguageTypesEnglish;
            }
        }
        switch (control.type)
        {
            case LanguageTypesChinese:
                language =@"zh-Hans";
                break;
            case LanguageTypesMalas:
                language =@"ms";

                break;
            case LanguageTypesEnglish:
                language =@"en";
                break;
                
            default:
                break;
        }
        language =@"zh-Hans";
        control.type =LanguageTypesChinese;

        NSString * path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
        control.bundle = [NSBundle bundleWithPath:path];
        NSArray* languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString * current = [languages objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setValue:current forKey:@"userLanguage"];
        [[NSUserDefaults standardUserDefaults] synchronize];//持久化，不加的话不会保存
        [control addObserver:control forKeyPath:@"type" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    });

    return control;
}
+(NSString*)languageWithString:(NSString*)string
{
    NSString * strings = [[LaguageControl shareControl].bundle localizedStringForKey:string value:nil table:@"Language"];
    return strings ;
}

- (void)languageChangeComplete:(ChangeLanguageBlock)complete
{
    _changeBackBlock = complete;
}

-(NSString *)userLanguage{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:@"userLanguage"];
    return language;
}

-(void)setUserlanguage:(NSString *)language{
    
    if ([self userLanguage]==language) {
        return ;
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //1.第一步改变bundle的值
    [def setValue:language forKey:@"userLanguage"];
    [def synchronize];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
    [def setObject:@(self.type) forKey:@"userLanguageType"];
    [def synchronize];
    self.MainTarBar.title = [LaguageControl languageWithString:@"首页"];
    self.IntegralMallTarBar.title =[LaguageControl languageWithString:@"积分商城"];
    self.CattTarBar.title =[LaguageControl languageWithString:@"购物车"];
    self.PresonTarBar.title =[LaguageControl languageWithString:@"我的"];
    self.MoreTarBar.title =[LaguageControl languageWithString:@"更多"];
    if ([self.delegate respondsToSelector:@selector(languageChanged)]) {
        [self.delegate languageChanged];
    }
    if(_changeBackBlock)
    {
        _changeBackBlock();
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
        switch (control.type) {
            case LanguageTypesDefault:
                break;
            case LanguageTypesChinese:
                [control setUserlanguage:@"zh-Hans"];
                break;
            case LanguageTypesEnglish:
                [control setUserlanguage:@"en"];
                break;
            case LanguageTypesMalas:
                [control setUserlanguage:@"ms"];
                break;
            default :
                break;
        }
}
@end
