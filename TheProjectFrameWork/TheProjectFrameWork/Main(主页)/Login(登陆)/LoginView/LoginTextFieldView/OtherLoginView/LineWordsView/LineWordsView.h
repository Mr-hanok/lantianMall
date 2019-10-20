//
//  LineWordsView.h
//  test
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineWordsView : UIView
/**
 *  初始化view并设置文字内容
 *
 *  @param text 譬如 : 其他登录方式
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithWords:(NSString *)text;
@end
