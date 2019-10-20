//
//  LoginTextField.h
//  test
//
//  Created by TheMacBook on 16/6/21.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  LoginTextFieldDelegate <NSObject>
@optional

/** 返回用户账号 */
- (void)currentUserNumber:(NSString *)userNumber;
/** 返回用户密码 */
- (void)currentPassWord:(NSString *)password;
/** 返回验证码是否正确 */
- (void)verificationCode:(BOOL)isTure;

@end

@interface LoginTextField : UIView

@property (nonatomic , strong) UILabel * textLabel;///< 譬如 用户 密码之类
@property (nonatomic , strong) UITextField * textField;///< 用户输入内容

@property (nonatomic , weak) id <LoginTextFieldDelegate> delegate;  ///< LoginTextFieldDelegate

/**
 *
 *
 *  @param text            文本信息
 *  @param placeholder     textField默认信息
 *  @param SecureTextEntry 是否显示密文
 *  @param authCode        是否需要显示验证码
 *
 *  @return LoginTextView Instancetype
 */
- (instancetype) initWithText:(NSString *)text
                  placeholder:(NSString *)placeholder
            isSecureTextEntry:(BOOL)SecureTextEntry
                   isAuthCode:(BOOL)authCode;

- (void)justifiedAlignmentTitle;
- (void)refreshVerificationCode;
@end
