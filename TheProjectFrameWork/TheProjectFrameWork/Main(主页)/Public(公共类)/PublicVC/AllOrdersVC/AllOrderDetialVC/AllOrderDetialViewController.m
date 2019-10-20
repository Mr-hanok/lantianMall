//
//  AllOrderDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AllOrderDetialViewController.h"
#import "OrderTableViewCell.h"
#import "BuyAndSendDetialViewController.h"
#import "OrderTableHeadView.h"
#import "OrderTableFootView.h"
#import "RefundApplyView.h"
#import "OrderDetailViewController.h"
#import "StationMessageChatViewController.h"
#import "PopChangView.h"
#import "PopMoreView.h"
#import "ChooseComplaintGoodsViewController.h"
#import "BuyerOrderModel.h"
#import "OrderGoodsModel.h"
#import "OffPayPopView.h"
#import "MywalletViewController.h"
#import "OrdereValuationDetailsViewController.h"
#import "OrderManagerNetWork.h"
#import "BaviTitleView.h"
#import "EvalutionDetialViewController.h"
#import "ShoppingNotView.h"
#import "LogisticsDetailsViewController.h"
#import "PayAttentionShopViewController.h"

static NSString * HeadIdentifier = @"OrderTableHeadView";

static NSString * FootIdentifier = @"OrderTableFootView";

static NSString * cellIdentifier = @"OrderTableViewCell";

@interface AllOrderDetialViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableFootViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *allOrderTableView;
/** 数据源 */
@property(strong,nonatomic) NSMutableArray * dataArray;
@property(assign,nonatomic) NSInteger begin;
@property(assign,nonatomic) CGFloat scrollerheight;
@property(strong,nonatomic) NSString * searchResult;

@end

@implementation AllOrderDetialViewController
{
    PopChangView * popChangView;
    PopMoreView * popview;
    BaviTitleView * titleview;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.begin = 1;
    self.dataArray = [NSMutableArray array];
    self.allOrderTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    if (!self.isSearch) {
        [self NetWork];
    }
    [self updataNewData:self.allOrderTableView];
}
-(void)updateFootView
{
//    self.begin++;
    [self NetWork];

}
-(void)updateHeadView
{
    self.begin =1;
    [self NetWork];
}
-(void)BaseLoadView
{
    [self loadNavigabarTitleView];
}
-(void)loadNavigabarTitleView
{
   titleview  = [BaviTitleView loadView];
    self.navigationItem.titleView = titleview;
    titleview.searchBar.layer.cornerRadius = 5;
    titleview.searchBar.delegate = self;
    titleview.searchBar.layer.masksToBounds = YES;
    titleview.searchBar.backgroundImage = [UIImage new];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)NetWork
{
    NSString * begin = @"1";
    if (self.begin) {
        begin = [NSString stringWithFormat:@"%ld",(long)self.begin];
    }
    NSDictionary * dic = @{@"currentPage":begin,
                           @"order_status":@"",
                           @"user_id":kUserId,
                           @"condition":self.searchResult?self.searchResult:@"",
                           };
    [NetWork PostNetWorkWithUrl:@"/buyer/order" with:dic successBlock:^(NSDictionary *dic)
    {
        [self endRefresh];
        if (self.begin==1)
        {
            [self.dataArray removeAllObjects];
        }
        if ([dic[@"status"] boolValue])
        {
            NSMutableArray * arrray =[BuyerOrderModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.dataArray addObjectsFromArray:arrray];
            if (arrray.count <[dic[@"pageSize"]integerValue] ) {
                [self.allOrderTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                self.begin++;
                [self.allOrderTableView.mj_footer resetNoMoreData];
            }
            if (self.isSearch && arrray.count ==0) {
                [HUDManager showWarningWithText:@"没有搜到相关订单"];
            }
        }
        
        [self.allOrderTableView reloadData];
    } errorBlock:^(NSString *error)
     {
         [self endRefresh];
    }];
    
}

#pragma mark --UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray.count==0)
    {
        self.backview = [ShoppingNotView loadView];
        self.backview.placeImageView.image = [UIImage imageNamed:@"emptyOrderImage"];
        self.backview.titleLabel.text =LaguageControl(@"您还没有相关订单");
        self.backview.contentLabel.text = @"";
        self.allOrderTableView.backgroundView = self.backview;
    }
    else
    {
        self.allOrderTableView.backgroundView = nil;
    }
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    
    return model.gcpList.count;
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
    OrderTableFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    if (!view) {
        [tableView registerNib:[UINib nibWithNibName:FootIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FootIdentifier];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    }
    view.delegate = self;

    [view loaddata:model with:[model.status integerValue] withSection:section];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyerOrderModel * model = self.dataArray[indexPath.section];

    OrderDetailViewController * view = [[OrderDetailViewController alloc] init];
    view.orderId = model.buyoderid;
    view.orderType = [model.status integerValue];
    view.buyOrderModel = model;
    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }

}

#pragma mark --OrderTableFootViewDelegate
/** 删除订单 */
-(void)DelegateOrderButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    OrderDetailViewController * view = [[OrderDetailViewController alloc] init];
    view.orderId = model.buyoderid;
    view.orderType = [model.status integerValue];
    view.buyOrderModel = model;
    if (self.FatherVC)
    {
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
    view.toUserID = model.store_userId;
    view.type = @"0";
    view.title = model.store_userName;
    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }
}

/** 投诉 */
-(void)complaintsButtonClickedWithSection:(NSInteger)section{
    ChooseComplaintGoodsViewController * view  = [ChooseComplaintGoodsViewController new];
    BuyerOrderModel * model = self.dataArray[section];
    view.orderModel = model;
    view.buyer = YES;
    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }
    else{
        [self.navigationController pushViewController:view animated:YES];
    }
}

/** 评价 */
-(void)ToevaluationButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    
    EvalutionDetialViewController * view = [EvalutionDetialViewController new];
    
    view.model = model;
    if (self.FatherVC)
    {
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
/** 退款 */
-(void)refundButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    __weak AllOrderDetialViewController * weakself = self;
    RefundApplyView * view = [[RefundApplyView alloc] init];
    [view GetResultBlock:^(NSString *string) {
       [OrderManagerNetWork ArefundOrder:model.buyoderid Content:string ResultBlock:^(BOOL success)
        {
            if (success)
            {
                weakself.begin=1;
                [weakself NetWork];
            }
       }];
    }];
    [view displayFromWindow];
}

/** 查看物流 */
-(void)CheckTheLogisticsButtonClickedWithSection:(NSInteger)section{
    BuyerOrderModel * model = self.dataArray[section];
    if (model.goods_type) {
        [HUDManager showWarningWithText:@"虚拟商品,无物流信息!"];
        return;
    }
    LogisticsDetailsViewController *vc = [[LogisticsDetailsViewController     alloc]init];
    vc.ordermodel = model;
    vc.orderid = model.buyoderid;
    if (self.FatherVC)
    {
        [self.FatherVC.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/** 确认收货 */
-(void)ConfimAceptButtonClickedWithSection:(NSInteger)section
{
    __weak AllOrderDetialViewController * weakself = self;
    BuyerOrderModel * model = self.dataArray[section];
    [OrderManagerNetWork ConfirmAcceptOrder:model.buyoderid ResultBlock:^(BOOL success) {
        if (success)
        {
            weakself.begin = 1;
            [weakself NetWork];
        }
    }];
    
}

/** 付款 */
-(void)PayMoneyButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    MywalletViewController * view = [MywalletViewController new];
    view.FatherVC = self.FatherVC;
    view.isOffline = model.lineType;
    view.orderPayMoney = model.totalPrice;
    view.orderNumber = model.buyoderid;
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
    __weak AllOrderDetialViewController * weakself = self;
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
    __weak AllOrderDetialViewController * weakself = self;
    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork CancelOrder:modeid Content:state ResultBlock:^(BOOL success)
    {
        [HUDManager hideHUDView];
        if (success) {
            weakself.begin = 1;
            [weakself NetWork];
        }
    }];
}
/** 取消退款 */
-(void)CanCelrefundButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    __weak AllOrderDetialViewController * weakself = self;
    [OrderManagerNetWork CancelArefundMoney:model.buyoderid Content:@"" ResultBlock:^(BOOL success) {
        if (success) {
            weakself.begin = 1;
            [weakself NetWork];
        }
    }];
}
/** 更多 */
-(void)OrderMoreButtonClicked:(UIButton *)button withOrderType:(OrderTypes)type andSection:(NSInteger)section andView:(OrderTableFootView *)view
{
    
    BuyerOrderModel * model = self.dataArray[section];
    __weak AllOrderDetialViewController * weakself = self;
    RefundApplyView * popvi = [[RefundApplyView alloc] init];
    [popvi GetResultBlock:^(NSString *string) {
        
        [OrderManagerNetWork ArefundOrder:model.buyoderid Content:string ResultBlock:^(BOOL success)
                          {
                              if (success)
                              {
                                  weakself.begin=1;
                                  [weakself NetWork];
                              }
                          }];
    }];
    [popvi displayFromWindow];

    
//    BuyerOrderModel * model = self.dataArray[section];
//    CGFloat m =view.frame.origin.y+view.frame.size.height-35+kNavigaTionBarHeight;
//
//    if (self.isSearch)
//    {
//        m =view.frame.origin.y+view.frame.size.height-35-self.scrollerheight+kNavigaTionBarHeight+60;
//    }
//    if (type==OrderTypesToAccePt) {
//        
//        if (!popview) {
//            popview = [PopMoreView loadView];
//        }
//        __weak AllOrderDetialViewController * weakself = self;
//        [popview showViewWithheight:m withBlcok:^(SelectTypes type) {
//            if (type==SelectTypesConnectSeller)
//            {
//                StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
//                view.type = @"0";
//                view.toUserID = model.store_userId;
//                view.title = model.store_userName;
//                if (weakself.FatherVC) {
//                    [weakself.FatherVC.navigationController pushViewController:view animated:YES];
//                }
//                else
//                {
//                    [weakself.navigationController pushViewController:view animated:YES];
//
//                }
//            }
//            else
//            {
//                ChooseComplaintGoodsViewController * view = [ChooseComplaintGoodsViewController new];
//                view.orderModel = model;
//                view.buyer = YES;
//                if (weakself.FatherVC) {
//                    [weakself.FatherVC.navigationController pushViewController:view animated:YES];
//                }
//                else
//                {
//                    [weakself.navigationController pushViewController:view animated:YES];
//                }
//            }
//        }];
//
//    }
//    else
//    {
//        if (!popChangView)
//        {
//            popChangView = [PopChangView loadViewWith:LaguageControl(@"退款")];
//        }
//        __weak AllOrderDetialViewController * weakself = self;
//        [popChangView showViewWithheight:m withBlcok:^(BOOL select) {
//            RefundApplyView * views = [[RefundApplyView alloc] init];
//            [views GetResultBlock:^(NSString *string) {
//                [OrderManagerNetWork ArefundOrder:model.buyoderid Content:string ResultBlock:^(BOOL success)
//                 {
//                     if (success)
//                     {
//                         weakself.begin=1;
//                         [weakself NetWork];
//                     }
//                 }];
//            }];
//
//            [views displayFromWindow];
//        }];
//    }
    
}
#pragma mark--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollerheight =scrollView.contentOffset.y;
}
#pragma mark -- UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar

{
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchResult = searchText;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.begin=1;
    self.searchResult = searchBar.text;
    [searchBar resignFirstResponder];
    [self NetWork];
}
@end
