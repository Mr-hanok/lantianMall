//
//  WalletDetailsViewController.m
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  钱包详情

#import "WalletDetailsViewController.h"
#import "WalletDetailsCell.h"
#import "WalletDetailsTitleView.h"
static NSString * WalletDetailsCellId = @"WalletDetailsCell";
@interface WalletDetailsViewController ()<UITableViewDelegate , UITableViewDataSource,WalletDetailsUnfoldViewDelegate>
@property (nonatomic , weak) UITableView * detailsTableView;
@property (nonatomic , weak) WalletDetailsUnfoldView * unfoldView;
@property (nonatomic , strong) WalletDetailsTitleView * titleView;
@end

@implementation WalletDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleView addTarget:self action:@selector(detailsClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailsTableView reloadData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
#pragma mark tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:WalletDetailsCellId];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
#pragma mark - other delegate
- (void)walletdetaileTitleFrom:(NSInteger)from to:(NSInteger)to
{
    NSLog(@"from : %ld , to : %ld",(long)from,(long)to);
}
#pragma mark - event respond
/**
 *  详情展开
 */
- (void)detailsClickWithButton:(WalletDetailsTitleView *)sender
{
    sender.selected = !sender.selected;
    if(_unfoldView)
    {
        [self.unfoldView fold];
        return;
    }
    [self.unfoldView unfold];

}

#pragma mark - setter and getter
- (UITableView *)detailsTableView
{
    if(!_detailsTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.separatorColor = [UIColor clearColor];
        tableview.tableFooterView = [UIView new];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview registerClass:[WalletDetailsCell class] forCellReuseIdentifier:WalletDetailsCellId];
        tableview.rowHeight = kScaleHeight(70);
        tableview.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tableview];
        _detailsTableView = tableview;
    }
    return _detailsTableView;
}
- (WalletDetailsTitleView *)titleView
{
    if(!_titleView)
    {
        WalletDetailsTitleView * titleView = [[WalletDetailsTitleView alloc] initWithFrame:(CGRect){0, 0, 60, 40}];
        [titleView setTitle:LaguageControl(@"详情") forState:UIControlStateNormal];
        [titleView setImage:[UIImage imageNamed:@"sanjiao"] forState:UIControlStateNormal];
        self.navigationItem.titleView = titleView;
        _titleView = titleView;
    }
    return _titleView;
}
- (WalletDetailsUnfoldView *)unfoldView
{
    if(!_unfoldView)
    {
        WalletDetailsUnfoldView * view = [[WalletDetailsUnfoldView alloc] initWithTitles:@[@"全部",@"支出",@"收入"]];
        view.frame = (CGRect){0, 0, self.view.bounds.size.width, self.view.bounds.size.height};
        [self.view addSubview:view];
        view.delegate = self;
        _unfoldView = view;
    }
    [self.view layoutIfNeeded];
    return _unfoldView;
}
@end
