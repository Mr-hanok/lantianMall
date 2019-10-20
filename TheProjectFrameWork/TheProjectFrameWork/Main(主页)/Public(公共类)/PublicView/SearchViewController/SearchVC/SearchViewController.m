//
//  SearchViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "searchHeadView.h"
#import "SearchStoreViewController.h"
#import "ClassGoodsModel.h"
#import "GoodsDetialViewController.h"
#import "IQKeyboardManager.h"

static NSString * cellIdenfier =@"SearchTableViewCell";

static NSString * HeadIdenfier =@"searchHeadView";

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

/** 搜索TableView */
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
/** 数组元素 */
@property(strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];

    self.navigationTitleview.searchBar.delegate = self;
    

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}
/** 加载navigationBar点击事件 */
-(void)loadRightnavigabarTouchEvent
{
//    self.tabBarController.tabBar.hidden = YES;
    [self.navigationTitleview.rightButton setBadgeBGColor:[UIColor blackColor]];
    [self.navigationTitleview.rightButton addTarget:self action:@selector(canCelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationTitleview.searchBar becomeFirstResponder];
    [self.navigationTitleview.rightButton setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
    
}
-(void)canCelButton{
    [self backToPresentViewController];
}

-(void)backToPresentViewController{
    [self.navigationTitleview.searchBar resignFirstResponder];
    [super backToPresentViewController];
}


/**
 *  搜索接口
 *
 *  @param string
 */

-(void)SearchNetWorkwithString:(NSString*)string
{
    string = [NSString encodeString:string];
    [self.searchTableView reloadData];
    NSDictionary * dic = @{@"goods_name":string};
    [NetWork PostNetWorkWithUrl:@"/goods/searchGoodsByParams" with:dic successBlock:^(NSDictionary *dic)
    {
        [self.dataArray removeAllObjects];
        if ([dic[@"status"] boolValue])
        {
            NSArray *array =[ClassGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.dataArray addObjectsFromArray:array];
        }
        [self.searchTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];
        [self.searchTableView reloadData];
    }
        errorBlock:^(NSString *error) {
    }];
    
}
#pragma mark --UITableViewDelegate&&UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassGoodsModel * model = self.dataArray[indexPath.row];
    
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdenfier owner:nil options:nil] firstObject];
    }
    cell.searchResultLabel.text = model.classModelName ;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.navigationTitleview.searchBar.text.length == 0)
    {
        return nil;
    }
    searchHeadView * view= [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdenfier];
    if (!view)
    {
        [tableView registerNib:[UINib nibWithNibName:HeadIdenfier bundle:nil] forHeaderFooterViewReuseIdentifier:HeadIdenfier];
        view= [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdenfier];
    }
    view.searchTextLabel.text = [NSString stringWithFormat:@"%@“%@”%@", LaguageControl(@"搜索"),self.navigationTitleview.searchBar.text,LaguageControl(@"店铺")];
    [view.selectedButton addTarget:self action:@selector(SearchStore) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassGoodsModel * model = self.dataArray[indexPath.row];
    GoodsDetialViewController * view = [GoodsDetialViewController new];
    view.goodsModelID = model.classModelID;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark --UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length)
    {
        [self SearchNetWorkwithString:searchText];
    }
    else{
        [self.dataArray removeAllObjects];
        [self.searchTableView reloadData];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)SearchStore
{
    [self.navigationTitleview.searchBar resignFirstResponder];
    SearchStoreViewController *view = [SearchStoreViewController new];
    view.result = self.navigationTitleview.searchBar.text;
    [self.navigationController pushViewController:view animated:YES];
}





@end
