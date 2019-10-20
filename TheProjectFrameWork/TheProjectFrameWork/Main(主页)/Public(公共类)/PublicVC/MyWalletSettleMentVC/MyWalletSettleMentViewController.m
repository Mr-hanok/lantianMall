//
//  MyWalletSettleMentViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MyWalletSettleMentViewController.h"
#import "MyWalletSettleMentButtonTableViewCell.h"
#import "SettleMentTableViewCell.h"
#import "PayView.h"
#import "PaySuccessViewController.h"
#import "FoundPayPwdViewController.h"
#import "OrderPayManager.h"
#import "FoundPayPwdViewController.h"
static NSString * ButtonIdentifier = @"MyWalletSettleMentButtonTableViewCell" ;
static NSString * settleMentIdentifier = @"SettleMentTableViewCell";
@interface MyWalletSettleMentViewController ()<UITableViewDelegate,UITableViewDataSource,MyWalletSettleMentButtonTableViewCellDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView * settlementTableView;

@end

@implementation MyWalletSettleMentViewController
{
    PayView * payview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收银台";
    // Do any additional setup after loading the view from its nib.
    self.settlementTableView.backgroundColor = kBGColor;
}

-(void)NetWork
{
    [payview viewDissMissFromWindow];
    [HUDManager showLoadingHUDView:self.view];
    if (self.isIntegralOrder) {
        /**积分订单支付*/
        [OrderPayManager IntegralOrderPayWithOrderID:self.orderNumber andPayType:self.orderPayTypes With:^(BOOL success, NSString *urls, NSString *payType, NSString *paymoney, NSString *orderPayID, NSString *error) {
            [HUDManager hideHUDView];
            if (success)
            {
                self.orderNumber = paymoney;
                
                [self PopToSuccessVC];
            }
            else
            {
                [HUDManager showWarningWithText:error];
            }
        }];

    }else{
        /**商品订单支付*/
        [OrderPayManager OrderPayWithOrderID:self.orderNumber andPayType:self.orderPayTypes With:^(BOOL success, NSString *urls, NSString *payType, NSString *paymoney, NSString *orderPayID, NSString *error) {
            [HUDManager hideHUDView];
            if (success)
            {
                self.orderNumber = paymoney;
                
                [self PopToSuccessVC];
            }
            else
            {
                [HUDManager showWarningWithText:error];
            }
        }];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        MyWalletSettleMentButtonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ButtonIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:ButtonIdentifier bundle:nil] forCellReuseIdentifier:ButtonIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:ButtonIdentifier];
        }
        cell.delegate = self;
        return cell;
    }
    else{
        SettleMentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:settleMentIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:settleMentIdentifier bundle:nil] forCellReuseIdentifier:settleMentIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:settleMentIdentifier];
        }
        if (indexPath.section==0) {
            cell.rightLabel.textColor = kNavigationColor;
            cell.leftLabel.text = LaguageControl(@"订单金额");
            cell.rightLabel.text =[NSString stringWithFormat:@"￥ %@", [self.orderMoney caculateFloatValue]];
        }
        else
        {
            cell.leftLabel.text = LaguageControl(@"支付方式");
            cell.rightLabel.text = LaguageControl(self.payType);
        }
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return 150;
    }
    return 49;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 0.1;
    }
    else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark --MyWalletSettleMentButtonTableViewCellDelegate
-(void)MyWalletSettleMentButtonTableViewCellButtonClicked:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;

    [HUDManager showLoadingHUDView:self.view];
    [OrderPayManager CHeckPayPassWord:^(BOOL success, NSString *payType, NSString *error) {
        [HUDManager hideHUDView];
        if (success)
        {
            [weakSelf ShowPayView];
        }
        else
        {
            if ([payType isEqualToString:@"0"])
            {
                UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:LaguageControlAppend(@"提示") message:LaguageControlAppend(@"没有设置支付密码,请设置") preferredStyle:UIAlertControllerStyleAlert];
                // 2.实例化按钮:actionWithTitle
                [alertControl addAction:[UIAlertAction actionWithTitle:LaguageControl(@"设置") style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
                                         {
             FoundPayPwdViewController * controller = [[FoundPayPwdViewController alloc] init];
                                             [self.navigationController pushViewController:controller animated:YES];
                                         }]];
                
                [alertControl addAction:[UIAlertAction actionWithTitle:LaguageControl(@"取消") style:UIAlertActionStyleCancel handler:nil]];
                [weakSelf presentViewController:alertControl animated:YES completion:nil];
            }
            else if (payType)
            {
                
                FoundPayPwdViewController * view = [FoundPayPwdViewController new];
                [weakSelf.navigationController pushViewController:view animated:YES];
                
            }
            else
            {
                
                [HUDManager showWarningWithText:error];
            }

        }
    }];


}

#pragma mark --/** 显示输入支付密码页面 */
-(void)ShowPayView
{
        if (!payview) {
            payview = [PayView loadView];
        }
        payview.ViewController = self;
        __weak MyWalletSettleMentViewController * weakSelf = self;
        [payview showView:^(BOOL success,NSString *codestr) {
            if (success)
            {
                [weakSelf NetWork];
            }
            else
            {
                
            }
        }];
}


-(void)PopToSuccessVC
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    PaySuccessViewController * view = [[PaySuccessViewController alloc] init];
    view.FatherVC = self.FatherVC;
    view.moneyStr = self.orderMoney;
    view.payType =self.orderPayTypes;
    view.ISIntegralConvert = self.isIntegralOrder;
    [self.navigationController pushViewController:view animated:YES];
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
