///
//  PayView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PayView.h"
#import "ForgetPayPassWordViewController.h"
#import "IQKeyboardManager.h"
#import "NSString+Time.h"

@implementation PayView
+(id)loadView
{
   PayView * view = [super loadView];
    view.EnterthepasswordLabel.text = LaguageControl(@"输入密码");
    [view.forgotpasswordButton setTitle:LaguageControl(@"忘记密码") forState:UIControlStateNormal];
    view.frame = kScreenFreameBound;
    return view;
}
-(void)showView:(void (^)(BOOL success,NSString *codestr))block{

    [IQKeyboardManager sharedManager].enable = NO;

    self.isShow = YES;
    if (!self.coreview) {
      self.coreview  = [[CorePasswordView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-100, 40)];
      [self.payPasswordView addSubview:self.coreview];
    }
    [self.coreview clearPassword];
    __weak PayView  * weakself = self;
    self.coreview.PasswordCompeleteBlock = ^(NSString *password){
        
        NSString *md5pw = [NSString creatMD5StringWithString:password];

        /**验证支付密码*/
        [NetWork PostNetWorkWithUrl:@"/getPwSalt" with:@{@"user_id":kUserId} successBlock:^(NSDictionary *dic) {
            NSString *temstr = dic[@"data"]?:@"";
            temstr = [NSString creatMD5StringWithString:[temstr stringByAppendingString:md5pw]];
            [[NSUserDefaults standardUserDefaults] setObject:temstr forKey:MD5Pay_pwd];
            [[NSUserDefaults standardUserDefaults]synchronize];
            block(YES,temstr);
        } FailureBlock:^(NSString *msg) {
            
            block(NO,@"");
            [HUDManager showWarningWithText:msg?:@""];
            [weakself.coreview clearPassword];
        } errorBlock:^(NSError * error) {
            
            block(NO,@"");
            [weakself.coreview clearPassword];
            [HUDManager showWarningWithError:error];
            
        }];

        
        
        
//        if ([password isEqualToString:@"123456"]) {
//            block(YES);
//        }else{
//            block(NO);
//            [HUDManager showWarningWithText:@"支付密码错误"];
//            [weakself.coreview clearPassword];
//        }

        weakself.payPassWords = password;
    };
    [KeyWindow addSubview:self];
    self.frame = CGRectMake(0,-KScreenBoundHeight, KScreenBoundWidth, KScreenBoundHeight);
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight);
    } completion:^(BOOL finished){
        [weakself.coreview beginInput];
    }];
}
-(void)tapTheView
{
    
    //    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [self.coreview endInput];
    [IQKeyboardManager sharedManager].enable = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, KScreenBoundWidth,KScreenBoundHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (IBAction)cancelButtonclicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];

}

- (IBAction)forgotPassWordButtonClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];
    ForgetPayPassWordViewController * view = [[ForgetPayPassWordViewController alloc] init];
    [self.ViewController.navigationController pushViewController:view animated:YES];

}
- (IBAction)tapaction:(UITapGestureRecognizer *)sender {
    [self endEditing:YES];
}


@end
