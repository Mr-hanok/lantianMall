//
//  PayView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
#import "CorePasswordView.h"

@class CorePasswordView;
@interface PayView : BaseView
@property(assign,nonatomic) BOOL isShow;
/** 输入密码 */
@property (weak, nonatomic) IBOutlet UILabel *EnterthepasswordLabel;
@property(strong,nonatomic) NSString * payPassWords;
@property (weak, nonatomic) IBOutlet UIView *payPasswordView;
@property (weak, nonatomic) IBOutlet UIButton *forgotpasswordButton;
@property(strong,nonatomic) CorePasswordView * coreview;

//@property (nonatomic, copy) NSString *moneyStr;//钱
//@property (nonatomic, copy) NSString *remarkStr;//备注
-(void)showView:(void (^)(BOOL success,NSString *codestr))block;
//-(void)showView;

-(void)viewDissMissFromWindow;

@end
