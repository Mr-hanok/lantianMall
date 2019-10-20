//
//  ClassGoodsSortViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassGoodsSortViewController.h"
#import "GoodsScreenTableViewCell.h"
#import "HUDManager.h"

@interface ClassGoodsSortViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 排序 */
@property (weak, nonatomic) IBOutlet UITableView *SortTableView;
/** 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property(strong,nonatomic) NSMutableArray * dataArray;
/** 选中结果 */
@property(strong,nonatomic) NSString * resultString;


@end

@implementation ClassGoodsSortViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.confirmButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = KAppRootNaVigationColor;
    self.SortTableView.delegate = self;
    UIBarButtonItem * editBar =[[UIBarButtonItem alloc] initWithTitle:LaguageControl(@"清除") style:UIBarButtonItemStyleDone target:self action:@selector(ClearSelected)];
    [editBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem * backBar =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"baicha"] style:UIBarButtonItemStyleDone target:self action:@selector(backToPresentViewController)];
    [backBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = backBar;
    self.navigationItem.rightBarButtonItem = editBar;
    self.dataArray =[NSMutableArray array];
    [self.dataArray addObjectsFromArray:@[@"价格高",@"价格低",@"销量"]];
    // Do any additional setup after loading the view from its nib.
}
-(void)ClearSelected{
    self.resultString = nil;
    [self.SortTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    if (self.blcok){
        if (!self.resultString){
            [HUDManager showWarningWithText:@"请选择一个排序方式"];
        }
        else{
            self.blcok(self.resultString);
            [self backToPresentViewController];
        }
    }
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
-(void)GetSelected:(SelectedResult)block
{
    self.blcok = block;
}
#pragma mark --UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsScreenTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsScreenTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GoodsScreenTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsScreenTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsScreenTableViewCell"];
    }
    if (self.resultString)
    {
        if ([self.resultString integerValue] ==indexPath.row+1)
        {
            cell.moreImageView.image = [UIImage imageNamed:@"tuoyuanduigou"];
        }
        else
        {
            cell.moreImageView.image = [UIImage imageNamed:@"more"];
        }
    }
    else{
        cell.moreImageView.image = [UIImage imageNamed:@"more"];
    }
    cell.nameLabel.text = LaguageControl(self.dataArray[indexPath.row]) ;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.resultString = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [self.SortTableView reloadData];
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
