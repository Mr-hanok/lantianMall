//
//  ArefundOrderDetailViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  退款详情

#import "ArefundOrderDetailViewController.h"
#import "RefundDetailsCell.h"
#import "ArefundOrderDetailViewModel.h"
static NSString * RefundAmountCellID = @"RefundAmountCell";
static NSString * RefundDetailsCellID = @"RefundDetailsCell";
@interface ArefundOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , weak) UITableView * detailTableView;
@property (nonatomic , strong) ArefundOrderDetailViewModel * model;
@end

@implementation ArefundOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updataHeader:self.detailTableView];
    [self.model getArefundOrderDetailInfoWithOrderid:_order_id complete:^(id error) {
        [HUDManager showWarningWithError:error];
        [self.detailTableView reloadData];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"退款详情");
}
- (void)updateHeadView
{
    [self.model getArefundOrderDetailInfoWithOrderid:_order_id complete:^(id error) {
        [self endRefresh];
        [HUDManager showWarningWithError:error];
        [self.detailTableView reloadData];
    }];
}
#pragma mark - tableview Delegate Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.refundDetails.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath.row)
    {
        return kScaleHeight(44);
    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath.row)
    {
        RefundAmountCell * cell = [tableView dequeueReusableCellWithIdentifier:RefundAmountCellID];
        cell.amount = self.model.refundAmount;
        return cell;
    }
    RefundDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:RefundDetailsCellID];
    cell.model = self.model.refundDetails[indexPath.row - 1];
    return cell;
}

- (UITableView *)detailTableView
{
    if(!_detailTableView)
    {
      UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview registerClass:[RefundAmountCell class] forCellReuseIdentifier:RefundAmountCellID];
        [tableview registerClass:[RefundDetailsCell class] forCellReuseIdentifier:RefundDetailsCellID];
        tableview.backgroundColor = [UIColor colorWithString:@"#f7f7f7"];
        [self.view addSubview:tableview];
        __weak typeof(self) weakSelf = self;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.mas_topLayoutGuideTop);
        }];
        _detailTableView = tableview;
    }
    return _detailTableView;
}
- (ArefundOrderDetailViewModel *)model
{
    if(!_model)
    {
        _model = [[ArefundOrderDetailViewModel alloc] init];
    }
    return _model;
}
@end
