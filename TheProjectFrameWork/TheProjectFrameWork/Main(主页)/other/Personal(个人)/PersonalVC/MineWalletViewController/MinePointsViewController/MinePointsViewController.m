//
//  MinePointsViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  我的积分

#import "MinePointsViewController.h"
#import "WalletValueCell.h"
#import "MineWalletCell.h"
static NSString * WalletValueCellId = @"WalletValueCell";
static NSString * MineWalletCellId = @"MineWalletCell";
@interface MinePointsViewController ()<UITableViewDelegate,UITableViewDataSource,WalletValueCellDelegate>
@property (nonatomic , weak) UITableView * pointsTableView;

@end
@implementation MinePointsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pointsTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"我的积分"];
}
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row)
    {
        MineWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:MineWalletCellId];
        cell.image = [UIImage imageNamed:@"duihuantu"];
        cell.title = @"兑换记录";
        return cell;
    }
    WalletValueCell * cell = [tableView dequeueReusableCellWithIdentifier:WalletValueCellId];
    [cell loadPointsTitle:@"积分数量" value:[[UserAccountManager shareUserAccountManager].userModel.integral integerValue]];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row)
    {
        return kScaleHeight(60);
    }
    return kScaleHeight(150);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row)
    {
    }
}
#pragma mark - other Delegate
/**
 *  积分商城
 */
- (void)walletValuePointsShop
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IntegralMall" bundle:nil];
//    IntegralMallHomeViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"IntegralMallHomeViewController"];
//    vc.isNotFromRoot = YES;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    [self.tabBarController setSelectedIndex:2];
}
/**积分明细*/
-(void)clickIntegralDetailBtn{
    [self pushWithVCClassName:@"IntegralLogDetailViewController" properties:@{}];
}
#pragma mark - setter and getter
- (UITableView *)pointsTableView
{
    if(!_pointsTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        [tableview registerClass:[WalletValueCell class] forCellReuseIdentifier:WalletValueCellId];
        [tableview registerClass:[MineWalletCell class] forCellReuseIdentifier:MineWalletCellId];
        [self.view addSubview:tableview];
        _pointsTableView = tableview;
    }
    return _pointsTableView;
}
@end
