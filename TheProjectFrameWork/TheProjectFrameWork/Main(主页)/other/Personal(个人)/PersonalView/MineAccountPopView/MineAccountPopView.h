//
//  MineAccountPopView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  我的账户 弹出视图

#import "BasePopView.h"
@class CountDownButton,MineAccountPopView,AccountCellModel;
/*********************************************/
/**
 *  代理方法MineAccountPopViewDelegate
 */
@protocol MineAccountPopViewDelegate <NSObject>
/**
 *  点击保存事件
 */
- (void)accountPop:(MineAccountPopView *)popView SaveInfo:(id)info;
@optional
/**
 *  获取验证码
 */
- (void)accountPop:(id)popView GetCode:(CountDownButton *)sender;
@end
@interface MineAccountPopView : BasePopView
- (instancetype)initWithType:(NSInteger)type;

@property (nonatomic , copy) NSString * title; ///< 标题

@property (nonatomic , weak) UILabel * titleLabel;
;
@property (nonatomic , assign) NSInteger type;

@property (nonatomic , strong) AccountCellModel * model;

@property (nonatomic , copy) NSString * code; ///< 获取到的验证码

@property (nonatomic , weak) id <MineAccountPopViewDelegate> delegate;
- (void)saveEvent;
@end
/*********************************************/

/**
 *  姓名
 */
@interface AccountNamePopView : MineAccountPopView

@end


/*********************************************/


/**
 *  性别
 */
@interface AccountSexPopView : MineAccountPopView

@end

/**
 *  出生日期
 */
@interface AccountBirthPopView : MineAccountPopView

@end

/**
 *  期限
 */
@interface AccountQiXianPopView : MineAccountPopView
@property (nonatomic, assign) BOOL isweilai;
@end


/*********************************************/


/**
 *  手机号
 */
@interface AccountPhonePopView : MineAccountPopView

@end


/*********************************************/

/**
 *  电子邮箱
 */
@interface AccountEmailPopView : MineAccountPopView

@end
