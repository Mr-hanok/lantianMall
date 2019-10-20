//
//  SearchStationViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SearchStationViewController.h"
#import "StationMessageTableViewCell.h"

#import "StationMessageChatViewController.h"
#import "NewStationMessageModel.h"

static NSString * cellIdentifier = @"StationMessageTableViewCell";

@interface SearchStationViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
/** 数组 */
@property(strong,nonatomic) NSMutableArray * dataArray;
/** 起始 */
@property(assign,nonatomic) NSInteger  begin;
/** 搜索结果 */
@property(strong,nonatomic) NSString * searchResult;

@end

@implementation SearchStationViewController


{
    UISearchBar * searcher;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)]];
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;
    [self updataNewData:self.searchResultTableView];
    self.begin =1;
    [self.searchResultTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];
    
    searcher =[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, KScreenBoundWidth-120, 20)];
    searcher.delegate = self;
    searcher.placeholder =LaguageControl(@"搜索");
    self.navigationItem.titleView = searcher;
//  [searcher becomeFirstResponder];
    if (@available(iOS 11.0, *)) {
        [[searcher.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
    }


    // Do any additional setup after loading the view from its nib.
}
-(void)updateHeadView{
    self.begin =1;
    [self NetWork];
}
-(void)updateFootView
{
    self.begin ++;
    [self NetWork];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)NetWork
{

    NSString * begin =[NSString stringWithFormat:@"%ld",(long)self.begin];
    if (!self.searchResult)
    {
        self.searchResult = @"";
    }
    NSDictionary * dic = @{@"user_id":kUserId,
                           @"currentPage":begin,
                           @"userName":self.searchResult,
                           };
    [NetWork PostNetWorkWithUrl:@"/system/message_search" with:dic successBlock:^(NSDictionary *dic)
    {
        [self endRefresh];
        if ([dic[@"status"] boolValue])
        {
            if (self.begin==1) {
                [self.dataArray removeAllObjects];
            }
            NSArray *array =[NewStationMessageModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            [self.dataArray addObjectsFromArray:array];
            [self.searchResultTableView.mj_footer endRefreshingWithNoMoreData];
            [self.searchResultTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];
            [self.searchResultTableView reloadData];
        }
    } errorBlock:^(NSString *error) {
        
    }];
    
}
-(void)backToPresentViewController{
    [searcher resignFirstResponder];
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1.0f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    //    transition.type = @"cube";
//    transition.type = kCATransitionFade;
//    transition.subtype = kCATransitionFromTop;
//    transition.delegate = self;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES; 
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
        self.begin=1;
        self.searchResult = searchText;
        [self NetWork];
}

#pragma mark--UITableViewDelegate&&UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StationMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    NewStationMessageModel * model = self.dataArray[indexPath.row];
    [cell loadModel:model with:indexPath show:nil];
    [cell editCell:NO];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NewStationMessageModel * model = self.dataArray[indexPath.row];
    StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
    view.title = [kUserId isEqualToString:model.fromUserId]?model.toUserName:model.fromUserName;
    view.toUserID = [kUserId isEqualToString:model.fromUserId]?model.toUserId:model.fromUserId;
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
