//
//  AccountRechargeViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  账户充值

#import "AccountRechargeViewController.h"
#import "AccountRechargeView.h"
#import "LoginButton.h"
#import "RechargeTypePopView.h"
#import "RechargeFinishViewController.h"
#import "ShopModel.h"

@interface AccountRechargeViewController ()<AccountRechargeTypeViewDelegate,RechargeFinishViewControllerDelegate>
{
    AccountRechargeTypeView * _typeView;
    AccountRechargeMoneyView * _valueView;
    AccountRechargeRemarkView * _remarkView;

    LoginButton * _next;
    NSNumber * _orderPayId;
    BOOL _isPay;
}
@end
@implementation AccountRechargeViewController
#pragma mark - left cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)addRechargeBackCall
{
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:@"AliPaySucceed" object:nil];
}
- (void)loadSubViews
{
    _typeView = [[AccountRechargeTypeView alloc] init];
    _typeView.delegate = self;
    _typeView.titleLabel.text = nil;
    _valueView = [[AccountRechargeMoneyView alloc] init];
    _valueView.titleLabel.text = nil;
    _remarkView = [[AccountRechargeRemarkView alloc]init];
    _remarkView.titleLabel.text = nil;
    
    __weak typeof(self) weakSelf = self;
    _next = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf next];
    } title:@"下一步"];
    [_next settingButtonSelectWithSelected:YES];
    [self.view addSubview:_typeView];
    [self.view addSubview:_valueView];
    [self.view addSubview:_remarkView];
    
    [self.view addSubview:_next];
    [_typeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleHeight(44));
        make.top.equalTo(weakSelf.view.mas_top);
    }];
    [_valueView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleHeight(44));
        make.top.equalTo(_typeView.mas_bottom);
    }];
    [_remarkView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleWidth(44));
        make.top.equalTo(_valueView.mas_bottom);
    }];
    
    [_next mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_remarkView.mas_bottom).mas_offset(kScaleHeight(30));
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadSubViews];
    self.title = LaguageControl(@"账户充值");
}
- (void)next
{
    [self getDataBlance];
}

#pragma mark - otherDelegate
- (void)accountRechargeTypeSelectWithView:(AccountRechargeTypeView *)view
{
    RechargeTypePopView * popView = [[RechargeTypePopView alloc] init];
    popView.delegate = view;
    [popView displayToWindoWithAliWX:YES];
}

#pragma mark -NetWork
- (void)getDataBlance
{
    [self.view endEditing:YES];
    if(_typeView.content.length == 0)
    {
        [HUDManager showWarningWithText:@"请选择支付方式"];
        return;
    }
    if(_valueView.value <= 99999999.99 && _valueView.value >= 0.01)
    {
        
    }else{
        [HUDManager showWarningWithText:@"请输入正确的充值金额"];
        return;
    }

    //支付方式pd_payment:1:信用卡支付 2:网银支付 3:账户余额 4:线下付款  5:返利
    NSInteger pd_payment = 0;
    if([_typeView.content isEqualToString:LaguageControl(@"支付宝")])
    {
        pd_payment = 1;
    }if([_typeView.content isEqualToString:LaguageControl(@"微信")])
    {
        pd_payment = 2;
    }
    
    NSInteger shopId = [UserAccountManager shareUserAccountManager].shopModel.store_id;
    NSDictionary * parms = @{@"user_id":kUserId,@"store_id":_buyer?@"":@(shopId),@"amount":@(_valueView.value),@"comments":_remarkView.value?:@"",@"payType":@(pd_payment),@"type":@(_buyer?1:2),@"callBackUrl":@"recharge"};
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍候"];
    [NetWork PostNetWorkWithUrl:@"/rechargeFirst" with:parms successBlock:^(NSDictionary *dic)
    {
        [HUDManager hideHUDView];
        [self addRechargeBackCall];
        
       // [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[dic[@"data"][@"payUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        [[AlipaySDK defaultService] payOrder:dic[@"data"][@"payUrl"] fromScheme:@"comYunTaiAliPay" callback:^(NSDictionary *resultDic) {

            NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
            if (orderState==9000)
            {
                
                [self PopPaySuccessViewController];
            }
            else
            {
                NSString *returnStr;
                switch (orderState)
                {
                    case 8000:
                        returnStr=@"订单正在处理中";
                        break;
                    case 4000:
                        returnStr=@"订单支付失败";
                        break;
                    case 6001:
                        returnStr=@"订单取消";
                        break;
                    case 6002:
                        returnStr=@"网络连接出错";
                        break;
                    default:
                        break;
                }
                [HUDManager showWarningWithText:returnStr];
                
            }
            
        }];
        
        _isPay = YES;
        _orderPayId = dic[@"data"][@"orderFormPayId"];
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:error];
    }];
}
/*
 * 返回APP
 */
- (void)becomeActive
{
    if (_isPay)
    {
        
        
         [self PopPaySuccessViewController];
//        [NetWork PostNetWorkWithUrl:@"/getPatStatus" with:@{@"orderPayId":_orderPayId} successBlock:^(NSDictionary *dic) {
//            
//           
//            
//            
//        } FailureBlock:^(NSString *msg) {
//            [HUDManager showWarningWithError:msg];
//        } errorBlock:^(id error) {
//            [HUDManager showWarningWithError:error];
//        }];
    }
    _isPay = NO;
}
/**
 *  跳出APP 支付
 */
-(void)resignActive
{

}

-(void)PopPaySuccessViewController{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSInteger pd_payment = 0;
    if([_typeView.content isEqualToString:@"支付宝"])
    {
        pd_payment = 1;
    }else if([_typeView.content isEqualToString:@"微信"])
    {
        pd_payment = 2;
    }
    RechargeFinishViewController * view = [[RechargeFinishViewController alloc] init];
    view.FatherVC = self;
    view.money = _valueView.value;
    view.type = pd_payment;
    [self.navigationController pushViewController:view animated:YES];
}
@end
