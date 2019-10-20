//
//  LookDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LookDetialViewController.h"

#import "OrderTableViewCell.h"
#import "OrderTableHeadView.h"
#import "OrderTableFootView.h"
#import "LogisticsDetailsViewController.h"
#import "PopMoreView.h"
#import "StationMessageChatViewController.h"
#import "WalletDetailsTitleView.h"
#import "ChooseComplaintGoodsViewController.h"
#import "RefundApplyView.h"
#import "MywalletViewController.h"
#import "OffPayPopView.h"
#import "OrderDetailViewController.h"
#import "BuyerOrderModel.h"
#import "OrderGoodsModel.h"
#import "EvalutionDetialViewController.h"
#import "OrderManagerNetWork.h"
#import "PopChangView.h"
#import "OrdereValuationDetailsViewController.h"
#import "PayAttentionShopViewController.h"
static NSString * cellIdentifier = @"OrderTableViewCell";
static NSString * HeadIdentifier = @"OrderTableHeadView";
static NSString * FootIdentifier = @"OrderTableFootView";

@interface LookDetialViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableFootViewDelegate,WalletDetailsUnfoldViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *lookDetialTableView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property (nonatomic , weak) WalletDetailsTitleView * titleView;
@property(assign,nonatomic) NSInteger begin;
@property (nonatomic , weak) WalletDetailsUnfoldView * unfoldView;

@end

@implementation LookDetialViewController
{
    PopMoreView * popview;
    PopChangView *popChangView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.begin =1;
    self.dataArray = [NSMutableArray array];
        switch (self.ordertype)
    {
        case OrderTypesScuccess:
            self.title =[LaguageControl languageWithString:@"已完成"];
            break;
        case OrderTypesCanCel:
            self.title =[LaguageControl languageWithString:@"已取消"];
            break;
        case OrderTypesToAccePt:
                self.title = [LaguageControl languageWithString:@"待收货"];
            break;
        case OrderTypesToPayment:
            self.title =[LaguageControl languageWithString: @"待付款"];
            break;
        case OrderTypesToEvaluation:
            self.title = [LaguageControl languageWithString: @"已收货"];
            break;
        case OrderTypesAllTypes:
            self.title = [LaguageControl languageWithString: @"全部订单"];
            break;
        case OrderTypesApplyRefunding:
            self.title = [LaguageControl languageWithString: @"退款"];
            break;
        case OrderTypesRefundFailure:
            self.title = [LaguageControl languageWithString: @"退款失败"];
            break;
        case OrderTypesRefundSuccess:
            self.title = [LaguageControl languageWithString: @"退款成功"];
            break;
        default:
            break;
    }
    [self updataNewData:self.lookDetialTableView];
    [self NetWork];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)backToPresentViewController{
    if (self.isGoods) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/**
 *  点击titleview
 *
 *  @param titleview <#titleview description#>
 */
- (void)clickTitleWithButton:(WalletDetailsTitleView *)titleview
{
    titleview.selected = !titleview.selected;
    if(_unfoldView)
    {
        [self.unfoldView fold];
        return;
    }
    [self.unfoldView unfold];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateHeadView
{
    self.begin =1;
    [self.dataArray removeAllObjects];
    [self NetWork];
    
}
-(void)updateFootView
{
    self.begin++;
    [self NetWork];
    
}
-(void)NetWork
{
    NSString * begin = @"1";

    begin = [NSString stringWithFormat:@"%ld",(long)self.begin];

    NSString  * type = @"";
    if (self.ordertype!=OrderTypesAllTypes)
    {
        type =[NSString stringWithFormat:@"%ld",(unsigned long)self.ordertype];
    }
    NSDictionary * dic = @{@"currentPage":begin,
                           @"order_status":type,
                           @"user_id":kUserId,
                           };
    
    [NetWork PostNetWorkWithUrl:@"/buyer/order" with:dic successBlock:^(NSDictionary *dic)
     {
         [self endRefresh];
         if ([dic[@"status"] boolValue])
         {
             if (self.begin==1)
             {
                 [self.dataArray removeAllObjects];
             }
                NSArray * array  =  [BuyerOrderModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                [self.dataArray addObjectsFromArray:array];
         }
         [self.lookDetialTableView reloadData];
     } errorBlock:^(NSString *error)
    {
        [self endRefresh];
     }];
    
}
#pragma mark --UITableViewDelegate &&UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray.count==0)
    {
        self.backview = [ShoppingNotView loadView];
        self.backview.placeImageView.image = [UIImage imageNamed:@"emptyOrderImage"];
        self.backview.titleLabel.text =LaguageControl(@"您还没有相关订单");
        self.backview.contentLabel.text = @"";
        self.lookDetialTableView.backgroundView = self.backview;
    }
    else
    {
        self.lookDetialTableView.backgroundView = nil;
    }
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    return  model.gcpList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    BuyerOrderModel * model = self.dataArray[indexPath.section];
    OrderGoodsModel * gcmodel =  model.gcpList[indexPath.row];
    
    OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    [cell loadData:gcmodel andindex:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (KScreenBoundWidth>320)
    {
        return 90;
    }
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];

    OrderTableHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
    if (!view) {
        [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
    }
    [view LoadData:model with:[model.status integerValue]];
    WeakSelf(self)
    view.shopbtnClickBlock = ^(NSInteger section) {
        PayAttentionShopViewController *vc = [[PayAttentionShopViewController alloc]init];
        vc.storeID = model.store_id;
        if (weakSelf.FatherVC)
        {
            [weakSelf.FatherVC.navigationController pushViewController:vc animated:YES];
        }
        else{
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];

    OrderTableFootView* view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    if (!view) {
        [tableView registerNib:[UINib nibWithNibName:FootIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FootIdentifier];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    }
    view.delegate = self;
    [view loaddata:model with:[model.status integerValue] withSection:section];
    return view;
}

/** 删除订单 */
-(void)DelegateOrderButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];    
    OrderDetailViewController * view = [[OrderDetailViewController alloc] init];
    view.orderId = model.buyoderid;
    view.buyOrderModel = model;
    view.orderType = self.ordertype;
    if (self.FatherVC) {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }


}

/** 联系卖家 */
-(void)ConnectSellerButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];

    StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
    view.type = @"0";
    view.toUserID =model.store_userId;
    view.title = model.store_userName;
    if (self.FatherVC) {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }
    
}

/** 查看评价详情 */
-(void)LookEvaluationButtonClickedWithSection:(NSInteger)section
{
    
    BuyerOrderModel * model = self.dataArray[section];
        OrdereValuationDetailsViewController * controller = [[OrdereValuationDetailsViewController alloc] init];
    controller.orderId = model.buyoderid;
    controller.hidesBottomBarWhenPushed = YES;
    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:controller animated:YES];
    }
    else{
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyerOrderModel * model = self.dataArray[indexPath.section];
    OrderDetailViewController * view = [[OrderDetailViewController alloc] init];
    view.orderId = model.buyoderid;
    view.buyOrderModel = model;
    view.orderType = self.ordertype;
    if (self.FatherVC) {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }
}
/** 投诉 */
-(void)complaintsButtonClickedWithSection:(NSInteger)section{
    BuyerOrderModel * model = self.dataArray[section];

    ChooseComplaintGoodsViewController * choose = [[ChooseComplaintGoodsViewController alloc] init];
    choose.orderModel = model;
    choose.buyer = YES;
    if (self.FatherVC) {
        [self.FatherVC.navigationController pushViewController:choose animated:YES];
    }
    else{
        [self.navigationController pushViewController:choose animated:YES];
    }
    
}

/** 评价 */
-(void)ToevaluationButtonClickedWithSection:(NSInteger)section{
    BuyerOrderModel * model = self.dataArray[section];

    EvalutionDetialViewController * controller = [[EvalutionDetialViewController alloc] init];
    controller.model = model;
    controller.FatherVC = self;
    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:controller animated:YES];
    }
    else{
        [self.navigationController pushViewController:controller animated:YES];
    }
}

/** 退款 */
-(void)refundButtonClickedWithSection:(NSInteger)section{
    RefundApplyView * view = [[RefundApplyView alloc] init];
    [view displayFromWindow];
}

/** 查看物流 */
-(void)CheckTheLogisticsButtonClickedWithSection:(NSInteger)section{
    BuyerOrderModel * model = self.dataArray[section];
    if (model.goods_type) {
        [HUDManager showWarningWithText:@"虚拟商品,无物流信息!"];
        return;
    }
    LogisticsDetailsViewController  * view = [[LogisticsDetailsViewController alloc] init];
    view.orderid = model.buyoderid;
    view.ordermodel = model;

    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }
}

/** 确认收货 */
-(void)ConfimAceptButtonClickedWithSection:(NSInteger)section{
    BuyerOrderModel * model = self.dataArray[section];
    [OrderManagerNetWork ConfirmAcceptOrder:model.buyoderid ResultBlock:^(BOOL success) {
        if (success)
        {
            [self NetWork];
        }
    }];

}

/** 付款 */
-(void)PayMoneyButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];

    MywalletViewController * view = [MywalletViewController new];
    view.isOffline = model.lineType;
    view.orderNumber = model.buyoderid;
    view.FatherVC = self;
    view.isGoods = self.isGoods;
    view.orderPayMoney = model.totalPrice;
    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }
}
/** 取消订单 */
-(void)CanCelOrderButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    __weak LookDetialViewController * weakself = self;
    OffPayPopView * view = [[OffPayPopView alloc] init];
    
    [view getsureEventBlock:^(NSString *content) {
        [weakself CancelOrderNet:model.buyoderid andstate:content];
    }];
    view.title = LaguageControl(@"您确认取消此订单吗");
    view.issues = @[@"其他原因",@"不想要了",@"地址填写错误"];
    view.orderID =model.order_id;
    [view displayFromWindow];
    
    
}
/** 取消订单网络请求 */
-(void)CancelOrderNet:(NSString*)modeid andstate:(NSString*)state
{
    __weak LookDetialViewController * weakself = self;

    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork CancelOrder:modeid Content:state ResultBlock:^(BOOL success)
     {
         [HUDManager hideHUDView];
         if (success)
         {
             weakself.begin = 1;
             [weakself NetWork];
         }
     }];
}
/** 取消退款 */
-(void)CanCelrefundButtonClickedWithSection:(NSInteger)section{
    BuyerOrderModel * model = self.dataArray[section];
    __weak LookDetialViewController * weakself = self;
    [OrderManagerNetWork CancelArefundMoney:model.buyoderid Content:@"" ResultBlock:^(BOOL success) {
        if (success) {
            weakself.begin = 1;
            [weakself NetWork];
        }
    }];
}
/** 更多 */
-(void)OrderMoreButtonClicked:(UIButton *)button withOrderType:(OrderTypes)type andSection:(NSInteger)section andView:(OrderTableFootView *)view
{    BuyerOrderModel * model = self.dataArray[section];

    __weak LookDetialViewController * weakself = self;
    CGFloat m =view.frame.origin.y+view.frame.size.height-35+kNavigaTionBarHeight;
    if (type==OrderTypesToAccePt) {
        
        if (!popview) {
            popview = [PopMoreView loadView];
        }
        [popview showViewWithheight:m withBlcok:^(SelectTypes type) {
            if (type==SelectTypesConnectSeller)
            {
                StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
                view.type = @"0";
                view.toUserID = model.store_userId;
                view.title = model.store_userName;
                if (weakself.FatherVC) {
                    [weakself.navigationController pushViewController:view animated:YES];
                }
                else{
                    [weakself.navigationController pushViewController:view animated:YES];
                }
            }
            else
            {
                ChooseComplaintGoodsViewController * view = [ChooseComplaintGoodsViewController new];
                view.orderModel = model;
                view.buyer = YES;
                if (weakself.FatherVC) {
                    [weakself.navigationController pushViewController:view animated:YES];
                }
                else{
                    [weakself.navigationController pushViewController:view animated:YES];
                }
            }
        }];
        
    }
    else
    {
        if (!popChangView)
        {
            popChangView = [PopChangView loadViewWith:LaguageControl(@"退款")];
        }
        [popChangView showViewWithheight:m withBlcok:^(BOOL select) {
            RefundApplyView * views = [[RefundApplyView alloc] init];
            [views GetResultBlock:^(NSString *string) {
                [OrderManagerNetWork ArefundOrder:model.buyoderid Content:string ResultBlock:^(BOOL success)
                 {
                     if (success)
                     {
                         weakself.begin=1;
                         [weakself NetWork];
                     }
                 }];
            }];
            
            [views displayFromWindow];
        }];
    }
}
#pragma mark - WalletDetailsUnfoldViewDelegate
- (void)orderTypeView:(WalletDetailsUnfoldView *)view type:(NSInteger)type title:(NSString *)title
{
    
}
#pragma mark - setter and getter
- (WalletDetailsTitleView *)titleView
{
    if(!_titleView)
    {
        WalletDetailsTitleView * titleView = [[WalletDetailsTitleView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
        [titleView setTitle:@"全部订单" forState:UIControlStateNormal];
        [titleView setImage:[UIImage imageNamed:@"sanjiao"] forState:UIControlStateNormal];
        self.navigationItem.titleView = titleView;
        _titleView = titleView;
    }
    return _titleView;
}
- (WalletDetailsUnfoldView *)unfoldView
{
    if(!_unfoldView)
    {
        WalletDetailsUnfoldView * view = [[WalletDetailsUnfoldView alloc] initWithItems:@[@"全部订单",@"已完成订单",@"已取消订单",@"退款中",@"退款成功",@"退款失败"] defaultItemIndex:0];
        view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:view];
        view.delegate = self;
        _unfoldView = view;
    }
    [self.view layoutIfNeeded];
    return _unfoldView;
}

@end
