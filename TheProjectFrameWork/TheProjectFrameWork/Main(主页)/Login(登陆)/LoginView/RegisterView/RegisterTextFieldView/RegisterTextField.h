//
//  RegisterTextField.h
//  test
//
//  Created by TheMacBook on 16/6/24.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterTextField,SelectePhoneTextField;
@protocol RegisterTextFielDelegate <NSObject>
@optional
/** 返回验证码是否正确 */
- (void)verificationCode:(BOOL)isTure;
/** 返回当前输入内容*/
- (void)currentTextString:(NSString *)text textField:(RegisterTextField *)textField;
/** 结束编辑*/
- (void)didEndEditTextString:(NSString *)text textField:(RegisterTextField *)textField;
@end


@interface RegisterTextField : UIView
{
    UILabel * _label;
    NSString * _securityCode;
}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic , copy) NSString * text;///< 文本信息

@property (nonatomic , copy) NSString * title;

@property (nonatomic , copy) NSString * placeholder;

@property (nonatomic , assign) BOOL secureTextEntry;

@property (nonatomic , assign) BOOL sideline;

@property (nonatomic , weak) id <RegisterTextFielDelegate> delegate; ///< RegisterTextFielDelegate

/**
 *  注册textfield初始化
 *
 *  @param text        譬如 用户名之类
 *  @param placeholder 譬如 请输入用户名称
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithText:(NSString *)text
                 placeholder:(NSString *)placeholder;

/**
 *  注册textfield初始化
 *
 *  @param placeholder 譬如 请输入用户名称
 *  @param isVerify    是否带有验证码
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithPlaceholder:(NSString *)placeholder
                           isVerify:(BOOL)isVerify;


/**
 *  赋值方法
 *
 *  @param text        <#text description#>
 *  @param placeholder <#placeholder description#>
 */
- (void)loadWithText:(NSString *)text placeholder:(NSString *)placeholder;
- (void)justifiedAlignment;
- (void)removeTextString;
@end


@protocol SelectePhoneTextFieldDelegate <NSObject>

@optional
- (void)selectPhoneChangeArea:(SelectePhoneTextField *)textFide;
- (void)selectPhoneTextChange:(SelectePhoneTextField *)textFidel;
@end

@interface SelectePhoneTextField : UIView
@property (nonatomic , weak) id<SelectePhoneTextFieldDelegate> delegate;
@property (nonatomic , copy) NSString * areaPhoneCode;
@property (nonatomic , copy) NSString * phone;


- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
- (void)chaneAreaCode:(NSString *)code;
@end

@interface SelectAreaButton : UIButton

@end
