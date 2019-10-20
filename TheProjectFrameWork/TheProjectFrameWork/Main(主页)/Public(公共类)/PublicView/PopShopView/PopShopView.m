//
//  PopShopView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopShopView.h"
#import "PopShopTableViewCell.h"
#import "PopNumberTableViewCell.h"
#import "GoodsDetialModel.h"
#import "GoodsParameterModel.h"
#import "ParameterDetialModel.h"
static NSString * cellIdentifier = @"PopShopTableViewCell";
static NSString * NumCellIdentifier =@"PopNumberTableViewCell";

@interface PopShopView ()<UITableViewDelegate,UITableViewDataSource,PopShopTableViewCellDelegate,PopNumberTableViewCellDelegate>
@property (nonatomic, copy) NSString *sku_id;
@property (nonatomic, assign) float cellheight;
@end

@implementation PopShopView
{
    PopNumberTableViewCell * popNumbercell ;
}
+(id)loadView
{
    PopShopView * view = [super loadView];
    view.isShow = NO;
    view.resultDic = [NSMutableDictionary dictionary];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    view.goodsDetialtableView.dataSource = view;
    view.goodsDetialtableView.delegate = view;
    CGRect frame=CGRectMake(0, 0, 0, CGFLOAT_MIN);
    view.goodsDetialtableView.tableHeaderView=[[UIView alloc]initWithFrame:frame];
    view.goodsDetialtableView.tableFooterView=[[UIView alloc]initWithFrame:frame];

    

    view.goodsImageView.layer.cornerRadius = 5;
    view.goodsImageView.layer.masksToBounds = YES;
    view.dataArray = [NSMutableArray array];
    [view.tapView addGestureRecognizer:tap];
    [view.resultDic setValue:@(1) forKey:@"number"];

    [view.confirmButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    [view.goodsDetialtableView reloadData];
    
    if (KScreenBoundWidth>320)
    {
    }
    else
    {
        view.goodsNameLabel.font = KSystemFont(11);
        view.confirmButton.titleLabel.font = KSystemFont(13);
    }
    [view.confirmButton setBackgroundColor:kNavigationColor];
    view.goodsDescriptionLabel.textColor = kNavigationColor;
    return view;

}
-(void)loadViewWith:(NSArray*)array shopModel:(GoodsDetialModel*)model
{

    [self.dataArray removeAllObjects];
    for (GoodsParameterModel * models in model.parameterArray) {
        [self.dataArray addObject:models];
    }
    self.model = model;
    if (model.skuArray.count == 1) {
        SkuModel *skumodel = [model.skuArray firstObject];
        self.model.goods_inventory = skumodel.stocks;
    }
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.model.goodsImageUrl] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    self.goodsNameLabel.text = self.model.goods_name;
    self.goodsNameLabel.text = [NSString stringWithFormat:@"库存:%@",self.model.goods_inventory?:@"0"];
    self.goodsDescriptionLabel.text = [@"¥ " stringByAppendingString:self.model.showPrice?:@""];
    self.goodsImageView.image = [UIImage imageNamed:self.model.goodsImageUrl];
    [self.goodsDetialtableView reloadData];

}

-(void)contenTViewTaps
{
    
}

-(void)showView{
    self.isShow = YES;
    [KeyWindow addSubview:self];
    [self.goodsDetialtableView reloadData];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.model.goodsImageUrl] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    self.goodsNameLabel.text = self.model.goods_name;
    self.goodsNameLabel.text = [NSString stringWithFormat:@"库存:%@",self.model.goods_inventory?:@"0"];
    self.goodsDescriptionLabel.text = [@"¥ " stringByAppendingString:self.model.showPrice?:@""];
    self.frame = CGRectMake(0, KScreenBoundHeight, KScreenBoundWidth, KScreenBoundHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight);
    } completion:^(BOOL finished) {
    }];
}
-(void)tapTheView{
    
    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, KScreenBoundHeight, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
/**
 *  返回按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)backButtonClicked:(id)sender
{
    [self viewDissMissFromWindow];
}
/**
 *  确定按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)ConfirmButtonClicked:(UIButton *)sender
{
    if ([self.resultDic allKeys].count < self.dataArray.count+1&&self.dataArray.count)
    {
        for (GoodsParameterModel *model in self.dataArray)
        {
            if (![[self.resultDic allKeys] containsObject:model.parameterName])
            {
                [HUDManager showWarningWithText:[NSString stringWithFormat:@"%@ %@",@"请选择",model.parameterName]];
                return;
            }
        }
    }
    else
    {
        [self.resultDic setObject:self.model.showPrice forKey:@"showPrice"];
        [self.resultDic setObject:self.sku_id?:[NSString stringWithFormat:@"%@,",self.model.goodsID] forKey:@"sku_id"];
        if ([self.delegate respondsToSelector:@selector(selected:with:)]) {
            [self.delegate selected:nil with:self.resultDic];
        }
        [self viewDissMissFromWindow];
    }

}

#pragma mark --UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==self.dataArray.count)
    {
        popNumbercell = [tableView dequeueReusableCellWithIdentifier:NumCellIdentifier];
        if (!popNumbercell) {
            [tableView registerNib:[UINib nibWithNibName:NumCellIdentifier bundle:nil] forCellReuseIdentifier:NumCellIdentifier];
            popNumbercell = [tableView dequeueReusableCellWithIdentifier:NumCellIdentifier];
            popNumbercell.goodNameLabel.text = [LaguageControl languageWithString:@"数量"];
            popNumbercell.delegate =self;
        }
        NSInteger m = [self.resultDic[@"number"] integerValue];
        [popNumbercell loadDataGoodsNumber:m andCollectionNumber:[self.model.goods_inventory integerValue]];
        return popNumbercell;
    }
    else
    {
        PopShopTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        cell.delegate = self;
        GoodsParameterModel * model = self.dataArray[indexPath.section];
        [cell loadCollectionViewWith:model.parameterDataArray WithSection:indexPath.section type:model.type];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==self.dataArray.count)
    {
        return 40;
    }
    else{
        if (self.cellheight > 0) {
            return self.cellheight;
        }
        GoodsParameterModel * themodel = self.dataArray[indexPath.section];
        CGSize totoal;
        for (ParameterDetialModel * detial in themodel.parameterDataArray)
        {
           CGSize m  = [NSString sizeWithString:detial.parameterDetialValues font:[UIFont systemFontOfSize:kAppAsiaFontSize(13)] maxHeight:30 maxWeight:KScreenBoundWidth];
            if (!totoal.width)
            {
                totoal = CGSizeMake(m.width+30, 30);
            }
            else
            {
                if (m.width+20>KScreenBoundWidth/2)
                {
                    totoal = CGSizeMake(totoal.width+KScreenBoundWidth, 30);
                }
                else
                {
                    if (m.width<KScreenBoundWidth/4)
                    {
                        totoal = CGSizeMake(m.width+40+totoal.width,30);
                    }
                    else
                    {
                        totoal = CGSizeMake(m.width+30+totoal.width,30);
                    }
                }
            }
        }
         self.cellheight = totoal.width/(KScreenBoundWidth-40)*30+60;
        return self.cellheight;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==self.dataArray.count) {
        return 0;
    }
    return 25;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==self.dataArray.count) {
        return  nil;
    }
    else{
        GoodsParameterModel * model = self.dataArray[section];
        return model.parameterName;
    }
}
#pragma mark -- PopShopTableViewCellDelegate
-(void)didSelectedwith:(NSIndexPath*)indexpath PopShopTableViewCell:(PopShopTableViewCell*)cell
{
    GoodsParameterModel * model =self.dataArray[indexpath.section];
    ParameterDetialModel * paramodel = model.parameterDataArray[indexpath.row];
    paramodel.ISSelecteD = !paramodel.ISSelecteD;
    if (paramodel.ISSelecteD)
    {
        for ( ParameterDetialModel * para  in model.parameterDataArray) {
            if (![para isEqual:paramodel])
            {
                para.ISSelecteD = !paramodel.ISSelecteD;
            }
        }
    }
    if (paramodel.ISSelecteD)
    {
        if ([model.type isEqualToString:@"img"]) {
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:paramodel.imgUrl] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
        }
        [self.resultDic setValue:paramodel forKey:model.parameterName];
    }
    else{
        if ([model.type isEqualToString:@"img"]) {
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.model.goodsImageUrl] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
        }
        self.goodsNameLabel.text = [NSString stringWithFormat:@"库存:%@",self.model.goods_inventory?:@"0"];
        self.goodsDescriptionLabel.text = [@"¥ " stringByAppendingString:self.model.showPrice?:@""];
        [self.resultDic removeObjectForKey:model.parameterName];
    }
    [self.resultDic removeObjectForKey:@"showPrice"];
    [self.resultDic removeObjectForKey:@"sku_id"];

    if ([self.resultDic allKeys].count!=self.dataArray.count+1&&self.dataArray.count) {
        
//        NSArray *tempGsparray= [[self gsPstring] componentsSeparatedByString:@"_"];
//        
//        [self.model.skuArray enumerateObjectsUsingBlock:^(SkuModel  * obj, NSUInteger idx, BOOL * _Nonnull stop1) {
//            /**匹配上规格*/
//            __block BOOL isSuccess = YES;
//            [tempGsparray enumerateObjectsUsingBlock:^(NSString  * gspstr, NSUInteger idx, BOOL * _Nonnull stop2) {
//                if ([obj.sku_id containsString:gspstr]) {
//                    isSuccess = YES;
//                }else{
//                    isSuccess = NO;
//
//                }
//                
//            }];
//            if (isSuccess) {
//                /**如果没有有库存*/
//                if ([obj.stocks isEqualToString:@"0"] || obj.stocks == nil || [obj.stocks isEqualToString:@""]) {
//
//                }else{
//                }
//
//            }else{
//
//            }
//        }];

        
        [self.goodsDetialtableView reloadData];
    }
    else
    {

        [self CheckGoodsShowPriceWith:[self gsPstring] with:^(BOOL success, NSString *price ,NSString *count,NSString *sku_id) {
            
            if (success) {
//                self.model.goods_inventory = count;
                self.goodsNameLabel.text = [NSString stringWithFormat:@"库存:%@",count?:@"0"];
//                self.model.showPrice = price;
                self.goodsDescriptionLabel.text = [@"¥ " stringByAppendingString:price?:@""];
                [self.resultDic setValue:@"1" forKey:@"number"];
                self.sku_id = sku_id;
            }
            [self.goodsDetialtableView reloadData];

        }];
        
//        [self CheckGoodsInventoryWith:[self gsPstring] with:^(BOOL success, NSString *count)
//        {
//            if (success)
//            {
//                self.model.goods_inventory = count;
//                [self.resultDic setValue:@"1" forKey:@"number"];
//            }
//            [self.goodsDetialtableView reloadData];
//
//        }];
    }
}
-(NSString*)gsPstring
{
    __block NSString * string ;
    [self.resultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
     {
         if ([obj isKindOfClass:[ParameterDetialModel class]])
         {
             ParameterDetialModel *model = obj;
             if (string) {
                 string  = [NSString stringWithFormat:@"%@_%@",string,model.parameterDetialID];
             }
             else{
//                 string = [NSString stringWithFormat:@"%@,%@",self.model.goodsID,model.parameterDetialID];
                 string = model.parameterDetialID;

             }
         }
    }];
    
    return string;
}
//-(void)CheckGoodsInventoryWith:(NSString*)gspString with:(void (^)(BOOL success ,NSString*count))block
//{
//    NSDictionary * dic =  @{@"id":self.model.goodsID,@"gsp":gspString,};
//    [HUDManager showLoadingHUDView:self];
//    [NetWork PostNetWorkWithUrl:@"/load_goods_gsp" with:dic successBlock:^(NSDictionary *dic)
//    {
//        [HUDManager hideHUDView];
//        if ([dic[@"status"] boolValue])
//        {
//            NSString * string = [NSString stringWithFormat:@"%@",dic[@"data"]];
//            block(YES,string);
//        }
//        else
//        {
//            [HUDManager showWarningWithText:dic[@"message"]];
//            block(NO,dic[@"message"]);
//        }
//    } errorBlock:^(NSString *error) {
//        [HUDManager showWarningWithText:error];
//        block(NO,error);
//
//    }];
//    
//}
- (void)CheckGoodsShowPriceWith:(NSString *)gspString  with:(void(^)(BOOL success , NSString *price ,NSString*count ,NSString*sku_id))block{
    
    NSArray *tempGsparray= [gspString componentsSeparatedByString:@"_"];
    
    [self.model.skuArray enumerateObjectsUsingBlock:^(SkuModel  * obj, NSUInteger idx, BOOL * _Nonnull stop1) {
        /**匹配上规格*/
        __block BOOL isSuccess = YES;
        [tempGsparray enumerateObjectsUsingBlock:^(NSString  * gspstr, NSUInteger idx, BOOL * _Nonnull stop2) {
            if ([obj.sku_id containsString:gspstr]) {
                isSuccess = YES;
            }else{
                isSuccess = NO;
                *stop2 = YES;
            }
            
        }];
        if (isSuccess) {
            /**如果没有有库存*/
            if (obj.stocks == nil || [obj.stocks isEqualToString:@""]) {
                block(NO,[NSString stringWithFormat:@"%.2f",[obj.price floatValue]],@"0",obj.sku_id);
            }else{
                block(YES,[NSString stringWithFormat:@"%.2f",[obj.price floatValue]],obj.stocks,obj.sku_id);
            }
            *stop1 = YES;
        }else{
            block(NO,[NSString stringWithFormat:@"%.2f",[obj.price floatValue]],@"0",obj.sku_id);
        }
    }];
    
    
    
    
//    NSDictionary * dic =  @{@"goodsId":self.model.goodsID,@"gsp":gspString,@"userId":kUserId?:@""};
//    [NetWork PostNetWorkWithUrl:@"/goods/getGoodsPriceByGsp" with:dic successBlock:^(NSDictionary *dic)
//     {
//         [HUDManager hideHUDView];
//         if ([dic[@"status"] boolValue])
//         {
//             NSString * string = [NSString stringWithFormat:@"%@",dic[@"data"][@"price"]];
//             NSString * string1 = [NSString stringWithFormat:@"%@",dic[@"data"][@"count"]];
//
//             block(YES,string,string1);
//         }
//         else
//         {
//             [HUDManager showWarningWithText:dic[@"message"]];
//             block(NO,dic[@"message"],@"0");
//         }
//     } errorBlock:^(NSString *error) {
//         [HUDManager showWarningWithText:error];
//         block(NO,error,error);
//         
//     }];


}
#pragma mark--PopNumberTableViewCellDelegate
-(void)numberOfgoods:(NSInteger)number
{
    [self.resultDic setValue:@(number) forKey:@"number"];
}



@end
