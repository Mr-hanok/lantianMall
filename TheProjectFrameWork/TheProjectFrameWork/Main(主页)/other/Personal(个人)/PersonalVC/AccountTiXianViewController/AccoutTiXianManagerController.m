//
//  AccoutTiXianManagerController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/3/30.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "AccoutTiXianManagerController.h"
#import "AccoutTiXianManagerCell.h"

@interface AccoutTiXianManagerController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation AccoutTiXianManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现管理";
    self.array = [NSMutableArray array];
    [self updataNewData:self.tableview];
    
    [HUDManager showLoadingHUDView:self.view];
    [self getdata];
}
/**头部刷新*/
-(void)updateHeadView{
    self.currentPage = 1;
    [self.array removeAllObjects];
    [self getdata];
}
/**尾部刷新*/
- (void)updateFootView{
    self.currentPage ++;
    [self getdata];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"AccoutTiXianManagerCell";
    AccoutTiXianManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AccoutTiXianManagerCell" owner:nil options:0]lastObject];
    }
    TiXianManagerModel *model = self.array[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moneyLabel.text = [NSString stringWithFormat:@"提现金额: ¥%@",model.appliyDepositSum];
    NSString *temptime = [model.appliyDate substringToIndex:11];
    cell.timeLabel.text = [NSString stringWithFormat:@"提现时间: %@",temptime];
    cell.accountLabel.text = [NSString stringWithFormat:@"提现账号:%@",model.depositAccount];
    if ([model.depositType integerValue]==1) {
       cell.payTypeLabel.text = [NSString stringWithFormat:@"提现方式: %@",@"支付宝"];
    }else{
        cell.payTypeLabel.text = [NSString stringWithFormat:@"提现方式: %@",@"微信"];
    }
    if ([model.depositStatus integerValue] == 0) {
        cell.stateLabel.text = [NSString stringWithFormat:@"提现状态: %@",@"申请中"];
    }else if ([model.depositStatus integerValue] == 1){
        cell.stateLabel.text = [NSString stringWithFormat:@"提现状态: %@",@"待打款"];
    }else if ([model.depositStatus integerValue] == 2){
        cell.stateLabel.text = [NSString stringWithFormat:@"提现状态: %@",@"已打款"];
    }else{
        cell.stateLabel.text = [NSString stringWithFormat:@"提现状态: %@",@"提现失败"];
    }
    

    return cell;
}

#pragma mark - UITableViewDelegate
/**设置cell高度*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -NetWork
/**提现管理*/
-(void)getdata{
    NSDictionary * parms = @{@"user_id":kUserId,
                             @"currentPage":@(self.currentPage)};
    
    [NetWork PostNetWorkWithUrl:@"/buyer/deposit_list" with:parms successBlock:^(NSDictionary *dic) {
        [self endRefresh];
        if ([dic[@"data"] isKindOfClass:[NSNull class]]) {
            return ;
        }
        NSArray *temp = dic[@"data"][@"result"];
        if ([dic[@"data"][@"result"] isKindOfClass:[NSNull class]]) {
            return ;
        }
        if (temp.count<10) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.array addObjectsFromArray: [TiXianManagerModel mj_objectArrayWithKeyValuesArray:temp]];
        [self.tableview reloadData];
        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}

@end


@implementation TiXianManagerModel


@end
