//
//  ClassificationViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassificationViewController.h"
#import "ClassficationMenuTableViewCell.h"
#import "ClassficationLeftTableViewCell.h"
#import "GoodsDetialViewController.h"
#import "HomeClassModel.h"
#import "ClassGoodsViewController.h"

/** MenuCell  */
static NSString * cellIdentifier = @"ClassficationMenuTableViewCell";
/** DefaultItem */
static NSString * rightTableViewCellIdentifier = @"ClassficationLeftTableViewCell";

@interface ClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 菜单列表tableView */
@property (weak, nonatomic) IBOutlet UITableView *classficationMenutableView;
@property(strong,nonatomic) NSMutableArray * dataArray;

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (nonatomic, assign) NSUInteger currentSelectedRow;
@property (nonatomic, assign) BOOL isRequestedFromLeft;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTabWidth;

@end

@implementation ClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.title = @"分类";
//    [self reloadView];
    if (KSCREEN_WIDTH == 320) {
        self.leftTabWidth.constant = 120*320/375.0;
    }
    self.rightTableView.tag = 10002;
    self.rightTableView.estimatedRowHeight = KSCREEN_HEIGHT;
    self.classficationMenutableView.tag = 10001;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[SDImageCache sharedImageCache] setShouldDecompressImages:NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    if (!self.dataArray.count) {
        [self NetWork];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[SDImageCache sharedImageCache] setShouldDecompressImages:YES];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:YES];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}
#pragma mark --UITableViewDelegate&&UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 10001) {
        return self.dataArray.count;
    }else{
        return self.dataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 10001) {
        ClassficationMenuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            [self.classficationMenutableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            UIView * view = [[UIView alloc]init];
            view.backgroundColor =  [UIColor whiteColor];
            cell.selectedBackgroundView = view;
            cell.menuContentLabel.highlightedTextColor = kNavigationColor;
            [cell.contentView bringSubviewToFront:cell.markView];
            
        }
        UIView * view = [[UIView alloc]init];
        view.backgroundColor =  [UIColor whiteColor];
        cell.selectedBackgroundView = view;

        HomeClassModel *model = self.dataArray[indexPath.row];
        cell.menuContentLabel.text = model.goodsName ?: @"";
        cell.markView.backgroundColor = [UIColor clearColor];
        
        if (self.currentSelectedRow == indexPath.row) {
            cell.selected = YES;
            cell.markView.backgroundColor = kNavigationColor;
            cell.menuContentLabel.font = [UIFont boldSystemFontOfSize:16.5];
            [cell.menuContentLabel setTextColor:kNavigationColor];
        }else{
            cell.selected = NO;
            cell.markView.backgroundColor = [UIColor clearColor];
            cell.menuContentLabel.font = [UIFont boldSystemFontOfSize:14.5];
            [cell.menuContentLabel setTextColor:[UIColor colorWithString:@"#555555"]];
        }
        
        return cell;
    }else if (tableView.tag == 10002) {
        ClassficationLeftTableViewCell * cell = [self.rightTableView dequeueReusableCellWithIdentifier:rightTableViewCellIdentifier];
        if (!cell) {
            [self.rightTableView registerNib:[UINib nibWithNibName:rightTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:rightTableViewCellIdentifier];
            cell = [self.rightTableView dequeueReusableCellWithIdentifier:rightTableViewCellIdentifier];
        }
        HomeClassModel *model = self.dataArray[indexPath.row];
        [cell configCellWithModel:model];
        cell.vc = self;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _rightTableView) {
        return;
    }
    CGPoint offset = _rightTableView.contentOffset;
    [_rightTableView setContentOffset:offset animated:NO];

    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    self.currentSelectedRow = indexPath.row;
    self.isRequestedFromLeft = YES;
    ClassficationMenuTableViewCell *cell = (ClassficationMenuTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    if (cell.selected) {
        cell.markView.backgroundColor =kNavigationColor;
        cell.menuContentLabel.font = [UIFont boldSystemFontOfSize:16.5];
        [cell.menuContentLabel setTextColor:kNavigationColor];

    }else{
        cell.markView.backgroundColor = [UIColor clearColor];
        cell.menuContentLabel.font = [UIFont boldSystemFontOfSize:14.5];
        [cell.menuContentLabel setTextColor:[UIColor colorWithString:@"#555555"]];

    }
    [self.rightTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _rightTableView) {
        return;
    }
    ClassficationMenuTableViewCell *cell = (ClassficationMenuTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    cell.markView.backgroundColor = [UIColor clearColor];
    [cell.menuContentLabel setTextColor:[UIColor colorWithString:@"#555555"]];
    cell.menuContentLabel.font = [UIFont boldSystemFontOfSize:14.5];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _classficationMenutableView) {
        return  66;
    }else{
        HomeClassModel *model = self.dataArray[indexPath.row];
        return [model configHeight];
    }
}

#pragma mark -scrollviewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isRequestedFromLeft) {
        return;
    }
    if (scrollView == self.rightTableView) {
        if (self.currentSelectedRow !=self.rightTableView.indexPathsForVisibleRows.firstObject.row) {
            [self congitCellWithIsFirst:YES];
        }
        /**NSLog(@"您已经滑到底部了");*/
        CGFloat height = scrollView.frame.size.height;
        CGFloat contentYoffset = scrollView.contentOffset.y;
        CGFloat distance = scrollView.contentSize.height - height;
        if (distance- contentYoffset<=0) {
            [self congitCellWithIsFirst:NO];
        }
    }
}
- (void)congitCellWithIsFirst:(BOOL)isfirst{
    /**先取消以前左边a颜色*/
    ClassficationMenuTableViewCell *lastcell = (ClassficationMenuTableViewCell *) [self.classficationMenutableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentSelectedRow inSection:0]];
    lastcell.markView.backgroundColor = [UIColor clearColor];
    lastcell.markView.backgroundColor = [UIColor clearColor];
    [lastcell.menuContentLabel setTextColor:[UIColor colorWithString:@"#555555"]];
    lastcell.menuContentLabel.font = [UIFont boldSystemFontOfSize:14.5];
    
    if (isfirst) {
        self.currentSelectedRow = self.rightTableView.indexPathsForVisibleRows.firstObject.row;
    }else{
        self.currentSelectedRow = self.rightTableView.indexPathsForVisibleRows.lastObject.row;
    }
    NSIndexPath * indexPath= [NSIndexPath indexPathForRow:self.currentSelectedRow inSection:0];
    
    [self.classficationMenutableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    ClassficationMenuTableViewCell *cell = (ClassficationMenuTableViewCell *) [self.classficationMenutableView cellForRowAtIndexPath:indexPath];
    if (cell.selected) {
        cell.markView.backgroundColor = kNavigationColor;
        cell.menuContentLabel.font = [UIFont boldSystemFontOfSize:16.5];
        [cell.menuContentLabel setTextColor:kNavigationColor];

    }else{
        cell.markView.backgroundColor = [UIColor clearColor];
        cell.menuContentLabel.font = [UIFont boldSystemFontOfSize:14.5];
        [cell.menuContentLabel setTextColor:[UIColor colorWithString:@"#555555"]];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.rightTableView) {
        self.isRequestedFromLeft = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.rightTableView) {
        self.isRequestedFromLeft = NO;
    }}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.rightTableView) {
        self.isRequestedFromLeft = NO;
    }
    
}

#pragma mark--network

-(void)NetWork
{
    [HUDManager showLoadingHUDView:self.view];
    WeakSelf(self)
    [NetWork PostNetWorkWithUrl:@"/mall_category" with:nil successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        if ([dic[@"status"] boolValue])
        {
            [dic ds_writefiletohomePath:@"/mall_category"];
            [weakSelf reloadView];
        }
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
        [weakSelf reloadView];
        
    }];
}

-(void)reloadView
{
    [self.dataArray removeAllObjects];
    NSDictionary * dic = [NSDictionary ds_readfiletohomePath:@"/mall_category"];
    NSMutableArray * array =  [HomeClassModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"categroy"]];
    
    if (array.count)
    {
        self.dataArray = array;
        for (HomeClassModel *model in self.dataArray) {
           model.height = [model configHeight];
        }
    }else{
        [self NetWork];
        return;
    }
    [self.rightTableView reloadData];
    [self.classficationMenutableView reloadData];
    
    if (self.dataArray.count) {
        [self.classficationMenutableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        ClassficationMenuTableViewCell *cell = (ClassficationMenuTableViewCell *) [self.classficationMenutableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if (cell.selected) {
            cell.markView.backgroundColor = kNavigationColor;
            [cell.menuContentLabel setTextColor:kNavigationColor];
        }else{
            cell.markView.backgroundColor = [UIColor clearColor];
            [cell.menuContentLabel setTextColor:[UIColor colorWithString:@"#555555"]];

        }
    }
}


@end
