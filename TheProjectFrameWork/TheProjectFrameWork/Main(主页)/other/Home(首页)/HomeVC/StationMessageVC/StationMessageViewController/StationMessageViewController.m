//
//  StationMessageViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "StationMessageViewController.h"
#import "StationMessageTableViewCell.h"
#import "StationMessageChatViewController.h"
#import "SearchStationViewController.h"
#import "NewStationMessageModel.h"
//#import "StationSearchViewController.h"
static NSString * cellIdentifier = @"StationMessageTableViewCell";

@interface StationMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,StationMessageTableViewCellDelegate>
/** 站内信 */
@property (weak, nonatomic) IBOutlet UITableView *stationMessageTableView;
/** 站内信搜索 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIView *deleteView;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
/** 删除数组 */
@property(strong,nonatomic) NSMutableArray * selectedArray;

/** 数组 */
@property(strong,nonatomic) NSMutableArray * dataArray;

/** 起始页 */
@property(assign,nonatomic) NSInteger begin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceValue;

@end

@implementation StationMessageViewController
{
    BOOL isEditing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.begin = 1;
    self.title =[LaguageControl languageWithString: @"站内信息"];
    self.dataArray = [NSMutableArray array];
    self.searchBar.delegate = self;
    [self updataNewData:self.stationMessageTableView];
    [self loadNavBarButton];
    [self loadLeftnavigabarTouchEvent];
    self.selectedArray = [NSMutableArray array];
    self.searchBar.placeholder = LaguageControl(@"搜索");
    UIBarButtonItem * editBar = [[UIBarButtonItem alloc] initWithTitle:[LaguageControl languageWithString:@"编辑"] style:UIBarButtonItemStylePlain target:self action:@selector(editBarButtom)];
    [editBar setTintColor:kIsChiHuoApp ? kTextDeepDarkColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItems = @[editBar];
    [self.deleteButton setTitle:LaguageControl(@"删除") forState:UIControlStateNormal];
    [self.cancelButton  setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
    isEditing = NO;
    self.bottomSpaceValue.constant = -50.f;
    [self NetWork];
    // Do any additional setup after loading the view from its nib.
}
-(void)updateHeadView{
    self.begin=1;
    [self NetWork];
}
-(void)updateFootView{
    self.begin++;
    [self NetWork];
}
-(void)NetWork
{
    [self.selectedArray removeAllObjects];
    [HUDManager showLoadingHUDView:self.view];
    NSString  *begin = [NSString stringWithFormat:@"%i",self.begin];
    NSDictionary * dic = @{@"fromusername":kUserId,
                           @"currentPage":begin,
                           @"orderBy":@"addTime",
                           @"orderType":@"desc"};
    [NetWork PostNetWorkWithUrl:@"/system/newMessageList" with:dic successBlock:^(NSDictionary *dic) {
        [self endRefresh];
        [HUDManager hideHUDView];
        if (self.begin==1)
        {
            [self.dataArray removeAllObjects];
        }
        if ([dic[@"status"] boolValue])
        {
            if ([dic[@"data"] count])
            {
                NSArray * array = [NewStationMessageModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                int i;
                
                for(i=0;i<array.count;i++)
                    
                {
                    
                    if(i==0)
                        
                    {
                        
                        [arr addObject:array[i]];
                        
                    }else
                        
                    {
                        
                        int j=0;
                        
                        for(j=0;j<arr.count;j++)
                            
                        {
                            
                            NewStationMessageModel *dic1=arr[j];
                            
                            NewStationMessageModel *dic2=array[i];
                            
                            
                            
                            if([dic1.fromUserId isEqualToString:dic2.fromUserId] &&[dic1.toUserId isEqualToString:dic2.toUserId])
                                
                            {
                                
                                break;
                                
                            }
                            
                            
                            
                        }
                        
                        if(j==arr.count)
                            
                        {
                            
                            [arr addObject:array[i]];
                            
                        }  
                        
                    }  
                    
                }
                if (arr.count <10) {
                    [self.stationMessageTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.dataArray addObjectsFromArray:arr];
                
            }
        }
        
        [self.stationMessageTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];
        [self.stationMessageTableView reloadData];
        
        if (isEditing) {
            self.bottomSpaceValue.constant = 0.f;
        }else{
            self.bottomSpaceValue.constant = -50.f;
        }

        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [self.stationMessageTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];

        [HUDManager hideHUDView];

    } errorBlock:^(NSError *error) {
        [self.stationMessageTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];

        [HUDManager hideHUDView];

    }];
 
}
/** 删除按钮点击 */
- (IBAction)delegeteButtonClicked:(UIButton *)sender
{
    [self DelegateNetWork];
}

-(void)DelegateNetWork
{
    /**删除联系人*/
    if (self.selectedArray.count) {
        NSString * string ;
        for (NewStationMessageModel * model in self.selectedArray)
        {
            if (!string)
            {
                if ([model.fromUserId isEqualToString:kUserId]) {
                    string = model.toUserId;

                }else{
                    string = model.fromUserId;

                }
            }
            else
            {
                
                if ([model.fromUserId isEqualToString:kUserId]) {
                    string = [NSString stringWithFormat:@"%@,%@",string,model.toUserId];

                }else{
                    string = [NSString stringWithFormat:@"%@,%@",string,model.fromUserId];

                }
            }
        }
        
        NSDictionary * dic =@{@"userId":string,@"user_id":kUserId};
        [HUDManager showLoadingHUDView:self.view];
        [NetWork PostNetWorkWithUrl:@"/system/deleteMessageByUserId" with:dic successBlock:^(NSDictionary *dic)
         {
             [self editBarButtom];
             if ([dic[@"status"] boolValue]) {
                 self.begin=1;
                 [self NetWork];
             }
             else{
                 [HUDManager showWarningWithText:dic[@"message"]];
             }
             
         } errorBlock:^(NSString *error)
         {
             [HUDManager showWarningWithText:error];
         }];
    }else{
        [HUDManager showWarningWithText:@"请选择一条记录"];
        return;
    }
    
    
//    if (self.selectedArray.count) {
//        NSString * string ;
//        for (NewStationMessageModel * model in self.selectedArray)
//        {
//            if (!string)
//            {
//                string = model.messageID;
//            }
//            else
//            {
//                string = [NSString stringWithFormat:@"%@,%@",string,model.messageID];
//            }
//        }
//
//        NSDictionary * dic =@{@"ids":string,@"user_id":kUserId};
//        [HUDManager showLoadingHUDView:self.view];
//        [NetWork PostNetWorkWithUrl:@"/system/message_delete" with:dic successBlock:^(NSDictionary *dic)
//         {
//             [self editBarButtom];
//             if ([dic[@"status"] boolValue]) {
//                 self.begin=1;
//                 [self NetWork];
//             }
//             else{
//                 [HUDManager showWarningWithText:dic[@"message"]];
//             }
//
//         } errorBlock:^(NSString *error)
//        {
//            [HUDManager showWarningWithText:error];
//         }];
//    }else{
//        [HUDManager showWarningWithText:@"请选择一条记录"];
//        return;
//    }

    
}
- (IBAction)cancelButtonClicked:(UIButton *)sender
{
    CGFloat centerx = self.deleteView.center.x;
    CGFloat centery = self.deleteView.center.y;
    __weak StationMessageViewController * weakself = self;
    isEditing =NO;
    [self.stationMessageTableView reloadData];
        [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionShowHideTransitionViews) animations:^{
            weakself.deleteView.center = CGPointMake(centerx, centery+50);
        } completion:^(BOOL finished) {
            
        }];
}

-(void)editBarButtom
{
    [self.selectedArray removeAllObjects];
    [self.deleteButton setTitle:[LaguageControl languageWithString:@"删除"] forState:UIControlStateNormal];
    CGFloat centerx = self.deleteView.center.x;
    CGFloat centery = self.deleteView.center.y;
    [self.view bringSubviewToFront:self.deleteView];
    __weak StationMessageViewController * weakself = self;
    if (isEditing) {
        isEditing =!isEditing;
        [self.stationMessageTableView reloadData];
        [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionShowHideTransitionViews) animations:^{
            weakself.bottomSpaceValue.constant = -50.f;
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        isEditing =!isEditing;
        [self.stationMessageTableView reloadData];

        [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionShowHideTransitionViews) animations:^{
            weakself.bottomSpaceValue.constant = 0.f;
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isSelected = NO;
   
    StationMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    [cell editCell:isEditing];
    NewStationMessageModel * model = self.dataArray[indexPath.row];
    if ([self.selectedArray containsObject:model]) {
        isSelected = YES;
    }
    [cell loadModel:model with:indexPath show:isSelected];
    cell.delegate = self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewStationMessageModel * model = self.dataArray[indexPath.row];
    
    if (isEditing)
    {
        
    }
    else
    {
        StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
        view.title = [kUserId isEqualToString:model.fromUserId]?model.toUserName:model.fromUserName;
        view.toUserID = [kUserId isEqualToString:model.fromUserId]?model.toUserId:model.fromUserId;
        [self.navigationController pushViewController:view animated:YES];
    }
}
#pragma mark -UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (!isEditing) {
//        CATransition *transition = [CATransition animation];
//        transition.duration = 1.0f;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        //    transition.type = @"cube";
//        transition.type = kCATransitionFade;
//        transition.subtype = kCATransitionFromRight;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        SearchStationViewController * search = [[SearchStationViewController alloc] init];
        [self.navigationController pushViewController:search animated:YES];
    }
    return NO;
}

#pragma mark--StationMessageTableViewCellDelegate
-(void)StationMessageTableViewCellButtonSelete:(NSIndexPath *)indexpath
{
    NewStationMessageModel * model = self.dataArray[indexpath.row];
    if (![self.selectedArray containsObject:model]) {
        [self.selectedArray addObject:model];
    }
    else{
        [self.selectedArray removeObject:model];
    }
}

@end
