//
//  ClassScreeningDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassScreeningDetialViewController.h"
#import "ClassScreeningDetialTableViewCell.h"
#import "ScreenDetialModel.h"
static NSString * cellIndetifier = @"ClassScreeningDetialTableViewCell";
@interface ClassScreeningDetialViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *TopView;
@property (weak, nonatomic) IBOutlet UITableView *screenDetialTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property(strong,nonatomic) NSMutableArray * selectArray;

@end

@implementation ClassScreeningDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.confirmButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    self.titleLabel.text = self.titles;
    self.confirmButton.backgroundColor =KAppRootNaVigationColor;
    self.screenDetialTableView.dataSource = self;
    self.screenDetialTableView.delegate = self;
    UIBarButtonItem * editBar =[[UIBarButtonItem alloc] initWithTitle:LaguageControl(@"清除") style:UIBarButtonItemStyleDone target:self action:@selector(clearTheSelected)];
    [editBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = editBar;
    self.TopView.backgroundColor = KAppRootNaVigationColor;
    self.bottomView.backgroundColor = KAppRootNaVigationColor;
    self.screenDetialTableView.delegate = self;
    self.selectArray = [NSMutableArray array];
}
-(void)GetSelected:(SelectedResult)block
{
    self.blcok = block;
}
- (IBAction)confirmButton:(UIButton *)sender
{
    if (self.selectArray.count)
    {
        NSString * result ;
        NSArray * array = self.selectArray;
        for (ScreenDetialModel * model in self.selectArray) {
            NSString * string = model.detialName?model.detialName:model.detialStandName;
            if (!result){
                result = string;
            }
            else{
                result = [result stringByAppendingString:string];
            }
        }
        self.blcok(array,result);
        [self backToPresentViewController];
    }
    else
    {
        [HUDManager showWarningWithText:@"请选择一个内容"];
        
    }

}
-(void)clearTheSelected
{
    [self.selectArray removeAllObjects];
    [self.screenDetialTableView reloadData];
    
}
-(void)backToPresentViewController
{

    [super backToPresentViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark -- UITableViewDataSource &&UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isselected = NO;
    ScreenDetialModel * model = self.dataArray[indexPath.row];

    ClassScreeningDetialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIndetifier bundle:nil] forCellReuseIdentifier:cellIndetifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    }
    if (model.detialName) {
        cell.namelabel.text = model.detialName;
    }
    else{
        cell.namelabel.text = model.detialStandName;
    }
    if ([self.selectArray containsObject:model]) {
        isselected = YES;
    }
    [cell LoadDatawith:nil and:isselected];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScreenDetialModel * model = self.dataArray[indexPath.row];

    if ([self.selectArray containsObject:model]) {
        [self.selectArray removeObject:model];
    }
    else{
        [self.selectArray addObject:model];
    }
    [self.screenDetialTableView reloadData];
}
- (IBAction)BackToPresent:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
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
