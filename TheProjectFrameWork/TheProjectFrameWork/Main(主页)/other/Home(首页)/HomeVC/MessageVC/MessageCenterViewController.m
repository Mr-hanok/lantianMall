//
//  MessageCenterViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "NavigationBarView.h"
#import "MessageTableViewCell.h"
#import "SystemMessageViewController.h"
#import "NotificationMessageViewController.h"
#import "StationMessageViewController.h"
static NSString * cellIdentifier = @"MessageTableViewCell";

@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 消息列表 */
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
/** 数据源 */
@property(strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LaguageControl languageWithString:@"信息"];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self ;
    self.dataArray = [NSMutableArray array];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)BaseLoadView{
    self.tabBarController.tabBar.hidden =YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self loadTableView];
}

-(void)loadTableView
{
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        [self.dataArray addObjectsFromArray:@[@"系统消息",@"站内消息"]];
    }
    else{
        [self.dataArray addObjectsFromArray:@[@"系统消息"]];

    }
    
}

#pragma mark --UITableViewDelegate&&UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell * cell  =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    if (indexPath.row==0) {
        cell.badegvalueLabel.alpha = 0;
        cell.contentImageView.image = [UIImage imageNamed:@"xitongxiaoxi"];
    }
    else if (indexPath.row==1)
    {
        cell.badegvalueLabel.alpha = 0;
        if ([UserAccountManager shareUserAccountManager].loginStatus) {
            cell.contentImageView.image = [UIImage imageNamed:@"zhannaixin"];
        }
        else
        {
            cell.badegvalueLabel.alpha = 0;
            cell.contentImageView.image = [UIImage imageNamed:@"wuliu"];
        }
    }
    else{
        cell.contentImageView.image = [UIImage imageNamed:@"xiaoxi"];
        cell.badegvalueLabel.alpha = 0;
    }
    cell.detialLabel.text = [LaguageControl languageWithString:self.dataArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UserAccountManager shareUserAccountManager].loginStatus){
        if (indexPath.row==0) {
            SystemMessageViewController * system = [[SystemMessageViewController alloc] init];
            [self.navigationController pushViewController:system animated:YES];
        }
        else if (indexPath.row==1){
            StationMessageViewController * station = [[StationMessageViewController alloc] init];
            [self.navigationController pushViewController:station animated:YES];
        }
//        else if (indexPath.row==2)
//        {
//            NotificationMessageViewController * notification = [[NotificationMessageViewController alloc] init];
//            notification.title = LaguageControl(@"物流信息");
//            [self.navigationController pushViewController:notification animated:YES];
//        }
        else{
            NotificationMessageViewController * notification = [[NotificationMessageViewController alloc] init];
            notification.title =LaguageControl(@"通知信息");
            [self.navigationController pushViewController:notification animated:YES];
            
            
        }
    }
    else{
        if (indexPath.row==0) {
            SystemMessageViewController * system = [[SystemMessageViewController alloc] init];
            [self.navigationController pushViewController:system animated:YES];
        }
        else if (indexPath.row==1){
            NotificationMessageViewController * notification = [[NotificationMessageViewController alloc] init];
            notification.title =LaguageControl(@"通知信息");
            [self.navigationController pushViewController:notification animated:YES];

        }

    }


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
