//
//  LoginButton.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickAction) (id sender);
@interface LoginButton : UIButton

@property (nonatomic , copy) clickAction clickBlcok; ///< 点击事件回调

/**
 *  初始化button
 *
 *  @param block 点击事件回调
 *
 *  @return LoginButton Instancetype
 */
- (instancetype)initWithActionBlock:(clickAction)block
                              title:(NSString *)title;

- (instancetype)initWithActionBlock:(clickAction)block
                              title:(NSString *)title
                              image:(UIImage *)image;

/**
 *  设置button状态
 *
 *  @param selected <#selected description#>
 */
- (void)settingButtonSelectWithSelected:(BOOL)selected;

@end
