//
//  OrderDetailViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyerOrderModel.h"

#import "OrderDetailViewController.h"

#import "OrderNumberHeadView.h"

#import "OrderlogisticsTableViewCell.h"

#import "AdressTableViewCell.h"
#import "OrderTableHeadView.h"
#import "OrderTableViewCell.h"
#import "OrderFootView.h"
#import "ConstTableViewCell.h"
#import "OrderTimeTableViewCell.h"
#import "AllOrderTimeTableViewCell.h"
#import "TableDefaultLogisticsTableViewCell.h"
#import "LogisticsDetailsViewController.h"
#import "DistributionTableViewCell.h"
#import "StationMessageChatViewController.h"
#import "RefundApplyView.h"
#import "OffPayPopView.h"
#import "MywalletViewController.h"
#import "NoSuccessConstTableViewCell.h"
#import "OrderDetialModel.h"
#import "ChooseComplaintGoodsViewController.h"

#import "EvalutionDetialViewController.h"
#import "OrderManagerNetWork.h"
#import "OrdereValuationDetailsViewController.h"
#import "GoodsDetialViewController.h"
#import "PayAttentionShopViewController.h"


static NSString * HeadIdentifier = @"OrderNumberHeadView";

static NSString * OrderHeadIdentifier = @"OrderTableHeadView";

static NSString * CellIdentifier = @"OrderTableViewCell";

static NSString * FootIdentifier = @"OrderFootView";

static NSString * ConstCellIdentifier =@"ConstTableViewCell";

static NSString * NoSuccessConstCellIdentifier = @"NoSuccessConstTableViewCell";

static NSString * DistributionCellIdentifier = @"DistributionTableViewCell";

static NSString * OrderCellIdentifier = @"OrderlogisticsTableViewCell";

static NSString * AddressCellIdentifier = @"AdressTableViewCell";

static NSString * TimeCellIdentifier =@"OrderTimeTableViewCell";

static NSString * AllCellIdentifier =@"AllOrderTimeTableViewCell";

static NSString * DefaultLogisticsCellIdentifier =@"TableDefaultLogisticsTableViewCell";



@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *orderDetialTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomviewheight;
/** 数据源 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2Leading;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLeading;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *middleButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property(strong,nonatomic) OrderDetialModel * model;
@property (weak, nonatomic) IBOutlet UIButton *letf2Button;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LaguageControl languageWithString: @"订单详情"];
    [self.rightButton setTitleColor:kNavigationColor forState:UIControlStateNormal];
    self.orderDetialTableView.backgroundColor = self.bottomView.backgroundColor = kBGColor;
    [self loadOrderDetial];
    if (KScreenBoundWidth>320)
    {
        self.leftButton.titleLabel.font = KSystemFont(12);
        self.middleButton.titleLabel.font = KSystemFont(12);
        self.rightButton.titleLabel.font = KSystemFont(12);
        self.letf2Button.titleLabel.font = KSystemFont(12);

    }
    else
    {
        self.leftButton.titleLabel.font = KSystemFont(11);
        self.middleButton.titleLabel.font = KSystemFont(11);
        self.rightButton.titleLabel.font = KSystemFont(11);
        self.letf2Button.titleLabel.font = KSystemFont(11);

    }
    [self NetWork];

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self NetWork];
}
-(void)loadOrderDetial
{
    if (self.orderType!=OrderTypesToEvaluation||self.orderType!=OrderTypesApplyRefunding||self.orderType!=OrderTypesRefundSuccess||self.orderType!=OrderTypesRefundFailure) {
        self.leftButton.alpha = 0;
        self.letf2Button.alpha = 0;

    }

    switch (self.orderType) {
        case OrderTypesToEvaluation:
            /**已收货*/
            if (self.model.evaluate)
            {
                self.leftButton.alpha = 1;
                self.letf2Button.alpha = 1;
                [self.rightButton setTitle:LaguageControl11(@"查看评价") forState:UIControlStateNormal];
                [self.middleButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
                [self setcomplainBtn:self.leftButton];
//                [self.leftButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
                [self.letf2Button setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            }
            else
            {
                self.leftButton.alpha = 1;
                self.letf2Button.alpha = 1;
                [self.rightButton setTitle:LaguageControl11(@"评价") forState:UIControlStateNormal];
                [self.middleButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
                [self setcomplainBtn:self.leftButton];
//                [self.leftButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
                [self.letf2Button setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            }
            
            break;
        case OrderTypesToAccePt:
            /**待收货*/
            self.leftButton.alpha = 1;
            self.letf2Button.alpha = 1;
            [self.rightButton setTitle:LaguageControl11(@"确认收货") forState:UIControlStateNormal];
            [self setcomplainBtn:self.middleButton];
//            [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            [self.leftButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            [self.letf2Button setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];

            
            break;
        case OrderTypesToPayment:
            [self.middleButton setTitle:LaguageControl11(@"取消订单") forState:UIControlStateNormal];
            [self.rightButton setTitle:LaguageControl11(@"付款") forState:UIControlStateNormal];
            break;
        case OrderTypesPingTuan:
        case OrderTypesToSend:
            /**代发货*/
            [self.rightButton setTitle:LaguageControl11(@"退款")forState:UIControlStateNormal];
            [self setcomplainBtn:self.middleButton];
//            [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];

            break;
        case OrderTypesToSendING:
            [self.rightButton setTitle:LaguageControl11(@"退款")forState:UIControlStateNormal];
            [self setcomplainBtn:self.middleButton];
//            [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];

            break;
        case OrderTypesScuccess:
            /**已完成*/
            [self.rightButton setTitle:LaguageControl11(@"查看评价") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            self.middleButton.alpha = 1;
            break;
        case OrderTypesCanCel:
            self.middleButton.alpha = 0;
            self.rightButton.alpha = 0;
            self.bottomView.hidden = YES;
            self.bottomviewheight.constant = 0;
//            [self.rightButton setTitle:@"删除订单" forState:UIControlStateNormal];
//            [self.rightButton setTitle:LaguageControl(@"查看订单")forState:UIControlStateNormal];

            
            break;
            //TODO:
        case OrderTypesRefundFailure:
            
            [self.rightButton setTitle:LaguageControl11(@"我要评价")forState:UIControlStateNormal];
            [self setcomplainBtn:self.middleButton];
//            [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
            break;
        case OrderTypesApplyRefunding:
            
            [self setcomplainBtn:self.rightButton];
//            [self.rightButton setTitle:LaguageControl11(@"投诉")forState:UIControlStateNormal];
            if ([self.buyOrderModel.before_refund_status integerValue]<30) {
                self.middleButton.alpha = 0;

            }else{
                self.middleButton.alpha = 1;
                [self.middleButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];

            }
            break;
        case OrderTypesRefundSuccess:
            [self setcomplainBtn:self.rightButton];
//            [self.rightButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            if ([self.buyOrderModel.before_refund_status integerValue]<30) {
                self.middleButton.alpha = 0;
                
            }else{
                self.middleButton.alpha = 1;
                [self.middleButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
                
            }
            break;
        case OrderTypesToPayUnderLine:
            [self.middleButton setTitle:LaguageControl11(@"取消订单") forState:UIControlStateNormal];
            [self.rightButton setTitle:LaguageControl11(@"付款") forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    self.leftButton.layer.masksToBounds = YES;
    self.leftButton.layer.cornerRadius = 5;
    self.leftButton.layer.borderWidth = 0.5;
    self.leftButton.layer.borderColor = kTextDeepDarkColor.CGColor;
    [self.leftButton setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
    self.middleButton.layer.masksToBounds = YES;
    self.middleButton.layer.cornerRadius = 5;
    self.middleButton.layer.borderWidth = 0.5;
    self.middleButton.layer.borderColor = kTextDeepDarkColor.CGColor;
    [self.middleButton setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
    self.rightButton.layer.masksToBounds = YES;
    self.rightButton.layer.cornerRadius = 5;
    self.rightButton.layer.borderWidth = 0.5;
    self.rightButton.layer.borderColor = kNavigationCGColor;
    
    self.letf2Button.layer.masksToBounds = YES;
    self.letf2Button.layer.cornerRadius = 5;
    self.letf2Button.layer.borderWidth = 0.5;
    self.letf2Button.layer.borderColor = kTextDeepDarkColor.CGColor;
    [self.letf2Button setTitleColor:kTextDeepDarkColor forState:UIControlStateNormal];
}
-(void)NetWork
{
    [HUDManager showLoadingHUDView:self.view];
    NSDictionary * dic = @{@"id":self.orderId,
                           @"user_id":kUserId,
                        @"storeId":self.buyOrderModel.store_id};
    [NetWork PostNetWorkWithUrl:@"/order_view" with:dic successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        if ([dic[@"status"] boolValue])
        {
            self.model = [OrderDetialModel mj_objectWithKeyValues:dic[@"data"]];
            self.orderType = [self.model.order_status integerValue];
            [self loadOrderDetial];
            [self.orderDetialTableView reloadData];
        }
        else
        {
            [HUDManager showWarningWithText:dic[@"message"]];
            [self backToPresentViewController];
        }
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
        [self backToPresentViewController];

    }];
}

- (IBAction)buttonClicked:(UIButton *)sender
{
    switch (self.orderType) {
        case OrderTypesToEvaluation:
            /**已收货*/
            if (self.model.evaluate) {
                if(sender.tag==100)
                {
                    [self PushToChooseComplaintGoodsViewController];
                }
                else if(sender.tag==101)
                {
                    [self refundButtonClicked];
                }
                else if(sender.tag==102)
                {
                    [self LookEvaluationButtonClickedWithSection];
                }else if(sender.tag==99){
                    /**查看物流*/
                    [self checkTheLogistics];
                }
            }
            else{
                if(sender.tag==100)
                {
                    [self PushToChooseComplaintGoodsViewController];
                }
                else if(sender.tag==101)
                {
                    [self refundButtonClicked];
                }
                else if(sender.tag==102)
                {
                    [self PushEvalutionDetialViewController];
                }else if(sender.tag==99){
                    /**查看物流*/
                    [self checkTheLogistics];

                }
            }
                        break;
        case OrderTypesToAccePt:
            /**待收货*/
            if(sender.tag==101)
            {
                [self PushToChooseComplaintGoodsViewController];
            }
            else if(sender.tag==102)
            {
                [self ConfimAceptButtonClicked];
            }else if(sender.tag==100){
                /**查看物流*/
                [self checkTheLogistics];

            }else{
                /**退款*/
                [self refundButtonClicked];

            }
            break;
        case OrderTypesToPayment:
            if(sender.tag==101)
            {
                __weak OrderDetailViewController * weakself = self;
                OffPayPopView * view = [[OffPayPopView alloc] init];
                
                [view getsureEventBlock:^(NSString *content) {
                    [weakself CancelOrderNet:self.model.orderId andstate:content];
                }];
                view.title = LaguageControl(@"您确认取消此订单吗");
                view.issues = @[@"其他原因",@"不想要了",@"地址填写错误"];
                view.orderID =self.model.order_id;
                [view displayFromWindow];
            }
            else
            {
                [self PayMoneyButtonClicked];
            }
            break;
            
        case OrderTypesToPayUnderLine:
            if(sender.tag==101)
            {
                __weak OrderDetailViewController * weakself = self;
                OffPayPopView * view = [[OffPayPopView alloc] init];
                
                [view getsureEventBlock:^(NSString *content) {
                    [weakself CancelOrderNet:self.model.orderId andstate:content];
                }];
                view.title = LaguageControl(@"您确认取消此订单吗");
                view.issues = @[@"其他原因",@"不想要了",@"地址填写错误"];
                view.orderID =self.model.order_id;
                [view displayFromWindow];
            }
            else
            {
                [self PayMoneyButtonClicked];
            }
            break;
            
        case OrderTypesToSend:
            if(sender.tag==101) {
                [self PushToChooseComplaintGoodsViewController];

            }
            else
            {
                [self refundButtonClicked];
            }
            break;
        case OrderTypesToSendING:
            if(sender.tag==101) {
                [self PushToChooseComplaintGoodsViewController];
            }
            else
            {
                [self refundButtonClicked];
            }
            break;
        case OrderTypesScuccess:
            if (sender.tag == 102) {
                [self LookEvaluationButtonClickedWithSection];

            }else if (sender.tag == 101){
                /**查看物流*/
                [self checkTheLogistics];
            }
            break;
        case OrderTypesApplyRefunding:
            if(sender.tag==102)
            {
                [self PushToChooseComplaintGoodsViewController];
            }else if (sender.tag == 101){
                [self checkTheLogistics];
            }
            break;

            
        case OrderTypesCanCel:
        {
            [self delegateOrders];
        }
            break;
        case OrderTypesRefundSuccess:
            if(sender.tag==102)
            {
                [self PushToChooseComplaintGoodsViewController];
            }else if (sender.tag == 101){
                [self checkTheLogistics];
            }
        default:
            break;
    }
}

/** 取消退款 */
-(void)CanCelrefundButtonClickedWithSection
{
    
}

-(void)delegateOrders
{
    [OrderManagerNetWork DelegateOrder:self.model.orderId ResultBlock:^(BOOL success)
    {
        if (success) {
            [self backToPresentViewController];
        }
        
    }];
    
}

/** 查看评价详情 */
-(void)LookEvaluationButtonClickedWithSection;
{
    OrdereValuationDetailsViewController * controller = [[OrdereValuationDetailsViewController alloc] init];
    controller.orderId = self.model.orderId;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}
/** 退款 */
-(void)refundButtonClicked
{
    __weak OrderDetailViewController  * weakself = self;
    RefundApplyView * view = [[RefundApplyView alloc] init];
    [view GetResultBlock:^(NSString *string) {
        [weakself refundApplyView:self.model.orderId andContent:string];
    }];
    [view displayFromWindow];
}

/** 卖家退款 */
-(void)refundApplyView:(NSString*)ordeID andContent:(NSString*)content
{
    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork ArefundOrder:ordeID Content:content ResultBlock:^(BOOL success)
     {
         [HUDManager hideHUDView];
         if (success)
         {
             [self backToPresentViewController];
         }
     }];
}

- (void)baseOrderPop:(BaseOrderPopView *)view content:(id)content
{
    [view removeFromWindow];
}
/** 查看物流 */
-(void)checkTheLogistics{
    if (self.buyOrderModel.goods_type) {
        [HUDManager showWarningWithText:@"虚拟商品,无物流信息!"];
        return;
    }
    [self pushWithVCClassName:@"LogisticsDetailsViewController" properties:@{@"orderid":self.buyOrderModel.buyoderid,@"ordermodel":self.buyOrderModel}];
}

/** 确认收货 */
-(void)ConfimAceptButtonClicked
{
    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork ConfirmAcceptOrder:self.model.orderId ResultBlock:^(BOOL success) {
        [HUDManager hideHUDView];
        if (success)
        {
            [self backToPresentViewController];
        }
    }];
}

/** 付款 */
-(void)PayMoneyButtonClicked
{
    MywalletViewController * view = [MywalletViewController new];
    view.isOffline = self.model.lineType;
    view.FatherVC = self;
    view.orderPayMoney = self.model.disbursements;
    view.orderNumber = self.model.orderId;
    [self.navigationController pushViewController:view animated:YES];
}

/** 取消订单 */
-(void)CanCelOrderButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    __weak OrderDetailViewController * weakself = self;
    OffPayPopView * view = [[OffPayPopView alloc] init];
    [view getsureEventBlock:^(NSString *content) {
        [weakself CancelOrderNet:model.buyoderid andstate:content];
    }];
    view.title = LaguageControl(@"退款");
    view.issues = @[@"不想要了",@"我真的不想要了",@"不要了呀"];
    view.orderID =model.buyoderid;
    //    view.delegate = self;
    [view displayFromWindow];
    
}

/** 取消订单网络请求 */
-(void)CancelOrderNet:(NSString*)modeid andstate:(NSString*)state
{
    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork CancelOrder:modeid Content:state ResultBlock:^(BOOL success)
     {
         [HUDManager hideHUDView];
         if (success) {
             [self backToPresentViewController];
         }
     }];
}

/** 投诉 */
-(void)PushToChooseComplaintGoodsViewController
{
    ChooseComplaintGoodsViewController * view = [ChooseComplaintGoodsViewController new];
    view.orderModel = self.buyOrderModel;
    view.buyer = YES;
    [self.navigationController pushViewController:view animated:YES];
}
/** 评价 */
-(void)PushEvalutionDetialViewController
{
    EvalutionDetialViewController * view = [EvalutionDetialViewController new];
    view.model = self.buyOrderModel;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)ConfirmOrder
{
    
    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork ConfirmAcceptOrder:self.model.orderId ResultBlock:^(BOOL success) {
        [HUDManager hideHUDView];
        if (success)
        {
            [self NetWork];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model?8:0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3)
    {
    return self.model.gcs.count;
    }
    if (section==0 ||section==2) {
        return 0;
    }else if (section == 4){
        if (self.orderType <30) {
            return 0;
        }else if (self.orderType ==45 ||self.orderType ==47 ||self.orderType ==48 || self.orderType ==49){
            return [self.model.before_refund_status integerValue] < 30 ? 0 :1;
        }
        else {
            return 1;
        }
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (self.orderType==OrderTypesToSend||self.orderType ==OrderTypesToPayment) {
            return [UITableViewCell new];
        }
        else if (self.orderType==OrderTypesToAccePt)
        {
            TableDefaultLogisticsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DefaultLogisticsCellIdentifier];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:DefaultLogisticsCellIdentifier bundle:nil] forCellReuseIdentifier:DefaultLogisticsCellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:DefaultLogisticsCellIdentifier];
            }
            
            cell.logisticNameLabel.text =self.model.orderStatus;
            cell.logisetiTimeLabel.text = self.model.shipTime;
                     return cell;
        }
        else{
            OrderlogisticsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderCellIdentifier];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:OrderCellIdentifier bundle:nil] forCellReuseIdentifier:OrderCellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:OrderCellIdentifier];
            }
            
            cell.logisticsTypeLabel.text = self.model.orderStatus;
            return cell;
        }

    }
    else if(indexPath.section==1)
    {
        AdressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
        if (!cell) {
          [tableView registerNib:[UINib nibWithNibName:AddressCellIdentifier bundle:nil] forCellReuseIdentifier:AddressCellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
        }
        
        cell.AddressNameLabel.text =LaguageControl(@"收货地址");
        cell.nameLabel.text =self.model.consignee;
        cell.phoneLabel.text = self.model.phone;
        cell.adressLabel.text = self.model.sendAddress;
        return cell;
    }
    else if(indexPath.section==2)
    {
        AdressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:AddressCellIdentifier bundle:nil] forCellReuseIdentifier:AddressCellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
        }
       
        cell.AddressNameLabel.text = LaguageControl(@"发票地址");
        cell.nameLabel.text =self.model.invoName;
        cell.phoneLabel.text = self.model.invoMobile;
        cell.adressLabel.text = self.model.invoAddress;
        return cell;
    }
    else if(indexPath.section==3)
    {
        DetialOrderGoodsModel * model = self.model.gcs[indexPath.row];
        OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
            cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        if (model) {
            [cell loadOrderData:model andindex:indexPath];
         }
        return cell;
        
    }
    else if (indexPath.section==4)
    {
        DistributionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DistributionCellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:DistributionCellIdentifier bundle:nil] forCellReuseIdentifier:DistributionCellIdentifier];
            cell  = [tableView dequeueReusableCellWithIdentifier:DistributionCellIdentifier];
        }
        
//        cell.timelabel.text = self.model.shipTime;
//        cell.normaldeliveryLabel.text = self.model.transport;
//        cell.ShippinginformationLabel.text = LaguageControlAppendStrings(@"配送信息", self.model.transInfo);
        if ([self.model.company length])
        {
            cell.companyNameLabel.text = [LaguageControl languageWithString:@"物流公司"];
            cell.companyLabel.text =self.model.company;
        }
        if ([self.model.num length]) {
            cell.numLabel.text =self.model.num;
            cell.TheNumberLabel.text = [LaguageControl languageWithString:@"物流单号"];
        }
        return cell;
    }
    else if (indexPath.section==5)
    {
        ConstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ConstCellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:ConstCellIdentifier bundle:nil] forCellReuseIdentifier:ConstCellIdentifier];
            cell  = [tableView dequeueReusableCellWithIdentifier:ConstCellIdentifier];
        }
        [cell LoadDataWith:self.model andisSeller:NO];
        return cell;
    }else if (indexPath.section == 6){
        AllOrderTimeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AllCellIdentifier];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:AllCellIdentifier bundle:nil] forCellReuseIdentifier:AllCellIdentifier];
            cell  = [tableView dequeueReusableCellWithIdentifier:AllCellIdentifier];
        }
        cell.PlacetheOrderLabel.text = @"发  票  类  型 :";
        cell.payTimeLabel.text = @"发  票  抬  头 :";
        cell.ClinchadealthetimeLabel.text = @"纳税人识别号:";
        if ([self.model.invoiceType isEqualToString:@"0"]) {
            cell.placeordertimeLabel.text = @"个人发票";
            cell.payTimeLabel.hidden = cell.ClinchadealthetimeLabel.hidden = cell.buyerpaytimelabel.hidden = cell.buyclinchadealtimeLabel.hidden = YES;
        }else if ([self.model.invoiceType isEqualToString:@"1"]){
            cell.placeordertimeLabel.text = @"企业发票";
            cell.payTimeLabel.hidden = cell.ClinchadealthetimeLabel.hidden = cell.buyerpaytimelabel.hidden = cell.buyclinchadealtimeLabel.hidden = NO;

        }else{
            cell.placeordertimeLabel.text = @"未开发票";
            cell.payTimeLabel.hidden = cell.ClinchadealthetimeLabel.hidden = cell.buyerpaytimelabel.hidden = cell.buyclinchadealtimeLabel.hidden = YES;

        }
        cell.buyerpaytimelabel.text = self.model.invoice;
        cell.buyclinchadealtimeLabel.text = self.model.taxPayerNum;;
        return cell;
    }
    else
    {
        if (self.orderType==OrderTypesToPayment)
        {
            OrderTimeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TimeCellIdentifier];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:TimeCellIdentifier bundle:nil] forCellReuseIdentifier:TimeCellIdentifier];
                cell  = [tableView dequeueReusableCellWithIdentifier:TimeCellIdentifier];
            }
            
            cell.timeDetialLabel.text = self.model.addTime;
            return cell;
        }
        else if (self.orderType==OrderTypesToEvaluation||self.orderType==OrderTypesScuccess )
        {
            AllOrderTimeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AllCellIdentifier];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:AllCellIdentifier bundle:nil] forCellReuseIdentifier:AllCellIdentifier];
                cell  = [tableView dequeueReusableCellWithIdentifier:AllCellIdentifier];
            }
            
            cell.placeordertimeLabel.text = self.model.addTime;
            cell.buyerpaytimelabel.text = self.model.payTime;
            cell.buyclinchadealtimeLabel.text = self.model.payTime;
            cell.invoicenomberLabel.text = self.model.invoice;
            return cell;
           
        }

        else
        {
            NoSuccessConstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NoSuccessConstCellIdentifier];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:NoSuccessConstCellIdentifier bundle:nil] forCellReuseIdentifier:NoSuccessConstCellIdentifier];
                cell  = [tableView dequeueReusableCellWithIdentifier:NoSuccessConstCellIdentifier];
            }
            
            cell.placeorderTimeLabel.text = self.model.addTime;
            cell.paytimeLabel.text = self.model.payTime;
            cell.invoicenoumberLabel.text = self.model.invoice;
            return cell;
        }
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        OrderNumberHeadView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        }
        switch (self.orderType)
        {
            case OrderTypesToEvaluation:
                view.typeNameLabel.text = LaguageControl(@"已收货");
                break;
            case OrderTypesToAccePt:
                view.typeNameLabel.text = LaguageControl(@"待收货") ;
                break;
            case OrderTypesToPayment:
                view.typeNameLabel.text = LaguageControl(@"待付款");
                break;
            case OrderTypesToSend:
                view.typeNameLabel.text = LaguageControl(@"待发货");
                break;
            case OrderTypesToSendING:
                view.typeNameLabel.text = LaguageControl(@"待发货");
                break;
            case OrderTypesCanCel:
                view.typeNameLabel.text = LaguageControl(@"已取消");
                break;
            case OrderTypesScuccess:
                view.typeNameLabel.text = LaguageControl(@"已完成");
                break;
            case OrderTypesRefundCanCel:
                view.typeNameLabel.text = LaguageControl(@"已取消");
                break;
            case OrderTypesToPayUnderLine:
                view.typeNameLabel.text = LaguageControl(@"线下支付待审核");
                break;
            case OrderTypesRefundFailure:
                view.typeNameLabel.text = LaguageControl(@"退款失败");

            case OrderTypesRefundSuccess:
                view.typeNameLabel.text = LaguageControl(@"退款成功");
                break;
            case OrderTypesApplyRefunding:
                view.typeNameLabel.text = LaguageControl(@"申请退款中");
                break;
            default:
                view.typeNameLabel.text = @"";
                break;
        }
        
        view.typeNameLabel.textColor = kNavigationColor;
        view.orderNumLabel.text = [NSString stringWithFormat:@"%@%@",LaguageControlAppend(@"订单号"),self.model.order_id];
        
        return view ;
    }
    else if (section==3)
    {
        OrderTableHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:OrderHeadIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:OrderHeadIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:OrderHeadIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OrderHeadIdentifier];
        }
        [view LoadData:nil with:section];
        view.typeLabel.alpha =0;
        CGSize size = [NSString sizeWithString:self.model.store_name font:KSystemFont(15) maxHeight:60 maxWeight:KScreenBoundWidth];
        view.shopNameWidth.constant =  MIN(MAX(size.width+20, 60), KScreenBoundWidth-200);
        view.shopNameLabel.text = self.model.store_name;
        WeakSelf(self)
        view.shopbtnClickBlock = ^(NSInteger section) {
            PayAttentionShopViewController *vc = [[PayAttentionShopViewController alloc]init];
            vc.storeID = self.model.store_id;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return view;
    }
    else{
        return nil;
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
if (section==3)
    {
        OrderFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:FootIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FootIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
        }
        view.contactButton.layer.masksToBounds = YES;
        view.contactButton.layer.cornerRadius = 5;
        view.contactButton.layer.borderWidth = 1;
        [view.contactButton setTitle:LaguageControl(@"联系卖家") forState:UIControlStateNormal];
        
        view.contactButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [view.contactButton addTarget:nil action:@selector(conectToSeller) forControlEvents:UIControlEventTouchUpInside];
        if (self.model.msg == nil || [self.model.msg isEqualToString:@""]) {
            view.remarkLabel.hidden = YES;
            view.remarkview.hidden = YES;
        }else{
            view.remarkLabel.hidden = NO;
            view.remarkview.hidden = NO;
            view.remarkLabel.text = [@"买家留言: "   stringByAppendingString: self.model.msg];
        }
        return view;
    }
    else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==3) {
        if (self.model.msg == nil || [self.model.msg isEqualToString:@""]) {
            return 60;

        }else{
            return 60+60;

        }
    }else if (section == 2){
        return 0;
    }else{
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 50;
    }
    else if (section==3){
        return 40;
    }
    else
    {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (self.orderType==OrderTypesToSend||self.orderType ==OrderTypesToPayment)
        {
            return 0;
        }
        else{
            return 50;
          }
    }
    else if (indexPath.section==1 )
    {//收货地址
        return 130;
    }else if ( indexPath.section==2){
        //发票地址
        return 0;
    }else if (indexPath.section==3)
    {
        return 120;
    }
    else if (indexPath.section==4)
    {
        if (self.orderType==OrderTypesToPayment||self.orderType==OrderTypesToSend)
        {
            return 90;
        }
        else
        {
            return 60;
        }
        
    }
    else if (indexPath.section==5)
    {
        
        return !kIsHaveCoupon ? 44*3: 44*6;
    }else if(indexPath.section == 6){
        
        if ([self.model.invoiceType isEqualToString:@"0"]) {
           // cell.placeordertimeLabel.text = @"个人发票";
            return 44;
        }else if ([self.model.invoiceType isEqualToString:@"1"]){
           // cell.placeordertimeLabel.text = @"企业发票";
            return 44*3;

        }else{
           // cell.placeordertimeLabel.text = @"未开发票";
            return 44;
        }
    }
    else if (indexPath.section==7)
    {
        if (self.orderType==OrderTypesToPayment)
        {
            return 40;
        }
        else if (self.orderType==SellerOrderTypesToEvaluation||self.orderType==OrderTypesScuccess ){
            return 44*3;
        }
        else{
            return 70;
        }
  
    }
    else
    {
       
        if ([self.model.company length])
        {
            return 190;
        }
        else{
            return 120;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==3)
    {
        DetialOrderGoodsModel * model = self.model.gcs[indexPath.row];
        GoodsDetialViewController * view = [GoodsDetialViewController new];
        view.goodsModelID = model.goodsID;
        [self.navigationController pushViewController:view animated:YES];
    }
    
}

#pragma mark ---
-(void)conectToSeller
{
    StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
    view.type = @"0";
    NSLog(@"%@",kUserId);
    view.toUserID = self.model.store_userId;
    view.title = self.model.store_userName;
    [self.navigationController pushViewController:view animated:YES];
}


- (void)setcomplainBtn:(UIButton *)btn{
    if (!btn) {
        self.rightLeading.constant = 10;
        self.middleLeading.constant = 10;
        self.leftLeading.constant = 10;
        self.left2Leading.constant = 10;
        return;
    }
    if (kIsHaveComplaint) {
        [btn setTitle:LaguageControl11(@"投诉" )forState:UIControlStateNormal];
        btn.alpha = 1;
        self.rightLeading.constant = 10;
        self.middleLeading.constant = 10;
        self.leftLeading.constant = 10;
        self.left2Leading.constant = 10;
        
    }else{
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.alpha = 0;
        if (btn == self.rightButton) {
            self.rightLeading.constant = -30;
            self.middleLeading.constant = 10;
            self.leftLeading.constant = 10;
            self.left2Leading.constant = 10;
        }else if (btn == self.middleButton){
            self.rightLeading.constant = 10;
            self.middleLeading.constant = -30;
            self.leftLeading.constant = 10;
            self.left2Leading.constant = 10;
        }else if (btn == self.leftButton){
            self.rightLeading.constant = 10;
            self.middleLeading.constant = 10;
            self.leftLeading.constant = -30;
            self.left2Leading.constant = 10;
            
        }else if(btn == self.letf2Button){
            self.rightLeading.constant = 10;
            self.middleLeading.constant = 10;
            self.leftLeading.constant = 10;
            self.left2Leading.constant = -30;
        }
    }
}


@end
