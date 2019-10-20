//
//  PromotionGoodsViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  促销商品

#import "PromotionGoodsViewController.h"
#import "SDCycleScrollView.h"
#import "PromotionGoodsViewModel.h"
#import "PromotionGoodsTableViewCell.h"
#import "GoodsDetialViewController.h"
#import "PromotionGoodsModel.h"
#import "ShufflingManager.h"
static NSString * PromotionGoodsTableViewCellId = @"PromotionGoodsTableViewCell";
@interface PromotionGoodsViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,PromotionGoodsTableViewCellDelegate>
@property (nonatomic , strong) UIView * searchView;
@property (nonatomic , strong) SDCycleScrollView * scrollView;
@property (nonatomic , weak) UITableView * goodsTableView;
@property (nonatomic, strong) UIImageView *headImageView;
@end
@implementation PromotionGoodsViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.titleView = self.searchView;
//    self.title = @"吃货头条";
    [self updataNewData:self.goodsTableView];
    [self.model getPromotionGoodsWithID:_promotionID Complete:^(id error) {
        if (self.model.scrollIconArray.count == 1) {
            PromotionGoodsScrollModel *scrollmodel = [self.model.scrollIconArray firstObject];
           NSString *urlStr =  scrollmodel.img_url?:@"";
            NSURL *url = [NSURL URLWithString:urlStr];
            if (!_headImageView) {
                _headImageView = [[UIImageView alloc]init];
                [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@""]];
            }
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            BOOL existBool = [manager diskImageExistsForURL:[NSURL URLWithString:urlStr]];//判断是否有缓存
            UIImage * image;
            
            if (existBool) {
                
                image = [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
            }else{
                
                NSData *data = [NSData dataWithContentsOfURL:url];
                image = [UIImage imageWithData:data];
                
            }
            _headImageView.frame = CGRectMake(0, 0, KScreenBoundWidth,             image.size.height / image.size.width * KScreenBoundWidth);
            self.goodsTableView.tableHeaderView = self.headImageView;

        }else{
            if (self.model.scrollIconArray.count != 0) {
                self.scrollView.imageURLStringsGroup = [self.model.scrollIconArray valueForKeyPath:@"img_url"];
                self.goodsTableView.tableHeaderView = self.scrollView;
            }

        }
        [self.goodsTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.model.dataArray.count];
        [self.goodsTableView reloadData];
       [HUDManager showWarningWithError:error];
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)updateFootView{
    
    [self.model getPromotionGoodsPageInfoComplete:^(id error) {
        [self.goodsTableView reloadData];
        [self endRefresh];

        if(error)
        {
            if([error isKindOfClass:[NSString class]])
            {
                if([error isEqualToString:@"已经加载全部"])
                {
                    [self.footer endRefreshingWithNoMoreData];
                }else
                {
                    [HUDManager showWarningWithError:error];

                }
            }else
            {
                [HUDManager showWarningWithError:error];
            }
        }
    }];
}
- (void)updateHeadView
{
    [self.goodsTableView.mj_footer resetNoMoreData];
    [self.model getHeaderGoodsInfoCompleted:^(id error) {
        [self.goodsTableView reloadData];
        [self endRefresh];
        [HUDManager showWarningWithError:error];
    }];
}
#pragma mark - tableview Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PromotionGoodsTableViewCellId];
    cell.delegate = self;
    cell.model = self.model.dataArray[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionGoodsModel * model = self.model.dataArray[indexPath.row];
    GoodsDetialViewController * view = [GoodsDetialViewController new];
    view.goodsModelID = [NSString stringWithFormat:@"%ld",(long)model.goodsID];
    [self.navigationController pushViewController:view animated:YES];
}
/**
 *  点击立即抢购
 *
 *  @param cell <#cell description#>
 */
- (void)promotionGoodsCell:(PromotionGoodsTableViewCell *)cell
{
    PromotionGoodsModel * model = cell.model;
    GoodsDetialViewController * view = [GoodsDetialViewController new];
    view.goodsModelID = [NSString stringWithFormat:@"%ld",(long)model.goodsID];
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark - SearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   [self.model searchPromotionGoodsWithSearchContent:searchText complete:^(id error) {
       [HUDManager showWarningWithError:error];
       [self.goodsTableView reloadData];
   }];
}
#pragma mark - 轮播图代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    /**
     *  轮播图跳转
     */
     PromotionGoodsScrollModel * model = self.model.scrollIconArray[index];
     if ([ShufflingManager ShufflingManagerPushType:model.type withValue:model.value]) {
         NSString *tempValue = [model.type isEqualToString:@""] ? model.ad_url:model.value;

        UIViewController * controller = [ShufflingManager ShufflingManagerPushType:model.type withValue:tempValue];
        [self.navigationController pushViewController:controller animated:YES];
    }
   
}

- (UIView *)searchView
{
    if(!_searchView)
    {
        UIView * search = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width * 0.618f, 30)];
        UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:search.frame];
        [search addSubview:searchBar];
        UIColor * color = [UIColor colorWithString:@"#C90C1E"];
        searchBar.layer.masksToBounds = YES;
        searchBar.layer.borderWidth = 8;
        search.backgroundColor = color;
        searchBar.backgroundColor = color;
        searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
        searchBar.layer.cornerRadius = 3;
        searchBar.placeholder = LaguageControl(@"搜索");
        searchBar.delegate = self;
        _searchView = search;
    }
    return _searchView;
}
- (UITableView *)goodsTableView
{
    if(!_goodsTableView)
    {
        CGRect tableviewBounds = self.view.bounds;
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableviewBounds.size.width, tableviewBounds.size.height + self.tabBarController.tabBar.frame.size.height)];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.separatorColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.estimatedRowHeight = 100;
        [tableview registerClass:[PromotionGoodsTableViewCell class] forCellReuseIdentifier:PromotionGoodsTableViewCellId];
        [self.view addSubview:tableview];
        _goodsTableView = tableview;
        [_goodsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _goodsTableView;
}
- (SDCycleScrollView *)scrollView
{
    if(!_scrollView)
    {
        SDCycleScrollView * view = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScaleHeight(150))];
        view.autoScrollTimeInterval = 5.0f;
        view.backgroundColor = [UIColor whiteColor];
        view.placeholderImage = [UIImage imageNamed:@"defaultImgForGoods"];
        view.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        view.delegate = self;
        _scrollView = view;
    }
    return _scrollView;
}
- (PromotionGoodsViewModel *)model
{
    if(!_model)
    {
        _model = [[PromotionGoodsViewModel alloc] init];
    }
    return _model;
}
@end
