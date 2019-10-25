//
//  PaySuccessViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "AllOrdersViewController.h"

@interface PaySuccessViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *lookTheOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *backToHomeButton;

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LaguageControl languageWithString:@"支付成功"];
    self.walletLabel.text = LaguageControl(@"钱包支付");
    self.walletLabel.textColor = kNavigationColor;
    self.moneyLabel.textColor = kNavigationColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(NoAction)];
    self.lookTheOrderButton.layer.cornerRadius = 10;
    self.lookTheOrderButton.layer.masksToBounds = YES;
    self.lookTheOrderButton.layer.borderWidth = 1;

    self.backToHomeButton.layer.masksToBounds = YES;
    self.backToHomeButton.layer.cornerRadius = 10;
    self.backToHomeButton.layer.borderWidth =1;
    self.backToHomeButton.layer.borderColor=self.lookTheOrderButton.layer.borderColor = kNavigationCGColor;
    [self.lookTheOrderButton setTitleColor:kNavigationColor forState:UIControlStateNormal];
    [self.backToHomeButton setBackgroundColor:kNavigationColor];
    if (KScreenBoundWidth>320)
    {
        self.walletLabel.font = KSystemFont(12);
        self.payTypeLabel.font = KSystemFont(12);
        self.orderMoneyLabel.font = KSystemFont(12);
        self.moneyLabel.font = KSystemFont(12);
    }
    else
    {

        self.payTypeLabel.font = KSystemFont(11);
        self.orderMoneyLabel.font = KSystemFont(11);
        self.moneyLabel.font = KSystemFont(11);

        self.walletLabel.font = KSystemFont(11);
    }
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        self.lookTheOrderButton.alpha = 1;
        [self.lookTheOrderButton setTitle:LaguageControl(@"查看订单") forState:UIControlStateNormal];
    }
    else
    {
        self.lookTheOrderButton.alpha = 0;
    }
    [self.backToHomeButton setTitle:LaguageControl(@"回首页") forState:UIControlStateNormal];
    switch ([self.payType integerValue])
    {
        case 1:
            self.walletLabel.text = LaguageControl(@"支付宝");

            break;
        case 2:
            self.walletLabel.text = LaguageControl(@"微信支付");
            break;
        case 3:
            self.walletLabel.text = LaguageControl(@"账户余额");
            break;
        case  4:
            self.walletLabel.text = LaguageControl(@"线下支付");
            break;
        case  5:
            self.walletLabel.text = LaguageControl(@"返利支付");
            break;
        case  7:
            self.walletLabel.text = LaguageControl(@"网银");
            break;
        case  6:
            self.walletLabel.text = LaguageControl(@"银行卡");
            break;
        case  8:
            self.walletLabel.text = LaguageControl(@"余额");
            break;
        case  9:
            self.walletLabel.text = LaguageControl(@"返利余额");
            break;
            
        default:
            self.walletLabel.text = LaguageControl(@"无运费订单");
            break;
    }
    self.payTypeLabel.text = LaguageControlAppend(@"支付方式");
    self.orderMoneyLabel.text = LaguageControlAppend(@"实付金额");
    self.moneyLabel.text  = [NSString stringWithFormat:@"￥ %@", [self.moneyStr caculateFloatValue]];
}
-(void)NoAction
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)looktheOrder:(UIButton *)sender
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kLookOtherOrderNoti" object:nil userInfo:@{@"isInterOrderNoti":@(self.ISIntegralConvert)}];
    [self.navigationController popToRootViewControllerAnimated:YES];

    
    
//    if ([UserAccountManager shareUserAccountManager].loginStatus)
//    {
//        CATransition *transition = [CATransition animation];
//        transition.duration = 1.0f;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = @"oglFlip";
//        transition.subtype = kCATransitionFromTop;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        if (self.FatherVC)
//        {
//            [self.navigationController popToViewController:self.FatherVC animated:YES];
//        }
//        else
//        {
//            if (self.ISIntegralConvert)
//            {
//            }
//            else{
//                AllOrdersViewController * view = [AllOrdersViewController new];
//                view.isBuyer = YES;
//                view.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:view animated:YES];
//            }
//
//        }
//    }
//    else
//    {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
    
}
- (IBAction)backToRootView:(UIButton *)sender
{
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
    [appdelegate ProjectSetRootViewController];

//    CATransition *transition = [CATransition animation];
//    transition.duration = 1.0f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = @"oglFlip";
//    transition.subtype = kCATransitionFromTop;
//    transition.delegate = self;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
////    self.navigationController.delegate = self;
//    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (kIsChiHuoApp) {
        return;
    }
    UITabBarController * tabController = (UITabBarController*)kRootViewController;
    if (navigationController!=[tabController.viewControllers firstObject])
    {
        [tabController setSelectedViewController:[tabController.viewControllers firstObject]];
    }
    
}




@end
