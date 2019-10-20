//
//  MineSelectLanguaeView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MineSelectLanguaeViewDelegate <NSObject>
@optional
- (void)mineSelectLanguageWithLanguage:(LanguageTypes)language;
@end
@interface MineSelectLanguaeView : UIView
@property (nonatomic , weak) id <MineSelectLanguaeViewDelegate> delegate;


- (instancetype)initWithCurrentTitle:(NSString *)title;
- (void)startAppear;
- (void)endDidAppear;
@end
