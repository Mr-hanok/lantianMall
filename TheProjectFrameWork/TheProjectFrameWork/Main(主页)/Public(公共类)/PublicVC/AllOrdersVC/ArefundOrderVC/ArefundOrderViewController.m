//
//  ArefundOrderViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ArefundOrderViewController.h"
#import "OrderTableHeadView.h"
#import "OrderTableViewCell.h"
#import "BuyerOrderModel.h"
#import "OrderGoodsModel.h"
#import "ArefundOrderFoot.h"
#import "ArefundOrderDetailViewController.h"
#import "OrderNumberHeadView.h"


static NSString * HeadIdentifier = @"OrderNumberHeadView";
static NSString * cellIdentifier = @"OrderTableViewCell";
static NSString * FootIdentifier = @"ArefundOrderFoot";


@interface ArefundOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *arefundTableView;

@property(strong,nonatomic) NSMutableArray * dataArray;
@property(assign,nonatomic) NSUInteger  begin;
@property(strong,nonatomic) NSString * urls;
@end

@implementation ArefundOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arefundTableView.delegate = self;
    self.arefundTableView.dataSource = self;
    self.dataArray = [NSMutableArray array];
    self.arefundTableView.backgroundColor = kBGColor;
    self.arefundTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = LaguageControl(@"退款记录");
    if (self.isBuyer)
    {
        self.urls =@"/buyer/buyer_refund";
    }
    else
    {
        self.urls = @"/buyer/refund";
        
    }
    [self NetWork];
    self.begin=1;
    [self updataNewData:self.arefundTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateFootView
{
    if (self.EndRefresh)
    {
        [self.footer endRefreshingWithNoMoreData];
    }
    else
    {
        self.begin++;
        [self NetWork];
    }
}
-(void)updateHeadView
{
    self.begin =1;
    [self NetWork];
}
-(void)NetWork
{
    self.EndRefresh = NO;
    NSString * begin = @"1";
    if (self.begin) {
        begin = [NSString stringWithFormat:@"%ld",(unsigned long)self.begin];
    }
    NSDictionary * dic = @{@"user_id":kUserId,
                           @"currentPage":begin,
                           };
    [HUDManager showLoadingHUDView:self.view];
    [NetWork PostNetWorkWithUrl:self.urls with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         [self endRefresh];
         if ([dic[@"status"] boolValue])
         {
             if (self.begin==1)
             {
                 [self.dataArray removeAllObjects];
             }
             NSArray * array =[BuyerOrderModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
             if (array.count)
             {
                 [self.dataArray addObjectsFromArray:array];
                 [self.arefundTableView reloadData];
             }
             else{
                 self.EndRefresh = YES;
             }
         }
         [self.arefundTableView reloadData];
     } errorBlock:^(NSString *error) {
         [HUDManager hideHUDView];
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
        self.arefundTableView.backgroundView = self.backview;
    }
    else
    {
        self.arefundTableView.backgroundView = nil;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    BuyerOrderModel * model = self.dataArray[indexPath.section];
     ArefundOrderDetailViewController * view = [ArefundOrderDetailViewController new];
     view.order_id = model.buyoderid;
    [self.navigationController pushViewController:view animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
    
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
    
    OrderNumberHeadView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
    if (!view) {
        [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
    }
    
    switch ([model.status integerValue]) {
            
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
        case OrderTypesRefund:
            view.typeNameLabel.text = LaguageControl(@"退款");
            break;
        case OrderTypesScuccess:
            view.typeNameLabel.text = LaguageControl(@"已完成");
            break;
        case OrderTypesRefundCanCel:
            view.typeNameLabel.text = LaguageControl(@"已取消");
            break;
        case OrderTypesRefundSuccess:
            view.typeNameLabel.text = LaguageControl(@"退款成功");
            break;
        default:
            view.typeNameLabel.text = @"";
            break;
    }
    view.orderNumLabel.text = [NSString stringWithFormat:@"%@%@",LaguageControlAppend(@"订单号"),model.order_id];
    view.typeNameLabel.textColor = kNavigationColor;
    return view ;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    ArefundOrderFoot * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    if (!view)
    {
        [tableView registerNib:[UINib nibWithNibName:FootIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:FootIdentifier];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
    }
    BuyerOrderModel * model = self.dataArray[section];
    if ([model.status integerValue]==OrderTypesRefundCanCel)
    {
        view.ArefundAmountLabel.text  = [NSString stringWithFormat:@"交易金额: ¥%@",model.refundAmount];
        
        view.TransactionAmountLabel.alpha =0;
    }
    else{
        view.TransactionAmountLabel.alpha =1;
        view.TransactionAmountLabel.text = [NSString stringWithFormat:@"交易金额: ¥%@",model.refundAmount];
        view.ArefundAmountLabel.text = [NSString stringWithFormat:@"退款金额: ¥%@",model.refundAmount];
        
    }
       return view;
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
