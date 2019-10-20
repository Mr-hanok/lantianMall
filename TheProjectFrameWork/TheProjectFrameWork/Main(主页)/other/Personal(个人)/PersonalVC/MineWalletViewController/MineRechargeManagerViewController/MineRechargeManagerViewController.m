//
//  MineRechargeManagerViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  充值管理

#import "MineRechargeManagerViewController.h"
#import "RechargeManagerCell.h"
#import "RechargeManagerModel.h"
#import "MineRechargeManagerViewModel.h"
static NSString * RechargeManagerCellId = @"RechargeManagerCell";
@interface MineRechargeManagerViewController ()<UITableViewDelegate,UITableViewDataSource,RechargeEditViewDelegate>
@property (nonatomic , weak) UITableView * rechargeTableView;


@property (nonatomic , strong) NSMutableArray * indexArray;

@property (nonatomic , strong) NSMutableArray * contentArray; ///< 选中内容
@property (nonatomic , weak) UIBarButtonItem * rightItem;

@property (nonatomic , weak) RechargeEditView * editView;
@property (nonatomic , strong) MineRechargeManagerViewModel * model;
@end
@implementation MineRechargeManagerViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.model getMineRechargeManagerWithRole:_role completeHandle:^(id error) {
        [self.rechargeTableView reloadData];
        [HUDManager showWarningWithError:error];
    }];
    [self.rechargeTableView reloadData];
    [self updataFooter:self.rechargeTableView];
}
- (void)updateFootView
{
    [self.model getMineRechargeManagerPageCompleteHandle:^(id error) {
        [self endRefresh];
        [HUDManager showWarningWithError:error];
        [self.rechargeTableView reloadData];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"充值管理");
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:RechargeManagerCellId];
    cell.model = self.model.dataArray[indexPath.row];
    return cell;
}
/**
 *  允许编辑
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}



#pragma mark - event respond
/**
 *  点击编辑
 */
- (void)edit:(UIBarButtonItem *)sender
{
    self.navigationItem.rightBarButtonItem = nil;
    __weak typeof(self) weakSelf = self;
    [self.editView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).priority(700);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.rechargeTableView setEditing:!_rechargeTableView.editing animated:YES];
    
}
#pragma mark - other Delegate

/**
 *  取消
 */
- (void)rechargeEditCancel
{
    [self removeEditView];
    [_rechargeTableView setEditing:!_rechargeTableView.editing animated:YES];
    [_contentArray removeAllObjects];
    [_indexArray removeAllObjects];
    self.rightItem.style = UIBarButtonItemStylePlain;

}
#pragma mark private
/**
 *  移除编辑view
 */
- (void)removeEditView
{
    __weak typeof(self) weakSelf = self;
    [self.editView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_bottom).priority(900);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_editView removeFromSuperview];
    }];
}
#pragma mark - setter and getter
- (UITableView *)rechargeTableView
{
    if(!_rechargeTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        tableview.rowHeight = kScaleHeight(80);
        [tableview registerClass:[RechargeManagerCell class] forCellReuseIdentifier:RechargeManagerCellId];
        [self.view addSubview:tableview];
        _rechargeTableView = tableview;
    }
    return _rechargeTableView;
}

- (NSMutableArray *)contentArray
{
    if(!_contentArray)
    {
    _contentArray = [@[] mutableCopy];
    }
    return _contentArray;
}
- (NSMutableArray *)indexArray
{
    if(!_indexArray)
    {
        _indexArray = [@[] mutableCopy];
        
    }
    return _indexArray;
}
- (UIBarButtonItem *)rightItem
{
    if(!_rightItem)
    {
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:[LaguageControl languageWithString:@"编辑"] style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
        item.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = item;

        _rightItem = item;
    }
    return _rightItem;
}
- (RechargeEditView *)editView
{
    
    if(!_editView)
    {
        RechargeEditView * view = [[RechargeEditView alloc] init];
        [self.view addSubview:view];
        view.delegate = self;
        __weak typeof(self) weakSelf = self;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kScaleHeight(45));
            make.left.right.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view.mas_bottom).priority(500);
        }];
        [self.view layoutIfNeeded];
        _editView = view;
    }
    return _editView;
}
- (MineRechargeManagerViewModel *)model
{
    if(!_model)
    {
     _model = [[MineRechargeManagerViewModel alloc] init];
    }
    return _model;
}
@end


@interface RechargeEditView ()
{
    UIButton * cancel;
    UIButton * delete;
}
@end

@implementation RechargeEditView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithString:@"#e6e6e6"];
        cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:cancel];
        [self addSubview:delete];
        __weak typeof(self) weakSelf = self;
        [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(weakSelf);
            make.right.equalTo(delete.mas_left);
        }];
        [delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(weakSelf);
            make.width.equalTo(cancel.mas_width);
        }];
        [cancel setTitle:[LaguageControl languageWithString:@"取消"] forState:UIControlStateNormal];
        [delete setTitle:[NSString stringWithFormat:@"%@(0)",[LaguageControl languageWithString:@"删除"]] forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor colorWithString:@"#DA2A2E"] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [delete addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)cancel
{
    if ([_delegate respondsToSelector:@selector(rechargeEditCancel)]) {
        [_delegate rechargeEditCancel];
    }
}
- (void)delete
{
    if ([_delegate respondsToSelector:@selector(rechargeEditDelete)])
    {
        [_delegate rechargeEditDelete];
    }
}

- (void)setCount:(NSInteger)count
{
    _count = count;
    [delete setTitle:[NSString stringWithFormat:@"%@(%ld)",[LaguageControl languageWithString:@"删除"],(long)count] forState:UIControlStateNormal];
}

@end
