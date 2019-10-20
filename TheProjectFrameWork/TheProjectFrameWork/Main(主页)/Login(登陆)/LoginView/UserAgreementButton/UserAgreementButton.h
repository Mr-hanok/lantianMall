//
//  UserAgreementButton.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserAgreementButtonDelegate <NSObject>
@optional
/**
 *  点击用户协议
 */
- (void)userAgreementRedirect;
/**
 *  点击选择与否
 */
- (void)userAgreementClickWithButton:(UIButton *)sender;
@end

/**
 *  提示用户阅读用户协议
 */
@interface UserAgreementButton : UIView
@property (nonatomic , copy) NSString * text; ///< 文本
@property (nonatomic , copy) NSString * keyWord;///< 关键字
@property (nonatomic , assign) CGFloat height;
@property (nonatomic , assign , getter=isSelected) BOOL  selected;
@property (nonatomic , weak) id <UserAgreementButtonDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title
                      keyWord:(NSString *)keyword;

@end
