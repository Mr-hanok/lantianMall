//
//  ClassGoodScreeningViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassGoodScreeningViewController.h"
#import "GoodsScreenTableViewCell.h"
#import "ClassScreeningDetialViewController.h"
#import "ScreenModel.h"
#import "ScreenDetialModel.h"

static NSString * cellIdentifier = @"GoodsScreenTableViewCell";
@interface ClassGoodScreeningViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (weak, nonatomic) IBOutlet UITableView *screeningTableView;

@property(strong,nonatomic) NSString * sortString;
/**
 *  数据源
 */
@property(strong,nonatomic) NSMutableArray * dataArray;

/** 选择 */
@property(strong,nonatomic) NSIndexPath * selectIndex;

@property(strong,nonatomic) NSMutableDictionary * selectDictionary;

@end

@implementation ClassGoodScreeningViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.confirmButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = KAppRootNaVigationColor;
    self.screeningTableView.delegate = self;
    self.selectDictionary = [NSMutableDictionary dictionary];
    UIBarButtonItem * editBar =[[UIBarButtonItem alloc] initWithTitle:LaguageControl(@"清除") style:UIBarButtonItemStyleDone target:self action:@selector(ClearSelected)];
    [editBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem * backBar =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"baicha"] style:UIBarButtonItemStyleDone target:self action:@selector(backToPresentViewController)];
    [backBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backBar;
    self.navigationItem.rightBarButtonItem = editBar;
    self.dataArray =[NSMutableArray array];
    [self NetWork];

    // Do any additional setup after loading the view from its nib.
}
-(void)GetSelected:(ScreenSelectedResult)block{
    self.block = block;
}
-(void)backToPresentViewController{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)ClearSelected
{
    self.selectDictionary = nil;
    [self.screeningTableView reloadData];
}
- (IBAction)confirmButton:(UIButton *)sender
{
    NSString * idStrings;
    NSString * otherString;
    for (NSInteger m=0; m<self.dataArray.count; m++) {
        NSArray *  array;
        ScreenModel * model = self.dataArray[m];
        if (!m)
        {
            array=[self.selectDictionary valueForKey:@"0"];
        }
        else{
            array =[self.selectDictionary valueForKey:[NSString stringWithFormat:@"%ld",(long)m]];
        }
        if ([model.screenPostName isEqualToString:@"goods_brand_id"]) {
            for (ScreenDetialModel * model in array)
            {
                if (!otherString) {
                    otherString = model.detialID;
                }
                else{
                    otherString = [NSString stringWithFormat:@"%@,%@",otherString,model.detialID ];
                }
            }
        }
        else{
            for (ScreenDetialModel * model in array)
            {
                if (!idStrings) {
                    idStrings = model.detialID;
                }
                else{
                    idStrings = [NSString stringWithFormat:@"%@,%@",idStrings,model.detialID];
                }
            }
        }
    }
    if (self.block)
    {
        self.block(idStrings,otherString);
    }
    [self backToPresentViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsScreenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    ScreenModel * model = self.dataArray[indexPath.row];
    cell.nameLabel.text = model.screenName;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreenModel * model = self.dataArray[indexPath.row];
    ClassScreeningDetialViewController * views = [[ClassScreeningDetialViewController alloc] init];
    views.title = model.screenName;
    views.dataArray = [ScreenDetialModel mj_objectArrayWithKeyValuesArray:model.screenArray];
    __weak ClassGoodScreeningViewController * weakself = self;
    [views GetSelected:^(NSArray *resultArray, NSString *result) {
    GoodsScreenTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [weakself.selectDictionary setObject:resultArray forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    cell.nameLabel.text = result;
        }];
    views.FatherVC = self.FatherVC;
    [self.navigationController pushViewController:views animated:YES];
}

/**
 *  获取筛选列表网络请求
 */

-(void)NetWork
{
    NSDictionary * dic = @{@"gc_id":self.modelsID,};
     [NetWork PostNetWorkWithUrl:@"/goods/searchInfoByGc" with:dic successBlock:^(NSDictionary *dic)
    {
        if ([dic[@"status"]boolValue]&& [dic[@"data"][@"resultList"] count]) {
            self.dataArray =  [ScreenModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"resultList"]];
            [self.screeningTableView reloadData];
        }
     } errorBlock:^(NSString *error) {
         
     }];
    
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
