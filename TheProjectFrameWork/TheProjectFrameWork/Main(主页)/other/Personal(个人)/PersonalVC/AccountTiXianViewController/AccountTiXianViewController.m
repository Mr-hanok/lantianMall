//
//  AccountTiXianViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/3/21.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "AccountTiXianViewController.h"
#import <IQTextView.h>
#import "RechargeTypePopView.h"
#import "PayView.h"

@interface AccountTiXianViewController ()<RechargeTypePopViewDelegate>
{
   PayView *payview;
}
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet IQTextView *remarkTF;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
@property (nonatomic, copy) NSString *payType;

@end

@implementation AccountTiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.remarkTF.placeholder = @"选填";
//    self.payType = @"1";
    
    self.tixianBtn.layer.masksToBounds = YES;
    self.tixianBtn.layer.cornerRadius = 5.f;
    
}

- (IBAction)tapAction:(UIButton *)sender {
    [self.view endEditing:YES];
    RechargeTypePopView * popView = [[RechargeTypePopView alloc] init];
    popView.delegate = self;
    [popView displayToWindoWithConfigType];
}
-(void)RechargeTypePopViewWithType:(NSInteger)type{
    
    switch (type) {
        case 0:
            self.typeTF.text = @"支付宝";
            self.payType = @"1";
            break;
            
        case 1:
             self.typeTF.text = @"微信";
            self.payType = @"2";
            break;
        case 2:
            self.typeTF.text = @"线下打款";
            self.payType = @"3";
            break;
    }

}
- (IBAction)tixianAction:(UIButton *)sender {
    
    
    // 根据是否有支付密码 判断是否新建密码
    if(![UserAccountManager shareUserAccountManager].userModel.isPayPassWord)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:LaguageControl(@"提示") message:LaguageControl(@"请先设置支付密码") delegate:self cancelButtonTitle:LaguageControl(@"取消") otherButtonTitles:LaguageControl(@"设置"), nil];
        [alert show];
        
        return;
    }
    
    if (![self dataCheck]) {
        return;
    }
    if (!payview) {
        payview = [PayView loadView];
        payview.ViewController = self;
    }
    __weak AccountTiXianViewController * weakSelf = self;
    [payview showView:^(BOOL success,NSString *codestr) {
        if (success) {
            [payview viewDissMissFromWindow];
            [weakSelf getdata];
        }else{
            
        }
    }];
    
}
#pragma clang diagnostic pop
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.cancelButtonIndex == buttonIndex)
    {
        return;
    }
    [self pushWithVCClassName:@"FoundPayPwdViewController" properties:nil];
    
}

-(BOOL)dataCheck{
    
    NSString *yuer = [UserAccountManager shareUserAccountManager].userModel.accountBalance;
    
    if (!self.payType) {
        [HUDManager showWarningWithText:@"请选择提现方式"];
        return NO;
    }
    if (self.moneyTF.text.length == 0  || [self.moneyTF.text doubleValue] < 0.01) {
        [HUDManager showWarningWithText:@"请输入提现金额"];
        return NO;
    }
    if ([self.moneyTF.text floatValue] > [yuer floatValue]) {
        [HUDManager showWarningWithText:@"请输入小于余额的提现金额"];
        return NO;
    }
    if (self.accountTF.text.length == 0) {
        [HUDManager showWarningWithText:@"请输入提现账号"];
        return NO;
    }
    if (self.accountTF.text.length > 20) {
        [HUDManager showWarningWithText:@"请输入20位以内提现账号"];
        return NO;
    }
    if (![NSString textFieldNOChinese:self.accountTF.text]) {
        [HUDManager showWarningWithText:@"请输入正确提现账号"];
        return NO;
    }
    if (self.remarkTF.text.length >50 ) {
        [HUDManager showWarningWithText:@"请输入50个字符以内备注"];
        return NO;
    }
    return YES;
}

#pragma mark -NetWork
/**提现*/
-(void)getdata{
    NSDictionary * parms = @{@"appliyUserId":kUserId,
                              @"depositType":self.payType,
                           @"depositAccount":self.accountTF.text,
                         @"appliyDepositSum":self.moneyTF.text,
                             @"depositMark":self.remarkTF.text?:@"",
                             @"pay_pwd":[[NSUserDefaults standardUserDefaults]objectForKey:MD5Pay_pwd]
                            };
    
    [NetWork PostNetWorkWithUrl:@"/buyer/deposit_save" with:parms successBlock:^(NSDictionary *dic) {
        
        [HUDManager showWarningWithText:dic[@"message"]];
        [self.navigationController popViewControllerAnimated:YES];
        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}

@end
