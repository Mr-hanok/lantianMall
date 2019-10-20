//
//  ComplaintManagerViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  投诉管理

#import "ComplaintManagerViewController.h"
#import "ComplaintManagerViewModel.h"
#import "ComplaintCell.h"
#import "ComplaintModel.h"
#import "ComplaintDetailedViewController.h"
static NSString * ComplaintCellId = @"ComplaintCell";
@interface ComplaintManagerViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,ComplaintCellDelegate>
@property (nonatomic , weak) UITableView * managerTableView;
@property (nonatomic , strong) ComplaintManagerViewModel * model;
@end
@implementation ComplaintManagerViewController
{
    ComplaintCell * currentCell;
}
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updataNewData:self.managerTableView];
    [self.header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.title = LaguageControl(@"投诉管理");
}


- (void)updateHeadView
{
    [self.model getDataCompletionHandle:^(id error) {
        [self endRefresh];
        [self.managerTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.model.dataArray.count];
        [self.managerTableView reloadData];
        [HUDManager showWarningWithError:error];
    }];
}

- (void)updateFootView
{
    [self.model getPageCompletionHandle:^(id error) {
        [HUDManager showWarningWithError:error];
        [self.managerTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.model.dataArray.count];
        [self.managerTableView reloadData];
        [self endRefresh];
    }];
}
#pragma mark tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComplaintCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintCellId];
    cell.delegate = self;
    cell.model = self.model.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComplaintDetailedViewController * controller = [[ComplaintDetailedViewController alloc] init];
    ComplaintModel * model = self.model.dataArray[indexPath.row];
    controller.complaintId = model.complaintID;
    controller.complaintModel = model;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.cancelButtonIndex == buttonIndex)
    {
        return;
    }
    // 取消投诉
    [self.model cancelComplaintWithModel:currentCell.model completionHandle:^(id error) {
        if(!error)
        {
            [HUDManager showWarningWithText:@"取消投诉成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [HUDManager showWarningWithError:error];
        }
    }];
}

- (void)complaintCancel:(ComplaintCell *)cell
{
    currentCell = cell;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:LaguageControl(@"提示") message:LaguageControl(@"是否取消投诉") delegate:self cancelButtonTitle:LaguageControl(@"取消") otherButtonTitles:LaguageControl(@"确定"), nil];
    [alert show];
    
}
#pragma mark - setter and getter
- (UITableView *)managerTableView
{
    if(!_managerTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight-[UIApplication sharedApplication].statusBarFrame.size.height-44) style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [[UIView alloc]init];
        tableview.separatorColor = [UIColor clearColor];
        tableview.backgroundColor = [UIColor clearColor];
        [tableview registerClass:[ComplaintCell class] forCellReuseIdentifier:ComplaintCellId];
        [self.view addSubview:tableview];
        _managerTableView = tableview;
//        [_managerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.equalTo(self.view);
//        }];
    }
    return _managerTableView;
}
- (ComplaintManagerViewModel *)model
{
    if(!_model)
    {
        _model = [[ComplaintManagerViewModel alloc] init];
    }
    return _model;
}
@end
