//
//  ToAcceptViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ToAcceptViewController.h"
#import "OrderTableViewCell.h"
#import "OrderTableHeadView.h"
#import "OrderTableFootView.h"
#import "OrderDetailViewController.h"
#import "LogisticsDetailsViewController.h"
#import "PopMoreView.h"
#import "StationMessageChatViewController.h"
#import "RefundApplyView.h"
#import "ChooseComplaintGoodsViewController.h"
#import "BuyerOrderModel.h"
#import "OrderGoodsModel.h"
#import "OrderManagerNetWork.h"
#import "RefundApplyView.h"
#import "PayAttentionShopViewController.h"


static NSString * HeadIdentifier = @"OrderTableHeadView";

static NSString * FootIdentifier = @"OrderTableFootView";

static NSString * cellIdentifier = @"OrderTableViewCell";

@interface ToAcceptViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableFootViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *acceptTableView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property(assign,nonatomic) NSInteger begin;

@property(assign,nonatomic) CGFloat scrollerheight;

@end

@implementation ToAcceptViewController
{
    PopMoreView * popview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self updataNewData:self.acceptTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)updateFootView
{
    self.begin++;
    [self NetWork];
    
}
-(void)BaseLoadView
{
    self.begin =1;
    [self NetWork];
}
-(void)updateHeadView
{
    self.begin =1;
    [self NetWork];
}
- (void)didReceiveMemoryWarning {
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
                           @"order_status":@"30",
                           @"user_id":kUserId,
                           };
    [NetWork PostNetWorkWithUrl:@"/buyer/order" with:dic successBlock:^(NSDictionary *dic)
     {
         [self endRefresh];
         if (self.begin==1) {
             [self.dataArray removeAllObjects];
         }
         if ([dic[@"status"] boolValue])
         {
             NSArray * array =[BuyerOrderModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
             [self.dataArray addObjectsFromArray:array];
//             for (BuyerOrderModel * model in self.dataArray) {
//                 model.gcpList = [OrderGoodsModel mj_objectArrayWithKeyValuesArray:model.gcpList];
//             }
             
         }
         [self.acceptTableView reloadData];
     } errorBlock:^(NSString *error) {
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
        self.acceptTableView.backgroundView = self.backview;
    }
    else
    {
        self.acceptTableView.backgroundView = nil;
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
        [view LoadData:model with:OrderTypesToAccePt];
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
    [view loaddata:model with:OrderTypesToAccePt withSection:section];
    return view;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BuyerOrderModel * model = self.dataArray[indexPath.section];
    OrderDetailViewController * view = [[OrderDetailViewController alloc] init];
    view.orderId = model.buyoderid;
    view.orderType = OrderTypesToAccePt;
    view.buyOrderModel = model;

    [self.FatherVC.navigationController pushViewController:view animated:YES];
}
#pragma mark -- OrderTableViewCellDelegate

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
-(void)ConnectSellerButtonClickedWithSection:(NSInteger)section{
    StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
    BuyerOrderModel * model = self.dataArray[section];
    view.toUserID = model.store_userId;
    view.type = @"0";
    view.title = model.store_userName;
    [self.FatherVC.navigationController pushViewController:view animated:YES];

}

/** 投诉 */
-(void)complaintsButtonClickedWithSection:(NSInteger)section{
    ChooseComplaintGoodsViewController * view  = [ChooseComplaintGoodsViewController new];
    BuyerOrderModel * model = self.dataArray[section];
    view.orderModel = model;
    view.buyer = YES;
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
    __weak ToAcceptViewController * weakself = self;
    RefundApplyView * popvi = [[RefundApplyView alloc] init];
    [popvi GetResultBlock:^(NSString *string) {
        [weakself refundApplyView:model.buyoderid andContent:string];
    }];
    [popvi displayFromWindow];
    
//    if (!popview) {
//        popview = [PopMoreView loadView];
//    }
//    BuyerOrderModel * model = self.dataArray[section];
//    __weak ToAcceptViewController * weakself = self;
//    [popview showViewWithheight:view.frame.origin.y+view.frame.size.height-35-self.scrollerheight+kNavigaTionBarHeight+60 withBlcok:^(SelectTypes type) {
//        if (type==SelectTypesConnectSeller)
//        {
//            StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
//            view.type = @"0";
//            view.toUserID = model.store_userId;
//            view.title = model.store_userName;
//            [weakself.FatherVC.navigationController pushViewController:view animated:YES];
//        }
//        else
//        {
//            ChooseComplaintGoodsViewController * view = [ChooseComplaintGoodsViewController new];
//            view.orderModel = model;
//            view.buyer = YES;
//            [weakself.FatherVC.navigationController pushViewController:view animated:YES];
//        }
//    }];
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
#pragma mark--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollerheight =scrollView.contentOffset.y;
}
// any offset changes

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
