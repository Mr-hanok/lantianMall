//
//  ChooseComplaintGoodsViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ChooseComplaintGoodsViewController.h"
#import "ChooseComplaintGoodsCell.h"
#import "BuyerOrderModel.h"
#import "ComplaintsViewController.h"
static NSString * ChooseComplaintGoodsCellId = @"ChooseComplaintGoodsCell";
@interface ChooseComplaintGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,ChooseComplaintGoodsCellDelegate>
@property (nonatomic , weak) UITableView * goodsTableView;
@property (nonatomic , strong) NSMutableArray * selectGoods;
@end
@implementation ChooseComplaintGoodsViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.goodsTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"选择投诉商品");
}
#pragma mark - event respond
- (void)complaintGoodNext
{
    if(_selectGoods.count == 0)
    {
        [HUDManager showWarningWithText:@"请至少选择一件商品"];
        return;
    }
    ComplaintsViewController * complaints = [[ComplaintsViewController alloc] init];
    complaints.buyerOrder = _orderModel;
    complaints.goodsModels = _selectGoods;
    complaints.buyer = _buyer;
    [self.navigationController pushViewController:complaints animated:YES];
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderModel.gcpList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseComplaintGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:ChooseComplaintGoodsCellId];
    cell.delegate = self;
    cell.row = indexPath.row;
    cell.model = _orderModel.gcpList[indexPath.row];
    return cell;
}
- (void)chooseComplaintGoodsCell:(ChooseComplaintGoodsCell *)cell
{
   if(cell.goodsSelected)
   {
       [self.selectGoods addObject:cell.model];
   }else
   {
       [self.selectGoods removeObject:cell.model];
   }
    
}
#pragma mark - setter and getter
- (UITableView *)goodsTableView
{
    if(!_goodsTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-kScaleHeight(44)) style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.estimatedRowHeight = 100;
        [tableview registerClass:[ChooseComplaintGoodsCell class] forCellReuseIdentifier:ChooseComplaintGoodsCellId];
        UIButton * next = [UIButton buttonWithType:UIButtonTypeCustom];
        next.frame = (CGRect){0,self.view.bounds.size.height - 49 , self.view.bounds.size.width,49};
        next.backgroundColor = kNavigationColor;
        [next setTitle:LaguageControl(@"下一步") forState:UIControlStateNormal];
        [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [next addTarget:self action:@selector(complaintGoodNext) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tableview];
        [self.view addSubview:next];
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(49);
        }];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(next.mas_top);
        }];
        _goodsTableView = tableview;
    }
    return _goodsTableView;
}
- (NSMutableArray *)selectGoods
{
    if(!_selectGoods)
    {
        _selectGoods = [@[]mutableCopy];
    }
    return _selectGoods;
}
@end
