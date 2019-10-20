//
//  SearchStoreViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SearchStoreViewController.h"
#import "SerachStoreTableViewCell.h"
#import "PayAttentionShopViewController.h"
#import "SearchModel.h"
#import "GoodsDetialViewController.h"

static NSString * cellIdentifier = @"SerachStoreTableViewCell";
@interface SearchStoreViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SerachStoreTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation SearchStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationTitleview.searchBar.delegate = self;
    self.dataArray = [NSMutableArray array];
    [self StoreNetWork];
    // Do any additional setup after loading the view from its nib.
}
-(void)backToPresentViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)StoreNetWork
{
    NSDictionary * dic = @{@"store_name":self.result,@"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@""};
    [NetWork PostNetWorkWithUrl:@"/store_class/searchStoreByParams" with:dic successBlock:^(NSDictionary *dic)
    {
        [self.dataArray removeAllObjects];
        if ([dic[@"status"] boolValue]) {
            self.dataArray = [SearchModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
    }
    else{
        [HUDManager showWarningWithText:dic[@"message"]];
    }
    [self.resultTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];
    [self.resultTableView reloadData];
    } errorBlock:^(NSString *error)
     {
        
    }];
    
}

/** 加载navigationBar点击事件 */
-(void)loadRightnavigabarTouchEvent
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationTitleview.searchBar.placeholder = self.result;
    [self.navigationTitleview.rightButton setBadgeBGColor:[UIColor blackColor]];
    [self.navigationTitleview.rightButton setTitle:@"" forState:UIControlStateNormal];
}



#pragma mark --UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchModel * model = self.dataArray[indexPath.section];
    SerachStoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    [cell loadData:model WithArray:model.goodsArray andIndex:indexPath];
    cell.delegate = self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
#pragma mark -- SerachStoreTableViewCellDelegate、
/**
 *  点击某个物品
 *
 *  @param index index description
 */

- (void)serachStoreTableVIewCell:(SerachStoreTableViewCell *)cell goods_id:(NSString *)goods_id
{
    GoodsDetialViewController * detail = [[GoodsDetialViewController alloc] init];
    detail.goodsModelID = goods_id;
    
    [self.navigationController pushViewController:detail animated:YES];
}
/**
 *  进入某间店铺
 *
 *  @param section <#section description#>
 */
-(void)SerachStoreTableViewCellComeToStore:(NSInteger)section
{
    
    SearchModel * model = self.dataArray[section];
    
    PayAttentionShopViewController * view = [PayAttentionShopViewController new];
    view.storeID = model.storeID;
    [self.navigationController pushViewController:view animated:YES];
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
