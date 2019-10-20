//
//  GoodsView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsDetialModel.h"

#import "GoodsView.h"
#import "PopShopGoodsInfoView.h"
#import "GoodsShowDetialTableViewCell.h"
#import "GoodDescriptionTableViewCell.h"
#import "PopShopView.h"
#import "GoodsScrollerTableViewCell.h"
#import "ParameterDetialModel.h"
#import "GoodsHeadView.h"
#import "LoginViewController.h"
static NSString * cellIdentifier = @"GoodsShowDetialTableViewCell";
static NSString * CellIdentifier = @"GoodDescriptionTableViewCell";
@interface GoodsView ()<UITableViewDelegate,UITableViewDataSource,PopShopViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *goodDetialTableView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property(strong,nonatomic) NSMutableArray * imageDataArray;
@property(strong,nonatomic) GoodsHeadView * headView;
@end

@implementation GoodsView
{
    PopShopView * popShopview;
    GoodsShowDetialTableViewCell * goodsShowDetialcell;
}
+(id)loadView
{
    GoodsView * view  =[super loadView];
    view.dataArray = [NSMutableArray array];
    view.imageDataArray = [NSMutableArray array];
    view.goodDetialTableView.delegate = view;
    view.goodDetialTableView.dataSource = view;
    view.headView = [GoodsHeadView loadView];
    view.headView.frame =CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundWidth+10);
    view.goodDetialTableView.tableHeaderView = view.headView;
    view.backgroundColor = view.goodDetialTableView.backgroundColor = kBGColor;
    return view;
}

-(void)PopShowViewWith:(PoPTypes)type andblock:(GoodsViewBlock)blcok{
    if (!popShopview)
    {
        popShopview  = [PopShopView loadView];
        popShopview.delegate = self;
    }
    [popShopview loadViewWith:self.model.parameterArray shopModel:self.model];
    self.type = type;
    self.block = blcok;
    [popShopview showView];
}
-(void)LoadData:(NSArray*)array
{   [self.imageDataArray removeAllObjects];
    [self.imageDataArray addObjectsFromArray:array];
    self.goodDetialTableView.tableHeaderView.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundWidth);
    self.goodDetialTableView.tableHeaderView = self.headView;
    self.headView.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundWidth);
    [self.headView loadScrollerViewWithArray:array];
    [self.goodDetialTableView reloadData];
}
#pragma mark --UITableViewDelegate&&UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1)
    {
//        GoodsScrollerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsScrollerTableViewCell"];
//        if (!cell) {
//            [tableView registerNib:[UINib nibWithNibName:@"GoodsScrollerTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsScrollerTableViewCell"];
//         cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsScrollerTableViewCell"];
//        }
//        [cell loadScrollerViewWithmodel:self.model];
//        return cell;
        GoodsShowDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellIdentifier owner:nil options:0]firstObject];
        }
        cell.specificationLabel.text = @"产品参数";
        return cell;
    }
    else
        if (indexPath.section==2) {
        goodsShowDetialcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
        if (!goodsShowDetialcell) {
            [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
            goodsShowDetialcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        return goodsShowDetialcell;
    }
    else
    {
        GoodDescriptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        if (KScreenBoundWidth>320)
        {
        }
        else
        {
            cell.shareButton.titleLabel.font = KSystemFont(11);
            cell.goodsNameLabel.font = KSystemFont(11);
            cell.goodsPriceLabel.font = KSystemFont(11);
        }
        [cell.shareButton addTarget:self action:@selector(ShareButton) forControlEvents:UIControlEventTouchUpInside];
        cell.goodsNameLabel.text = self.model.goods_name?:@"";
        NSString * price = self.model.showPrice;
        cell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥ %@",price?:@""] ;
        if (self.model.activity_title) {
            cell.activitylable.text = self.model.activity_title?:@"";
            cell.activityDesLabel.text = self.model.activity_desc?:@"";

        }else{
            cell.activitylable.text = @"";
            cell.activityDesLabel.text = @"";
        }
        return cell;
    }
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2)
    {
        return 50;
    }
    else if (indexPath.section)
    {
        return 50;
//        return 120;
    }
    else
    {
        if (self.model.activity_title) {
            return 125;
        }else{
            return 80;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return section == 1 ? 10: 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2){
        if (![UserAccountManager shareUserAccountManager].loginStatus) {
            [HUDManager showWarningWithText:@"尚未登录,请先登录!"];
            return;
        }
        if (!popShopview)
        {
            popShopview  = [PopShopView loadView];
            popShopview.delegate = self;
        }
        [popShopview loadViewWith:nil shopModel:self.model];
        self.type = PoPTypesDefault;
        [popShopview showView];
    }else if ( indexPath.section == 1){
        /**产品参数*/
        PopShopGoodsInfoView *popshopinfoview = [PopShopGoodsInfoView loadView];
        [popshopinfoview loadViewWithShopModel:self.model];
        [popshopinfoview showView];
        
    }
}
#pragma mark--GoodsHeadViewDelegete
-(void)ScrolledToNext
{
    if ([self.delegate respondsToSelector:@selector(GoodsViewscrollerToNext)]) {
        [self.delegate GoodsViewscrollerToNext];
    }
}
-(void)GoodsHeadViewDidselected
{
//    -(void)shareButtonClicked;

}

-(void)ShareButton{
    if ([self.delegate respondsToSelector:@selector(shareButtonClicked)]) {
        [self.delegate shareButtonClicked];
    }
}
#pragma mark--PopShopViewDelegate
-(void)selected:(id)content with:(NSDictionary*)model
{
    NSString * selectString;
    NSString * selectID;
    NSArray * array = [model allKeys];
    NSMutableArray * mutarray= [NSMutableArray array];
    for (NSString * string in array) {
        if (![string isEqualToString:@"number"] && ![string isEqualToString:@"showPrice"]&& ![string isEqualToString:@"sku_id"]) {
            [mutarray addObject:string];
        }
    }
    for (NSString * string in mutarray) {
        ParameterDetialModel * paramodel = model[string];
        if (!selectString) {
            selectString =[NSString stringWithFormat:@"%@:%@ ",string,paramodel.parameterDetialValues];
        }
        else{
            selectString =[selectString stringByAppendingString:[NSString stringWithFormat:@"%@:%@ ",string,paramodel.parameterDetialValues]];
        }
//        if (!selectID) {
//            selectID =[NSString stringWithFormat:@"%@",paramodel.parameterDetialID];
//        }
//        else{
//            selectID =[selectID stringByAppendingString:[NSString stringWithFormat:@",%@",paramodel.parameterDetialID]];
//        }
    }
    if ([self.delegate respondsToSelector:@selector(GoodsViewSelected:andpamar:andpamarID:with:)])
    {
//            [self.delegate GoodsViewSelected:model[@"number"] andpamar:selectString andpamarID:selectID with:self.type];
        [self.delegate GoodsViewSelected:model[@"number"] andpamar:selectString?:model[@"sku_id"] andpamarID:model[@"sku_id"] with:self.type];

    }
    if (self.type!=PoPTypesDefault)
    {
        if (self.block) {
            self.block(model,YES);
        }
    }
    if (!selectString) {
        selectString = [NSString stringWithFormat:@"%@:%@",LaguageControl(@"数量"),model[@"number"]];
    }
    else{
        selectString = [selectString stringByAppendingString:[NSString stringWithFormat:@"%@:%@",LaguageControl(@"数量"),model[@"number"]]];
    }
    
    self.model.showPrice = model[@"showPrice"]?:@"";
    GoodDescriptionTableViewCell *cell = [self.goodDetialTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥ %@",model[@"showPrice"]?:@""] ;
    
    goodsShowDetialcell.specificationLabel.text = selectString;
   
}


@end
