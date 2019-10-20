//
//  SystemMessageViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SystemMessageViewController.h"
#import "SystemMessageTableViewCell.h"
#import "SystemMessageTableHeadView.h"
#import "MessageDetialViewController.h"
#import "MessageModel.h"

static NSString * cellidentifier = @"SystemMessageTableViewCell";
static NSString * headidentifier = @"SystemMessageTableHeadView";

@interface SystemMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *sysTemTableView;

@property(strong,nonatomic) NSMutableArray * dataArray;

@property(assign,nonatomic) NSInteger begin;

@end

@implementation SystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.begin = 1;
    [self loadTableView];
    [self updataNewData:self.sysTemTableView];


    // Do any additional setup after loading the view from its nib.
}
-(void)updateHeadView{
    self.begin= 1;
    [self NetWork];

}
-(void)updateFootView{
    [self NetWork];

}
-(void)loadTableView
{
    
    self.title = [LaguageControl languageWithString:@"系统消息"];
    [self NetWork];
    self.dataArray = [NSMutableArray array];
    self.sysTemTableView.dataSource = self;
    self.sysTemTableView.rowHeight = 200;
    self.sysTemTableView.delegate = self;
    
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
    begin = [NSString stringWithFormat:@"%ld",(long)self.begin];
    WeakSelf(self);
    NSDictionary * dic = @{@"types":@"2",@"currentPage":begin,@"to_user_id":string};
    [NetWork PostNetWorkWithUrl:@"/system/message" with:dic successBlock:^(NSDictionary *dic) {
        StrongSelf(weakSelf);
        [strongSelf endRefresh];
        if ([dic[@"status"] boolValue]) {
            if (self.begin==1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *array = [MessageModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            if (array.count>=10) {
                self.begin ++;
                [self.sysTemTableView.mj_footer resetNoMoreData];
            }else{
                [self.sysTemTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.dataArray addObjectsFromArray:array];
            [self.sysTemTableView reloadData];
        }
        
    } FailureBlock:^(NSString *msg) {
        StrongSelf(weakSelf);
        [strongSelf endRefresh];

    } errorBlock:^(NSError *error) {
        StrongSelf(weakSelf);
        [strongSelf endRefresh];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --UITableViewDataSource&&UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count ;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellidentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellidentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    }
    MessageModel * model = self.dataArray[indexPath.row];
    cell.messageTimeLabel.text = model.messageTime;
    if (model.messageTitle && ![model.messageTitle isEqualToString:@""]) {
        cell.messageTitleLabel.text = model.messageTitle;
    }else{
        cell.messageTitleLabel.text = model.messageContent;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel * model = self.dataArray[indexPath.row];
    MessageDetialViewController * detialVC = [[MessageDetialViewController alloc] init];
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
