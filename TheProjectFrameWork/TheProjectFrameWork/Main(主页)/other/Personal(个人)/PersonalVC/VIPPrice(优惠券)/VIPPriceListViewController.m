//
//  VIPPriceListViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/23.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "VIPPriceListViewController.h"
#import "VipPriceListCell.h"
#import "VipPriceModel.h"
#import "PayAttentionShopViewController.h"

@interface VIPPriceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation VIPPriceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    
    [self updataNewData:self.tableview];
    [self beginRefresh];
}

#pragma mark - Refresh
-(void)updateHeadView{
    self.currentPage = 1;
    [self getdataFromServer];
}
-(void)updateFootView{
    [self getdataFromServer];

}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"VipPriceListCell";
    VipPriceListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"VipPriceListCell" owner:nil options:0] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.type = self.type;
    [cell confitCellWithModel:self.array[indexPath.section]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VipPriceModel *model = self.array[indexPath.section];
    
    if ([model.overdue isEqualToString:@"0"]) {
        /**未过期 */
        if ([model.status isEqualToString:@"0"]) {
            /**未使用*/
            if ([model.coupon_type isEqualToString:@"1"]){
                /**店铺*/
                
                PayAttentionShopViewController *vc =   [[PayAttentionShopViewController alloc]init];
                vc.storeID = model.store_id;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self.tabBarController setSelectedIndex:0];
            }
        }
    }
    
    
}


#pragma mark - setter

-(UITableView *)tableview{
    if (!_tableview) {
        
        UITableView *tablev = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tablev.delegate = self;
        tablev.dataSource = self;
        tablev.separatorStyle = UITableViewCellSeparatorStyleNone;
        tablev.tableFooterView = [[UIView alloc]init];
        tablev.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,20)];;
        tablev.backgroundColor = kBGColor;
        tablev.sectionFooterHeight = tablev.sectionHeaderHeight = 10;
        tablev.rowHeight = 125;
        tablev.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tablev];
        self.tableview = tablev;
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.left.right.mas_equalTo(self.view);
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.edges.equalTo(self.view);
            }
        }];
    }
    return _tableview;
}


#pragma mark - getdata
- (void)getdataFromServer{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kUserId forKey:@"user_id"];
    [params setObject:[[NSNumber numberWithInteger:self.type]stringValue] forKey:@"type"];
    [params setObject:[[NSNumber numberWithInteger:self.currentPage]stringValue] forKey:@"currentPage"];
    [params setObject:@"10" forKey:@"size"];

    WeakSelf(self)
    [NetWork PostNetWorkWithUrl:@"/coupon/getMyCoupon" with:params successBlock:^(NSDictionary *dic) {
        [weakSelf endRefresh];
        NSArray *temarray = [VipPriceModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        if (self.currentPage == 1) {
            [self.array removeAllObjects];
        }
        if (temarray.count<10) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }else{
            self.currentPage++;
            [self.tableview.mj_footer resetNoMoreData];
        }
        [self.array addObjectsFromArray:temarray];
        [self.tableview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
        [self.tableview reloadData];
    
        
    } FailureBlock:^(NSString *msg) {
        [weakSelf endRefresh];
        [self.tableview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
        [HUDManager showWarningWithText:msg?:@""];

    } errorBlock:^(id error) {
        [weakSelf endRefresh];
        [self.tableview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];

    }];
}
@end
