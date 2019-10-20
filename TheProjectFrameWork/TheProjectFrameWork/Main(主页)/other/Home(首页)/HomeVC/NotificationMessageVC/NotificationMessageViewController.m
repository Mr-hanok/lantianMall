//
//  NotificationMessageViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NotificationMessageViewController.h"
#import "NotificationMessageTableViewCell.h"
#import "NotificationMessageTableFootView.h"
#import "MessageDetialViewController.h"
#import "MessageModel.h"
static NSString * footIdentifier =@"NotificationMessageTableFootView";
static NSString * cellIdentifier =@"NotificationMessageTableViewCell";

@interface NotificationMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *notificationTableView;
@property(assign,nonatomic) NSInteger begin;
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation NotificationMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updataNewData:self.notificationTableView];
    [self loadTableView];
    self.begin =1;
    self.notificationTableView.sectionHeaderHeight =0 ;
    // Do any additional setup after loading the view from its nib.
}
-(void)loadTableView
{
    self.dataArray = [NSMutableArray array];
    [self NetWork];
    
}
-(void)BaseLoadView{
    [self beginRefresh];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
}
-(void)NetWork
{
    NSString * string = @"";
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        string = kUserId;
    }
    NSString * begin = @"1";
    if (self.begin)
    {
        begin = [NSString stringWithFormat:@"%ld",(long)self.begin];
    }
    NSDictionary * dic = @{@"types":@"0",@"currentPage":begin,@"to_user_id":string};
    [NetWork PostNetWorkWithUrl:@"/system/message" with:dic successBlock:^(NSDictionary *dic) {
        if ([dic[@"status"] boolValue])
        {
            if (self.begin==1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *array = [MessageModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.dataArray addObjectsFromArray:array];
            [self.notificationTableView reloadData];
        }
        
    } FailureBlock:^(NSString *msg) {
        
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self beginRefresh];
}


#pragma mark --UITableViewDelegate&&UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MessageModel * model = self.dataArray[indexPath.section];
    NotificationMessageTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.titleLabel.text = model.messageTitle;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MessageModel * model = self.dataArray[section];

    NotificationMessageTableFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footIdentifier];
    if (!view) {
        [tableView registerNib:[UINib nibWithNibName:footIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:footIdentifier];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footIdentifier];
    }
    view.titleLabel.text = model.messageTime;
    view.titleLabel.layer.masksToBounds = YES;
    view.titleLabel.layer.cornerRadius = 3;
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageDetialViewController * detialVC = [[MessageDetialViewController alloc] init];
    MessageModel * model = self.dataArray[indexPath.row];
    detialVC.model = model;
    [self.navigationController pushViewController:detialVC animated:YES];
    
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
