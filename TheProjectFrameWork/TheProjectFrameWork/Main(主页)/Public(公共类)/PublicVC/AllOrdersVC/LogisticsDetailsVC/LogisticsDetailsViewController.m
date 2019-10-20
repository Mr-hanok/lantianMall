//
//  LogisticsDetailsViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LogisticsDetailsViewController.h"
#import "LogisticsDetialTableViewCell.h"
#import "LogistNowTableViewCell.h"
#import "LogistLogTableViewCell.h"
#import "LogisticsHeadView.h"

static NSString * HeadIdentifier = @"LogisticsHeadView";

static NSString * cellIdentifier = @"LogisticsDetialTableViewCell";

static NSString * NowcellIdentifier = @"LogistNowTableViewCell";

static NSString * LogcellIdentifier = @"LogistLogTableViewCell";

@interface LogisticsDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *logistTableView;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSString *companyname;
@property (nonatomic, copy) NSString *shipcode;
@end

@implementation LogisticsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.logistTableView.tableFooterView = [[UIView alloc]init];
    self.logistTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.logistTableView.bounds.size.width, 0.01f)];
    self.array = [NSMutableArray array];
    self.title = @"物流详情";
    [HUDManager showLoadingHUDView:self.view];
    [self getdata];
    
}

#pragma mark -NetWork
/**物流接口*/
-(void)getdata{
    NSDictionary * parms = @{@"orderId":self.orderid,};
    
    [NetWork PostNetWorkWithUrl:@"/express/getExpressInfo" with:parms successBlock:^(NSDictionary *dic) {
        if ([dic[@"data"] isKindOfClass:[NSNull class]] || !dic[@"data"]) {
            return ;
        }
        NSArray *tempArray = dic[@"data"][@"data"];
        self.array = [WuLiuModel mj_objectArrayWithKeyValuesArray:tempArray];
        self.companyname = dic[@"data"][@"companyName"]?:@"";
        self.shipcode = dic[@"data"][@"shipCode"]?:@"";
        
        [self.logistTableView reloadData];
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {

    }];
}

#pragma mark --UITableViewDelegate&&UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section)
    {
        return self.array.count;
    }
    else
    {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        LogisticsDetialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.countLabel.text = self.ordermodel.totalcount;
        OrderGoodsModel *goodsmode = [self.ordermodel.gcpList firstObject];
        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsmode.goodsMainPhotos] placeholderImage:[UIImage imageNamed:kDefaultGoodsImgV]];
        cell.orderNumLabel.text = self.shipcode;
        cell.stateLabel.text = self.companyname;
        
        return cell;
    }
    else
    {
        WuLiuModel *model = self.array[indexPath.row];
        if (indexPath.row==0)
        {
            LogistNowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NowcellIdentifier];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:NowcellIdentifier bundle:nil] forCellReuseIdentifier:NowcellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:NowcellIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.timeLabel.text = model.time;
            cell.contextLabel.text = model.context;
            return cell;
            
        }
        else
        {
            LogistLogTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LogcellIdentifier];
            if (!cell)
            {
                [tableView registerNib:[UINib nibWithNibName:LogcellIdentifier bundle:nil] forCellReuseIdentifier:LogcellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:LogcellIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.timeLabel.text = model.time;
            cell.contextLabel.text = model.context;
            return cell;
            
        }
            
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 120;
    }
    else{
        return 70;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section)
    {
        return self.array.count ? 40 : 0;
    }
    else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section) {
        LogisticsHeadView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:nil] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        }
        return view;
    }
    else{
        return nil;
    }
    
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




@implementation WuLiuModel

@end
