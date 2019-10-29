//
//  MywalletViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MywalletViewController.h"
#import "MyWalletPayTypeTableViewCell.h"
#import "PayMentmethodTableViewCell.h"
#import "MyWalletSettleMentViewController.h"
#import "MyWalletHeadView.h"
#import "MyWalletFootView.h"
#import "PayOnLineViewController.h"
#import "AllOrdersViewController.h"
#import "PaySuccessViewController.h"
#import "OrderPayManager.h"
#import "PayView.h"
#import "FoundPayPwdViewController.h"
#import "PublicPayWebViewController.h"
#import "PayHandle.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "OrderDetialModel.h"
#import "ToPaymentViewController.h"
#import "LookDetialViewController.h"
static NSString * MentcellIdentifier = @"PayMentmethodTableViewCell";
static NSString * PayTypecellIdentifier = @"MyWalletPayTypeTableViewCell";
@interface MywalletViewController ()<UITableViewDelegate,UITableViewDataSource,WXApiManagerDelegate>
@property(strong,nonatomic) NSIndexPath * selectIndex;
@property (weak, nonatomic) IBOutlet UITableView *mywalletTableView;
@property (weak, nonatomic) IBOutlet UILabel *tureMoneyLabel;

@property(strong,nonatomic) NSMutableArray * dataArray;
@property (strong, nonatomic) IBOutlet UIView *headview;

/** 查询支付状态的id  */
@property(strong,nonatomic) NSString * orderPayID;

@property (weak, nonatomic) IBOutlet UIButton *freshBtn;

@property(assign,nonatomic) BOOL ispay;
@end

@implementation MywalletViewController
{
    MyWalletFootView * myWalletfootview;
    BOOL isTourists;
    PayView * payview;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"支付方式";
    self.dataArray = [NSMutableArray array];
    [HUDManager showLoadingHUDView:self.view];
    [[UserAccountManager shareUserAccountManager] getUserInfoComplete:^(id error, BOOL successful)
     {
         [HUDManager hideHUDView];
         if (successful) [self.mywalletTableView reloadData];
     }];

    [NetWork PostNetWorkWithUrl:@"/getConfig" with:nil successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        NSArray *temparray = [PayTypeModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"payType"]];
        for (PayTypeModel *modle in temparray) {
            if (modle.open) {
                [self.dataArray addObject:modle];
            }
        }
        NSInteger row = [self.orderPayMoney floatValue] == 0 ? 2 :0;
        self.selectIndex = [NSIndexPath indexPathForRow:row inSection:0];

        [self.mywalletTableView reloadData];
        
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:@"获取支付方式失败,请重新进入页面"];
    }];
    self.determineButton.backgroundColor = KAppRootNaVigationColor;
    self.determineButton.layer.cornerRadius=24;
    self.determineButton.layer.masksToBounds = YES;
    isTourists = ![UserAccountManager shareUserAccountManager].loginStatus;
    
    self.tureMoneyLabel.textColor = [UIColor colorWithString:@"#222222"];
    self.tureMoneyLabel.font = [UIFont systemFontOfSize:32];
    [self.freshBtn setTitleColor:kNavigationColor forState:UIControlStateNormal];
    self.headview.backgroundColor = kBGColor;
    self.tureMoneyLabel.backgroundColor = [UIColor whiteColor];
    self.mywalletTableView.tableHeaderView = self.headview;
    
    NSString *finishMoney = [@"¥ " stringByAppendingString:self.orderPayMoney];
    self.tureMoneyLabel.text = finishMoney;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessBackAliWX) name:@"AliPaySucceed" object:nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)backToPresentViewController
{
    [self.navigationController popViewControllerAnimated:YES];

//    if (self.FatherVC&&[UserAccountManager shareUserAccountManager].loginStatus)
//    {
//        CATransition *transition = [CATransition animation];
//        transition.duration = 1.0f;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = @"cube";
//        transition.subtype = kCATransitionFromRight;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        if ([self.FatherVC isKindOfClass:[AllOrdersViewController class]]) {
//            [self.navigationController popToViewController:self.FatherVC animated:YES];
//        }
//        else
//        {
//            AllOrdersViewController * view = [AllOrdersViewController new];
//            view.isBuyer = YES;
//            view.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:view animated:YES];
//        }
//    }
//    else
//    {
//        if (kIsChiHuoApp) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            if (self.isGoods) {
//                LookDetialViewController *vc =[[LookDetialViewController alloc]init];
//                vc.isGoods = YES;
//                vc.ordertype = 10;
//                [self.navigationController pushViewController:vc animated:YES];
//            }else{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//        }
//    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.ispay = NO;

}
- (IBAction)determineButtonClicked:(UIButton *)sender
{
    
    if (myWalletfootview.selectedButton.selected)
    {
    }
    else
    {
        if (self.selectIndex)
        {
            PayTypeModel *model = self.dataArray[self.selectIndex.row];
            switch ([model.modeid integerValue]) {
                case 2:
                {
                    if ([self.orderPayMoney doubleValue]>=100000) {
                        [HUDManager showWarningWithText:@"超过微信支付最大限额，请更换支付方式"];
                        return;
                    }
                    if (![WXApi isWXAppInstalled]) {
                        [HUDManager showWarningWithText:@"尚未安装微信,请选择其他支付方式"];
                        return;
                    }
                    self.orderPaytype  = @"2";
                    [self NetWork:@"2"];
                    break;
                }
                case 1:
                    if ([self.orderPayMoney doubleValue]>=100000000) {
                        [HUDManager showWarningWithText:@"超过支付宝支付最大限额，请更换支付方式"];
                        return;
                    }
                    self.orderPaytype  = @"1";
                    [self NetWork:@"1"];
                    break;
                case 3:
                    if ([self.orderPayMoney floatValue]>[[UserAccountManager shareUserAccountManager].userModel.accountBalance floatValue]) {
                        [HUDManager showWarningWithText:@"余额不足,请选择其他支付方式"];
                        return;
                    }
                    self.orderPaytype  = @"3";
                    [self UseThebalancepayment];
                    break;
//                case 3:
//                    self.orderPaytype  = @"4";
//                    [self NetWork:@"4"];
//                    break;
                default:
                    break;
            }
        }
        else
        {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:LaguageControl(@"提示") message:LaguageControl(@"请选择一种支付方式") delegate:self cancelButtonTitle:LaguageControl(@"取消") otherButtonTitles:LaguageControl(@"确定"), nil];
            [alert show];
        }
    }
}


#pragma mark --* 使用余额支付
-(void)UseThebalancepayment
{
    MyWalletSettleMentViewController * view = [[MyWalletSettleMentViewController alloc] init];
    if (self.FatherVC)
    {
        view.FatherVC = self.FatherVC;
    }
    if (myWalletfootview.selectedButton.selected)
    {
        view.orderPayTypes = @"8";
        view.isUserebate = YES;
    }
    else
    {
        view.orderPayTypes = @"3";
    }
    view.orderNumber = self.orderNumber;
    view.orderMoney = self.orderPayMoney;
    view.isIntegralOrder = self.isIntegralOrder;
    PayTypeModel *model =self.dataArray[self.selectIndex.row];
    view.payType = model.name;
    [self.navigationController pushViewController:view animated:YES];
}

/**
 *  <#Description#>
 *
 *  @param type <#type description#>
 */
-(void)NetWork:(NSString*)type
{
    [HUDManager showLoadingHUDView:self.view];
    if (self.isIntegralOrder) {
        /**积分订单调用支付接口*/
        [OrderPayManager IntegralOrderPayWithOrderID:self.orderNumber andPayType:type With:^(BOOL success, NSString *urls, NSString *payType, NSString *paymoney, NSString *orderPayID, NSString *error) {
            [HUDManager hideHUDView];
            if (success)
            {
                self.orderPaytype = payType;

                if ([payType isEqualToString:@"1"]||[payType isEqualToString:@"2"]||[payType isEqualToString:@"6"]||[payType isEqualToString:@"7"]) {
                    self.orderPayID = orderPayID;
                    [self OpenUrl:urls];
                }
                else
                {
                    self.orderPayMoney = paymoney;
                    [self PopPaySuccessViewController];
                }
            }
            else
            {
                [HUDManager showWarningWithText:error];
            }
        }];

    }else{
        /**商品订单调用支付接口*/
        [OrderPayManager OrderPayWithOrderID:self.orderNumber andPayType:type With:^(BOOL success, NSString *urls, NSString *payType, NSString *paymoney, NSString *orderPayID, NSString *error) {
            [HUDManager hideHUDView];
            if (success)
            {
//                self.orderPayMoney = paymoney;
                self.orderPaytype = payType;
                if ([payType isEqualToString:@"1"]||[payType isEqualToString:@"2"]||[payType isEqualToString:@"6"]||[payType isEqualToString:@"7"]||[payType isEqualToString:@"10"]) {
                    self.orderPayID = orderPayID;
                    [self OpenUrl:urls];
                }
                else
                {
                    self.orderPayMoney = paymoney;
                    [self PopPaySuccessViewController];
                }
            }
            else
            {
                [HUDManager showWarningWithText:error];
            }
        }];
    }
    
}


-(void)OpenUrl:(NSString*)urls
{
    switch ([self.orderPaytype integerValue]) {
        case 1:
        {

            [[AlipaySDK defaultService] payOrder:urls fromScheme:@"comYunTaiAliPay" callback:^(NSDictionary *resultDic) {
                NSLog(@"支付结果 reslut = %@",resultDic);
                NSInteger orderState=[resultDic[@"resultStatus"] integerValue];
                if (orderState==9000)
                {
//                    NSString *allString=resultDic[@"result"];
//                    NSString * FirstSeparateString=@"\"&";
//                    NSString *  SecondSeparateString=@"=\"";
//                    NSMutableDictionary *dic=[self VEComponentsStringToDic:allString withSeparateString:FirstSeparateString AndSeparateString:SecondSeparateString];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPaySucceed" object:nil userInfo:dic];
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
    };
            break;
        case 2:
        {
            NSDictionary *tempDic = [urls mj_JSONObject];
            
            [WXApiManager sharedManager].delegate = self;
            PayReq * request = [[PayReq alloc] init];
            NSString *prepayid = tempDic[@"prepayid"] ?: @"";
            if ( [tempDic[@"prepayid"] isKindOfClass:[NSNull class]]||[tempDic[@"prepayid"] isEqualToString:@""] || tempDic[@"prepayid"] == nil ) {
                prepayid = @"";
            }
            request.partnerId = tempDic[@"partnerid"]?:@"";
            request.prepayId= prepayid ;
            request.package = tempDic[@"package"]?:@"";
            request.nonceStr= tempDic[@"noncestr"]?:@"";
            request.timeStamp = (UInt32)[tempDic[@"timestamp"]?:@"" intValue];
            request.sign= tempDic[@"paySign"]?:@"";
            [WXApi sendReq:request];
            break;
        }
    }
}
/*
 * 返回APP
 */
- (void)becomeActive
{
    
    if (self.ispay)
    {
        if (self.orderPayID)
        {
            NSDictionary * dic = @{@"orderPayId":self.orderPayID};
            
            [NetWork PostNetWorkWithUrl:@"/getPatStatus" with:dic successBlock:^(NSDictionary *dic)
             {
                 if ([dic[@"status"] boolValue])
                 {
                     self.orderPaytype = [NSString stringWithFormat:@"%@",dic[@"statusStr"]];
                     [self PopPaySuccessViewController];
                 }
                 else
                 {
                     [HUDManager showWarningWithText:@"支付失败"];
                 }
             } errorBlock:^(NSString *error)
             {
                 [HUDManager showWarningWithText:@"支付失败"];
                 
             }];
        }
        else
        {
            [HUDManager showWarningWithText:@"支付失败"];
        }
    }
    self.ispay = NO;
}
/**
 *  跳出APP 支付
 */
-(void)resignActive
{
    
}
/**
 *  跳转支付成功页面
 */
-(void)PopPaySuccessViewController
{
    self.ispay = NO ;
    PaySuccessViewController * view = [[PaySuccessViewController alloc] init];
    view.payType  = self.orderPaytype;
    view.moneyStr = self.orderPayMoney;
    view.FatherVC = self.FatherVC;
    view.ISIntegralConvert = self.isIntegralOrder;
    [self.navigationController pushViewController:view animated:YES];
}
-(void)paySuccessBackAliWX{
    [self PopPaySuccessViewController];
}

#pragma mark --UITableViewDelegate &&  UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        MyWalletPayTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PayTypecellIdentifier];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:PayTypecellIdentifier bundle:nil] forCellReuseIdentifier:PayTypecellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:PayTypecellIdentifier];
        }
    PayTypeModel *model = self.dataArray[indexPath.row];
        cell.payTypeNameLabel.text = model.name;
    if ([model.modeid integerValue] == 1) {
        cell.iconImageview.image = [UIImage imageNamed:@"qianbaozhifubao"];
    }else if ([model.modeid integerValue] == 2){
        cell.iconImageview.image = [UIImage imageNamed:@"qianbaoweixin"];

    }else if ([model.modeid integerValue] == 3){
        cell.iconImageview.image = [UIImage imageNamed:@"qianbaoyuer"];
    }
    
    if (self.selectIndex.row == indexPath.row ) {
        cell.selectedButton.selected = YES;
    }else {
        cell.selectedButton.selected = NO;
    }
    if (!isTourists)
    {
            if (indexPath.row==2)
            {
                NSString * attrStri = [NSString stringWithFormat:@"(￥ %.2f)",[[UserAccountManager shareUserAccountManager].userModel.accountBalance doubleValue]];
                PayTypeModel *model =self.dataArray[indexPath.row];
                NSString *strings  =[NSString stringWithFormat:@"%@ %@",model.name,attrStri];
                NSRange range = [strings rangeOfString:attrStri];
                
                NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:strings];
                [attr addAttribute:NSForegroundColorAttributeName
                                                value:kNavigationColor
                                                range:range];
                cell.payTypeNameLabel.attributedText =attr;
            }
    }
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.orderPayMoney floatValue] == 0.0 && (indexPath.row==0||indexPath.row == 1)) {
        [HUDManager showWarningWithText:@"支付金额为0,请用余额支付"];
        return;
    }
    if (self.selectIndex ==indexPath)
    {
        MyWalletPayTypeTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.selectedButton.selected) {
            cell.selectedButton.selected = NO;
            self.selectIndex = nil;
        }else{
            self.selectIndex = [indexPath copy];
            cell.selectedButton.selected = YES;

        }
    }
    else
    {
        MyWalletPayTypeTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

        MyWalletPayTypeTableViewCell *tempcell = [tableView cellForRowAtIndexPath:self.selectIndex];
        if (self.selectIndex) {
            tempcell.selectedButton.selected = NO;
        }
        self.selectIndex = [indexPath copy];
        cell.selectedButton.selected = YES;

       

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyWalletHeadView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyWalletHeadView"];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:@"MyWalletHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"MyWalletHeadView"];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyWalletHeadView"];
        }

    view.paytypeLabel.text = LaguageControl(@"选择支付方式");
        return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
/*
    if (isTourists||self.isIntegralOrder) {
        return [UIView new];
    }
    else
    {
    myWalletfootview  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyWalletFootView"];
    if (!myWalletfootview)
    {
        [tableView registerNib:[UINib nibWithNibName:@"MyWalletFootView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"MyWalletFootView"];
        myWalletfootview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyWalletFootView"];
    }
        [myWalletfootview.selectedButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        NSString * attrStri = [NSString stringWithFormat:@"(Bal: ￥ %.2f)",[UserAccountManager shareUserAccountManager].userModel.rebateTotal];
        NSString *strings  =[NSString stringWithFormat:@"Use My Rebates %@",attrStri];
        NSRange range = [strings rangeOfString:attrStri];
        
        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:strings];
        [attr addAttribute:NSForegroundColorAttributeName
                     value:kNavigationColor
                     range:range];

        myWalletfootview.rebatebalanceLabel.attributedText =attr;
        return myWalletfootview;
    }
 */
}

- (IBAction)buttonSelected:(UIButton *)sender
{
    if ([UserAccountManager shareUserAccountManager].userModel.rebateTotal>0)
    {

            sender.selected = !sender.selected;
    }
    else
    {
        [HUDManager showWarningWithText:@"您目前没有返利余额"];
    }
}

#pragma mark -- 支付宝返回结果处理
-(NSMutableDictionary *)VEComponentsStringToDic:(NSString*)AllString withSeparateString:(NSString *)FirstSeparateString AndSeparateString:(NSString *)SecondSeparateString{
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    NSArray *FirstArr=[AllString componentsSeparatedByString:FirstSeparateString];
    
    for (int i=0; i<FirstArr.count; i++) {
        NSString *Firststr=FirstArr[i];
        NSArray *SecondArr=[Firststr componentsSeparatedByString:SecondSeparateString];
        [dic setObject:SecondArr[1] forKey:SecondArr[0]];
        
    }
    
    return dic;
}

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //显示微信传过来的内容
    WXAppExtendObject *obj = msg.mediaObject;
    
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n附加消息:%@\n", req.openID, msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length, msg.messageExt];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)req {
    WXMediaMessage *msg = req.message;
    
    //从微信启动App
    NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", req.openID, msg.messageExt];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)req {
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
    NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
    NSString *strMsg = [NSString stringWithFormat:@"openID: %@", req.openID];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                    message:strMsg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)refshBtnAction:(UIButton *)sender {
    if (self.orderNumber) {
        /**刷新价格*/
        [self refshNetWork];
    }
}

-(void)refshNetWork
{
    [HUDManager showLoadingHUDView:self.view];
    NSDictionary * dic = @{@"orderIds":self.orderNumber,
                           };
    [NetWork PostNetWorkWithUrl:@"/orders_price" with:dic successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        if ([dic[@"status"] boolValue])
        {
            float temppric = [dic[@"data"]?:@"" floatValue];
            if (temppric==0) {
                return ;
            }
            self.orderPayMoney = [NSString stringWithFormat:@"%.2f",temppric];
            NSString *finishMoney = [@"¥ " stringByAppendingString:self.orderPayMoney];
            self.tureMoneyLabel.text = finishMoney;
            
        }
        else
        {
            [HUDManager showWarningWithText:dic[@"message"]];
        }
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];        
    }];
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

@implementation PayTypeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"modeid":@"id"};
}
@end
