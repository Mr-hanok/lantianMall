//
//  HomeClassView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeClassView.h"
#import "ClassTitleView.h"
#import "HomeClassTableViewCell.h"
#import "HomeClassModel.h"
#import "HomeClassViewController.h"
#import "ClassGoodsViewController.h"

#define  kcellHeight 40.0;
static NSString * cellIdentifier = @"HomeClassTableViewCell";

@interface HomeClassView ()<UITableViewDelegate,UITableViewDataSource,ClassTitleViewDelegate>
@property(strong,nonatomic) NSMutableArray * reloadArray;

@end
@implementation HomeClassView
+(HomeClassView *)CreateView{
    HomeClassView * view = [[[NSBundle mainBundle] loadNibNamed:@"HomeClassView" owner:nil options:nil] firstObject];
    view.isShow = NO;
    view.classTableView.delegate = view;
    view.classTableView.dataSource = view;
    view.classTableView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    view.dataArray = [NSMutableArray array];
    view.reloadArray = [NSMutableArray array];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    [view.tapView addGestureRecognizer:tap];
    
    [view NetWork];
    return view;
}
-(void)NetWork
{
    [NetWork PostNetWorkWithUrl:@"/mall_category" with:nil successBlock:^(NSDictionary *dic) {
        if ([dic[@"status"] boolValue])
        {
            [dic ds_writefiletohomePath:@"/mall_category"];
            [self reloadView];
        }
    } errorBlock:^(NSString *error) {
        [self reloadView];

    }];
}

-(void)reloadView
{
    [self.dataArray removeAllObjects];
    NSDictionary * dic = [NSDictionary ds_readfiletohomePath:@"/mall_category"];
    NSMutableArray * array =  [HomeClassModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"categroy"]];
    for (HomeClassModel * model in array) {
        model.childrens = [HomeClassModel mj_objectArrayWithKeyValuesArray:model.childrens];
    }
    if (array.count)
    {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:array];
    [self.classTableView reloadData];
}

-(void)loadViewWith:(NSArray*)array
{

}
-(void)showView
{
    self.isShow = YES;
    [KeyWindow addSubview:self];
    [self NetWork];
    self.frame = CGRectMake(-KScreenBoundWidth, kNavigaTionBarHeight, KScreenBoundWidth, KScreenBoundHeight-kNavigaTionBarHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, kNavigaTionBarHeight, KScreenBoundWidth, KScreenBoundHeight-kNavigaTionBarHeight);
    } completion:^(BOOL finished) {
    }];
}
-(void)tapTheView{
    
    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HomeClassModel * model = self.dataArray[section];
//    model.childrens = [HomeClassModel mj_objectArrayWithKeyValuesArray:model.childrens];
    return  model.childrens.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil] firstObject];
    }
    if (![self.reloadArray containsObject:@(indexPath.section)]) {
        cell.ImageView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:1];
    }
    else{
        cell.ImageView.backgroundColor=[UIColor whiteColor];
    }
    HomeClassModel * model = self.dataArray[indexPath.section];
    HomeClassModel * childsModel = model.childrens[indexPath.row];
    cell.contentDetialLabel.text = childsModel.goodsName;
    cell.contentDetialLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeClassModel * model = self.dataArray[indexPath.section];
    HomeClassModel * childsModel = model.childrens[indexPath.row];
    if (childsModel.nextChilds)
    {
        HomeClassViewController * class = [[HomeClassViewController alloc] init];
        class.goodsName = childsModel.goodsName;
        class.goodsID  =  childsModel.goodsID;
        [self viewDissMissFromWindow];
        class.hidesBottomBarWhenPushed = YES;
        [self.ViewController.navigationController pushViewController:class animated:YES];
    }
    else
    {
        ClassGoodsViewController * goods = [[ClassGoodsViewController alloc] init];
        goods.goodName = childsModel.goodsName;
        goods.title = childsModel.goodsName;
        goods.goodID = childsModel.goodsID;
        [self viewDissMissFromWindow];
        goods.hidesBottomBarWhenPushed = YES;
        [self.ViewController.navigationController pushViewController:goods animated:YES];
    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.reloadArray containsObject:@(indexPath.section)]) {
        return kcellHeight;
    }
    else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ClassTitleView * view = [ClassTitleView CreatClassTitleViewWithIndex:section];
    view.delegate = self;
    if ([self.reloadArray containsObject:@(section)]) {
        view.titleImageView.image =[UIImage imageNamed:@"xiajiantou"];
        view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    }
    else{
        view.titleImageView.image =[UIImage imageNamed:@"youjiatou"];

    }
    HomeClassModel * model = self.dataArray[section];
    view.titleName.text=model.goodsName;
    return view;
}
#pragma mark --ClassTitleViewDelegate
-(void)DetialButtonClickedWith:(NSInteger)section{
    if ([self.reloadArray containsObject:@(section)]) {
        [self.reloadArray removeObject:@(section)];
    }
    else{
        [self.reloadArray addObject:@(section)];
    }
    [self.classTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}



@end
