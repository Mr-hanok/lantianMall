//
//  PopVerifyView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopVerifyView;
@protocol PopVerifyViewDelegate <NSObject>
@optional

/**
 *  获取验证码
 */
- (void)popVerifyGetCode:(PopVerifyView *)verifyView;
/**
 *  验证通过(点击确定)
 */
- (void)popVerifyPassWith:(PopVerifyView *)verifyView;
@end
@protocol PopVerifyViewOtherDelegate <NSObject>

- (void)popVerifyTimeToCompleteAndNoSuperView:(PopVerifyView *)verifyView;


@end
@interface PopVerifyView : UIView

@property (nonatomic , weak) id <PopVerifyViewDelegate> delegate;

@property (nonatomic , weak) id <PopVerifyViewOtherDelegate> otherDelegate;


@property (nonatomic , copy) NSString * senderString;

@property (nonatomic , copy) NSString * verifyCode; ///< 获取到的验证码
@property (nonatomic , copy) NSString * text;

@property (nonatomic , assign) PopVerifyTypes type;
@property (nonatomic , copy) NSString * templateString;

+ (PopVerifyView *)creatPopVerifyWithType:(PopVerifyTypes)type sender:(NSString *)sender;
- (void)start;
- (void)displayToWindow;
- (void)removeFromWindow;
- (void)verifySuccess;
@end
