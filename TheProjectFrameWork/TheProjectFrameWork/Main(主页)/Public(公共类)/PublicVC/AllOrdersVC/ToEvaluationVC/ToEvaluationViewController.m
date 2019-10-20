//
//  ToEvaluationViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ToEvaluationViewController.h"
#import "OrderTableViewCell.h"

#import "OrderTableHeadView.h"
#import "OrderTableFootView.h"
#import "OrderDetailViewController.h"
#import "StationMessageChatViewController.h"
#import "PopChangView.h"
#import "RefundApplyView.h"
#import "BuyerOrderModel.h"
#import "OrderGoodsModel.h"
#import "ChooseComplaintGoodsViewController.h"
#import "EvalutionDetialViewController.h"
#import "OrdereValuationDetailsViewController.h"
#import "OrderManagerNetWork.h"
#import "LogisticsDetailsViewController.h"
#import "PayAttentionShopViewController.h"


static NSString * HeadIdentifier = @"OrderTableHeadView";

static NSString * FootIdentifier = @"OrderTableFootView";

static NSString * cellIdentifier = @"OrderTableViewCell";

@interface ToEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableFootViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *evaluationTableView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property(assign,nonatomic) NSInteger begin;

@property(assign,nonatomic) CGFloat scrollerheight;

@end

@implementation ToEvaluationViewController
{
    PopChangView * popChangView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self updataNewData:self.evaluationTableView];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)BaseLoadView
{
    self.begin =1;
    [self NetWork];
}
-(void)updateFootView
{
    self.begin++;
    [self NetWork];
    
}
-(void)updateHeadView
{
    self.begin =1;
    [self NetWork];
}
-(void)NetWork
{
    NSString * begin = @"1";
    if (self.begin) {
        begin = [NSString stringWithFormat:@"%ld",(long)self.begin];
    }
    NSDictionary * dic = @{@"currentPage":begin,
                           @"order_status":@"40",
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
              NSArray * array = [BuyerOrderModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
             [self.dataArray addObjectsFromArray:array];
             
         }
         [self.evaluationTableView reloadData];
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
        self.evaluationTableView.backgroundView = self.backview;
    }
    else
    {
        self.evaluationTableView.backgroundView = nil;
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
    
    
    OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];

    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    BuyerOrderModel * model = self.dataArray[indexPath.section];
    OrderGoodsModel * gcmodel =  model.gcpList[indexPath.row];
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
    [view LoadData:model with:OrderTypesToEvaluation];
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

    
    OrderTableFootView* view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    if (!view) {
        [tableView registerNib:[UINib nibWithNibName:FootIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FootIdentifier];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    }
    view.delegate = self;
    BuyerOrderModel * model = self.dataArray[section];
    [view loaddata:model with:[model.status integerValue] withSection:section];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BuyerOrderModel * model = self.dataArray[indexPath.section];
    OrderDetailViewController * view = [[OrderDetailViewController alloc] init];
    view.orderId = model.buyoderid;
    view.buyOrderModel = model;

    view.orderType = OrderTypesToEvaluation;
    [self.FatherVC.navigationController pushViewController:view animated:YES];
}
#pragma mark -- OrderTableViewCellDelegate
/** 退款 */
-(void)refundButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    __weak ToEvaluationViewController * weakself = self;
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

/** 联系卖家 */
-(void)ConnectSellerButtonClickedWithSection:(NSInteger)section
{
    StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
    BuyerOrderModel * model = self.dataArray[section];
    view.type = @"0";
    view.toUserID = model.store_id;
    view.title = model.store_userName;
    [self.FatherVC.navigationController pushViewController:view animated:YES];

}
/** 查看评价详情 */
-(void)LookEvaluationButtonClickedWithSection:(NSInteger)section
{
    
    BuyerOrderModel * model = self.dataArray[section];
    
    OrdereValuationDetailsViewController * controller = [[OrdereValuationDetailsViewController alloc] init];
    controller.orderId = model.buyoderid;
    controller.hidesBottomBarWhenPushed = YES;
    [self.FatherVC.navigationController pushViewController:controller animated:YES];
    
}

/** 投诉 */
-(void)complaintsButtonClickedWithSection:(NSInteger)section
{
    ChooseComplaintGoodsViewController * view  = [ChooseComplaintGoodsViewController new];
    BuyerOrderModel * model = self.dataArray[section];
    view.buyer = YES;
    view.orderModel = model;
    [self.FatherVC.navigationController pushViewController:view animated:YES];

}

/** 评价 */
-(void)ToevaluationButtonClickedWithSection:(NSInteger)section{
    BuyerOrderModel * model = self.dataArray[section];

    EvalutionDetialViewController * view = [EvalutionDetialViewController new];
    view.model = model;
    view.FatherVC = self.FatherVC;
    [self.FatherVC.navigationController pushViewController:view animated:YES];
}


/** 确认收货 */
-(void)ConfimAceptButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork ConfirmAcceptOrder:model.buyoderid ResultBlock:^(BOOL success) {
        [HUDManager hideHUDView];
        if (success)
        {
            self.begin =1;
            [self NetWork];
        }
    }];
}

/** 更多 */
-(void)OrderMoreButtonClicked:(UIButton *)button withOrderType:(OrderTypes)type andSection:(NSInteger)section andView:(OrderTableFootView *)view
{
    BuyerOrderModel * model = self.dataArray[section];

    if (!popChangView)
    {
        popChangView = [PopChangView loadViewWith:@"退款"];
    }
    __weak ToEvaluationViewController * weakself = self;
    [popChangView showViewWithheight:view.frame.origin.y+view.frame.size.height-35-self.scrollerheight+kNavigaTionBarHeight+60 withBlcok:^(BOOL select) {
        RefundApplyView * views = [[RefundApplyView alloc] init];
        [views GetResultBlock:^(NSString *string) {
            [weakself refundApplyView:model.buyoderid andContent:string];
        }];
        [views displayFromWindow];
    }];

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
            [self NetWork];
        }
    }];
}

#pragma mark--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollerheight =scrollView.contentOffset.y;
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
