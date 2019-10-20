//
//  LoginViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseViewController.h"

@class LoginViewController;
typedef void(^VisitorsBuyBlock)(BOOL isBuy);
@interface LoginViewController : BaseViewController
@property (nonatomic , assign) BOOL isPrompt;
@property (nonatomic , copy) VisitorsBuyBlock buyBlcok;
@property (nonatomic , copy) void (^successLoginBlock)(BOOL issuccess);
@property (nonatomic, assign) BOOL isWeb;
/**
 *  
 *
 *  @param block <#block description#>
 */
-(void)getisToturBuy:(VisitorsBuyBlock)block;

@end
