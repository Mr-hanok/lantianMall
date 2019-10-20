//
//  OrdereValuationDetailsViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrdereValuationDetailsViewController.h"
#import "OrderValuationDetailsCell.h"

static NSString * OrderValuationDetailsCellID = @"OrderValuationDetailsCell";
static NSString * OrderValuationInfoCellID = @"OrderValuationInfoCell";
@interface OrdereValuationDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , weak) UITableView * valuationTableView;
@property (nonatomic , strong) OrdereValuationDetailsViewModel * model;
@end


@implementation OrdereValuationDetailsViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updataHeader:self.valuationTableView];

    [self.model getOrderValuationDetailsInfoWithOrderID:_orderId completed:^(id error) {
        if(error)
        {
            [HUDManager showWarningWithError:error];
        }else
        {
            [self.valuationTableView reloadData];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"评价详情");
}
- (void)updateHeadView
{
    [self.model getOrderValuationDetailsInfoWithOrderID:_orderId completed:^(id error) {
        if(error)
        {
            [HUDManager showWarningWithError:error];
        }else
        {
            [self.valuationTableView reloadData];
        }
        [self endRefresh];
    }];
}
#pragma mark - tableview Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.model.goodsInfo.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell;
    if(indexPath.row)
    {
        OrderValuationInfoCell * infoCell = [tableView dequeueReusableCellWithIdentifier:OrderValuationInfoCellID];
        infoCell.model = self.model.model.goodsInfo[indexPath.row - 1];
        cell = infoCell;
    }else
    {
        OrderValuationDetailsCell * buyerCell = [tableView dequeueReusableCellWithIdentifier:OrderValuationDetailsCellID];
        buyerCell.model = self.model.model;
        cell = buyerCell;
    }
    return cell;
}
#pragma mark - setter and getter
- (UITableView *)valuationTableView
{
    if(!_valuationTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableview.tableFooterView = [UIView new];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.estimatedRowHeight = 100;
        tableview.separatorColor = [UIColor clearColor];
        [tableview registerClass:[OrderValuationDetailsCell class] forCellReuseIdentifier:OrderValuationDetailsCellID];
        [tableview registerClass:[OrderValuationInfoCell class] forCellReuseIdentifier:OrderValuationInfoCellID];
        [self.view addSubview:tableview];
        __weak typeof(self) weakSelf = self;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_topLayoutGuideTop);
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuideBottom);
            make.right.left.equalTo(weakSelf.view);
        }];
        _valuationTableView = tableview;
    }
    return _valuationTableView;
}
- (void)setOrderId:(NSString *)orderId
{
    _orderId = orderId;
  
}
- (OrdereValuationDetailsViewModel *)model
{
    if(!_model)
    {
        _model = [OrdereValuationDetailsViewModel new];
    }
    return _model;
}
@end



@implementation OrdereValuationDetailsViewModel


- (void)getOrderValuationDetailsInfoWithOrderID:(NSString *)orderID completed:(completed)completed
{
    [NetWork PostNetWorkWithUrl:@"/evaluate/watch_evaluate" with:@{@"of_id":orderID} successBlock:^(NSDictionary *dic) {
        _model = [OrdereValuationDetailsModel mj_objectWithKeyValues:dic[@"data"]];
        completed(nil);
    } FailureBlock:^(NSString *msg) {
        completed(msg);
    } errorBlock:^(id error) {
        completed(error);
    }];
}

@end

@implementation OrdereValuationDetailsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userIcon":@"userAcc"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"goodsInfo":@"OrdereValuationGoodsModel"};
}
@end

@implementation OrdereValuationGoodsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goodsIcon":@"goodsAcc"};
}

@end
