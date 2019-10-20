//
//  FanLiViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/12.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "FanLiViewController.h"
#import "FanLiListCell.h"

@interface FanLiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation FanLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的返利";
    self.array = [NSMutableArray array];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = 80;
    self.tableview.backgroundColor = kBGColor;
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"FanLiListCell";
    FanLiListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FanLiListCell" owner:nil options:0]lastObject];
    }
    FanLiModel *model = self.array[indexPath.row];
    cell.label1.text = model.mark;
    if ([model.type isEqualToString:@"2"]) {
        cell.label2.text = @"积分";
    }else if ([model.type isEqualToString:@"1"]){
        cell.label2.text = @"余额";
    }else{
        cell.label2.text = @"其他";
    }
    cell.timeLabel.text = model.addTime;
    cell.moneyLabel.text = model.price;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getdata
- (void)getdataFromServer{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kUserId forKey:@"user_id"];
    [params setObject:[[NSNumber numberWithInteger:self.currentPage]stringValue] forKey:@"page"];
    [params setObject:@"10" forKey:@"size"];
    
    WeakSelf(self)
    [NetWork PostNetWorkWithUrl:@"/my_ratio" with:params successBlock:^(NSDictionary *dic) {
        [weakSelf endRefresh];
        NSArray *temarray = [FanLiModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
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

@implementation FanLiModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"modelId":@"id"};
}
@end
