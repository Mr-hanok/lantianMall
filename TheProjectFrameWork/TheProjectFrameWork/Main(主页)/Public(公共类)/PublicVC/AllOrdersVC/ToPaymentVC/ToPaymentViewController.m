//
//  ToPaymentViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ToPaymentViewController.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"

#import "OrderTableHeadView.h"
#import "OrderTableFootView.h"
#import "OffPayPopView.h"
#import "StationMessageChatViewController.h"
#import "MywalletViewController.h"
#import "BuyerOrderModel.h"
#import "OrderGoodsModel.h"
#import "ChooseComplaintGoodsViewController.h"
#import "OrderManagerNetWork.h"
#import "PayAttentionShopViewController.h"


static NSString * HeadIdentifier = @"OrderTableHeadView";

static NSString * FootIdentifier = @"OrderTableFootView";
static NSString * cellIdentifier = @"OrderTableViewCell";

@interface ToPaymentViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableFootViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *paymentTabelView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property(assign,nonatomic) NSInteger begin;

@end

@implementation ToPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self updataNewData:self.paymentTabelView];
    // Do any additional setup after loading the view from its nib.
}
-(void)backToPresentViewController{
    if (self.isGoods) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
//    [HUDManager showLoadingHUDView:self.view];
    NSString * begin = @"1";
    begin = [NSString stringWithFormat:@"%ld",(long)self.begin];
    NSDictionary * dic = @{@"currentPage":begin,
                           @"order_status":@"10",
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
            NSArray * array =  [BuyerOrderModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
             [self.dataArray addObjectsFromArray:array];
             [self.paymentTabelView reloadData];
         }
         [self.paymentTabelView reloadData];
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
        self.paymentTabelView.backgroundView = self.backview;
    }
    else
    {
        self.paymentTabelView.backgroundView = nil;
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
    [view LoadData:model with:OrderTypesToPayment];
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
    [view loaddata:model with:OrderTypesToPayment withSection:section];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count)
    {
        BuyerOrderModel * model = self.dataArray[indexPath.section];
        OrderDetailViewController * view = [[OrderDetailViewController alloc] init];
        view.orderId = model.buyoderid;
        view.buyOrderModel = model;
        view.orderType = OrderTypesToPayment;
        [self.FatherVC.navigationController pushViewController:view animated:YES];
    }

}
#pragma mark -- OrderTableViewCellDelegate

/** 联系卖家 */
-(void)ConnectSellerButtonClickedWithSection:(NSInteger)section
{
    StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
    BuyerOrderModel * model = self.dataArray[section];
    view.type = @"0";
    view.toUserID = model.store_userId;
    view.title = model.store_userName;
    [self.FatherVC.navigationController pushViewController:view animated:YES];

}

/** 投诉 */
-(void)complaintsButtonClickedWithSection:(NSInteger)section
{
    ChooseComplaintGoodsViewController * view  = [ChooseComplaintGoodsViewController new];
    BuyerOrderModel * model = self.dataArray[section];
    view.orderModel = model;
    view.buyer = YES;
    [self.FatherVC.navigationController pushViewController:view animated:YES];
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
    [self.FatherVC.navigationController pushViewController:view animated:YES];
}

/** 取消订单 */
-(void)CanCelOrderButtonClickedWithSection:(NSInteger)section
{
    BuyerOrderModel * model = self.dataArray[section];
    
    __weak ToPaymentViewController * weakself = self;
    
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
    [HUDManager showLoadingHUDView:self.view];
    [OrderManagerNetWork CancelOrder:modeid Content:state ResultBlock:^(BOOL success)
     {
         [HUDManager hideHUDView];
         if (success) {
             self.begin = 1;
             [self NetWork];
         }
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
