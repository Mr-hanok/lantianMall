//
//  EvaluationDetailsVCViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvaluationDetailsVCViewController.h"
#import "EvaluationDetailsTypeContentTableViewCell.h"
#import "GoodsImageTableViewCell.h"
#import "EvaluationDetailsTableViewCell.h"
#import "EvakuationHeadView.h"
#import "GoodsEvaluationModel.h"
#import "EvalutaionTypeContentTableViewCell.h"

static NSString * cellIdentifier = @"EvaluationDetailsTypeContentTableViewCell";

static NSString * cellCollectionIdentifier = @"GoodsImageTableViewCell";

static NSString * EvaluationCellIdentifier = @"EvaluationDetailsTableViewCell";

@interface EvaluationDetailsVCViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *evaluationDetailsTableView;

@property(strong,nonatomic) NSMutableArray * dataArray;


@end

@implementation EvaluationDetailsVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LaguageControl  languageWithString:@"评论详情"];
//    [self updataNewData:self.evaluationDetailsTableView];
    self.dataArray = [NSMutableArray array];
    if (self.models.imag1)
    {
        [self.dataArray addObject:self.models.imag1];
    }
    if (self.models.imag2)
    {
        [self.dataArray addObject:self.models.imag2];
    }
    if (self.models.imag3)
    {
        [self.dataArray addObject:self.models.imag3];
    }
    self.automaticallyAdjustsScrollViewInsets=YES;
    self.evaluationDetailsTableView.delegate = self;
    self.evaluationDetailsTableView.dataSource = self;
//    [self NetWork];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)NetWork
{
    NSDictionary * dic = @{@"id":self.evaluationID};
    [NetWork PostNetWorkWithUrl:@"/evaluate/evaluate_detail" with:dic successBlock:^(NSDictionary *dic)
    {
        self.models = [GoodsEvaluationModel mj_objectWithKeyValues:dic[@"data"]];
        [self.evaluationDetailsTableView reloadData];
    } errorBlock:^(NSString *error)
    {
        
    }];
}
#pragma mark --UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section)
    {
        return  self.dataArray.count;
    }
    else
    {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        GoodsImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellCollectionIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:cellCollectionIdentifier bundle:nil] forCellReuseIdentifier:cellCollectionIdentifier];
            cell =[tableView dequeueReusableCellWithIdentifier:cellCollectionIdentifier];
        }
        [cell.evaluationImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row]]];
        return cell;

    }
    else{
        EvaluationDetailsTypeContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
            cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        [cell LoadData:self.models];
        //        [cell LoadData:self.models WithIndexPath:indexPath];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        CGSize modelSize = [NSString sizeWithString:self.models.evaluateInfo font:KSystemFont(15) maxHeight:500 maxWeight:KScreenBoundWidth-60];
        return modelSize.height+120;
    }
    else
    {
        return 300;
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else
    {
        return 10;
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
