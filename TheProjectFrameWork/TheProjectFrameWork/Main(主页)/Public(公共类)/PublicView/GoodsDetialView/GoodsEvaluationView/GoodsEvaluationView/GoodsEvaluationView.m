//
//  GoodsEvaluationView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsEvaluationView.h"
#import "GoodsEvaluationCollectionViewCell.h"
#import "EvalutaionTypeContentTableViewCell.h"
#import "EvalutaionTypeContentAndImageTableViewCell.h"
#import "EvaluationDetailsVCViewController.h"
#import "GoodsEvaluationModel.h"
static NSString * itemIdentifier = @"GoodsEvaluationCollectionViewCell";
static NSString * cellCollectionIdentifier = @"EvalutaionTypeContentAndImageTableViewCell";
static NSString * cellIdentifier = @"EvalutaionTypeContentTableViewCell";

@interface GoodsEvaluationView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EvalutaionTypeContentTableViewCellDelegate>
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;
/** 头部视图 */
@property(strong,nonatomic) NSMutableArray * topArray;
/** 页数 */
@property(assign,nonatomic) NSInteger begin;
/** 商品ID */
@property(strong,nonatomic) NSString * goodsID;
/** 获取评论内容 */
@property(strong,nonatomic) NSString * CommentString;

@property(strong,nonatomic) NSDictionary * commentDic;

@property(strong,nonatomic) NSMutableArray * commentdataArray;

@end

@implementation GoodsEvaluationView

+(id)loadView
{
    GoodsEvaluationView * view = [super loadView];
    view.topArray = [NSMutableArray arrayWithObjects:@"所有评论",@"好评",@"中评",@"差评", nil];
    view.begin = 1;
    [view.topCollectionView registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    view.topCollectionView.delegate = view;
    view.topCollectionView.dataSource = view;
    view.commentsTableView.delegate = view;
    view.commentsTableView.dataSource = view;
    view.commentdataArray =[NSMutableArray array];
    [view updataNewData:view.commentsTableView];
    return view;
}

-(void)loadDatawith:(NSString*)goodsId
{
    if (!self.goodsID)
    {
        self.goodsID = goodsId;
    }
    self.ishowed = YES;
    [self NetWorkWith];
}

/**
 *  获取评论数量
 */
-(void)NetWork
{

    NSDictionary * dic = @{@"goods_id":self.goodsID};
    [NetWork PostNetWorkWithUrl:@"/evaluate/evalCountByGoodsId" with:dic successBlock:^(NSDictionary *dic)
    {
        if ([dic[@"status"] boolValue ])
        {
            self.commentDic = dic[@"data"];
            [self.topCollectionView reloadData];
            [self.topCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];

        }
    } errorBlock:^(NSString *error)
    {
        
    }];
}
-(void)SetGoodIDWithString:(NSString*)goodsID
{
    self.goodsID = goodsID;
    /** 获取评论数量 */
    [self NetWork];
}

/**
 *  获取商品评论内容
 */
-(void)NetWorkWith
{
    if (!self.goodsID) {
        return;
    }
    [HUDManager showLoadingHUDView:self];
    NSString * beginPage = @"1";
    beginPage = [NSString stringWithFormat:@"%ld",(long)self.begin];
    NSDictionary * dic = @{@"currentPage":beginPage,
                           @"goods_id":self.goodsID,
                           @"max":@"100",
                           };
    if (self.CommentString)
    {
        if ([self.CommentString isEqualToString:@"1"]) {
            dic = @{@"currentPage":beginPage,
                    @"goods_id":self.goodsID,
                    @"max":@"100",
                    @"ebv":@"1",
                    };
        }else if ([self.CommentString isEqualToString:@"0"])
        {
            dic = @{@"currentPage":beginPage,
                    @"goods_id":self.goodsID,
                    @"max":@"100",
                    @"ebv":@"0",
                    };
        }
        else if ([self.CommentString isEqualToString:@"-1"]){
            dic = @{@"currentPage":beginPage,
                    @"goods_id":self.goodsID,
                    @"max":@"100",
                    @"ebv":@"-1",
                    };
        }
        
    }
    [NetWork PostNetWorkWithUrl:@"/evaluate/list_EvaluateByGoods" with:dic successBlock:^(NSDictionary *dic)
    {
        //TODO: 中评为0 需要判断
        if ([dic[@"status"] boolValue])
        {
            if (self.begin==1)
            {
                [self.commentdataArray removeAllObjects];
            }
            NSArray * array =[GoodsEvaluationModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"goodsInfo"]];
            [self.commentdataArray addObjectsFromArray:array];
            [self.commentsTableView showNoView:@"没有评价~" image:[UIImage imageNamed:@"no_pinjia"] certer:CGPointZero isShow:!self.commentdataArray.count];
            [self.commentsTableView reloadData];
        }
        [HUDManager hideHUDView];
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
    }];
    
}
#pragma mark --UITableViewDelegate &&UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.commentdataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsEvaluationModel * model = self.commentdataArray[indexPath.section];
    if (!model.imag1.length)
    {
        EvalutaionTypeContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
            cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        [cell LoadData:model WithIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    else{
        EvalutaionTypeContentAndImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellCollectionIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:cellCollectionIdentifier bundle:nil] forCellReuseIdentifier:cellCollectionIdentifier];
            cell =[tableView dequeueReusableCellWithIdentifier:cellCollectionIdentifier];
        }
        NSMutableArray * array = [NSMutableArray array];
        if (model.imag1.length) {
            [array addObject:model.imag1];
        }
        if (model.imag2.length) {
            [array addObject:model.imag2];
        }
        if (model.imag3.length) {
            [array addObject:model.imag3];
        }
        [cell LoadData:model WithIndexPath:indexPath With:array];
        cell.delegate = self;
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsEvaluationModel * model = self.commentdataArray[indexPath.section];
    CGSize cellSize = [NSString sizeWithString:model.evaluateInfo font:KSystemFont(15) maxHeight:100 maxWeight:KScreenBoundWidth-60];
    if (!model.imag1.length)
    {
        return cellSize.height+120;
    }
    else
    {
        return cellSize.height+220;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsEvaluationModel * model = self.commentdataArray[indexPath.section];
    EvaluationDetailsVCViewController * view = [[EvaluationDetailsVCViewController alloc] init];
    view.evaluationID = model.evaluationID;
    view.models = model;
    [self.ViewController.navigationController pushViewController:view animated:YES];
}

#pragma mark --UICollectionViewDataSource &&UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.topArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsEvaluationCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    cell.titleLabel.text =[LaguageControl languageWithString:self.topArray[indexPath.row]];
    if (KScreenBoundWidth>320)
    {
    }
    else
    {
        cell.titleLabel.font = KSystemFont(11);
        cell.numberLabel.font = KSystemFont(11);
    }
    NSString * str = @"0";
    if (self.commentDic&&![self.commentDic isEqual:[NSNull null]])
    {
        switch (indexPath.row) {
            case 0:
                if (self.commentDic[@"ALLCOUNT"])
                {
                    str = [NSString stringWithFormat:@"%@",self.commentDic[@"ALLCOUNT"]];
                }
                break;
            case 1:
                if (self.commentDic[@"HPCOUNT"])
                {
                    str = [NSString stringWithFormat:@"%@",self.commentDic[@"HPCOUNT"]];
                }
                break;
            case 2:
                if (self.commentDic[@"ZPCOUNT"])
                {
                    str = [NSString stringWithFormat:@"%@",self.commentDic[@"ZPCOUNT"]];
                }
                break;
            case 3:
                if (self.commentDic[@"CPCOUNT"])
                {
                    str = [NSString stringWithFormat:@"%@",self.commentDic[@"CPCOUNT"]];
                }
                break;
                
            default:
                break;
        }
    }
    cell.numberLabel.text = str;
    cell.titleLabel.highlightedTextColor = kNavigationColor;
    cell.numberLabel.highlightedTextColor = kNavigationColor;
    return cell;
}
#pragma mark--UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/4, collectionView.frame.size.height);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row)
    {
        case 0:
            self.CommentString= @"2";
            break;
        case 1:
            self.CommentString= @"1";

            break;
        case 2:
            self.CommentString= @"0";

            break;
        case 3:
            self.CommentString= @"-1";
            break;
        default:
            break;
    }
    [self NetWorkWith];
}
#pragma mark--EvalutaionTypeContentTableViewCellDelegate
-(void)EvalutaionTypeContentTableViewCellthumbUpButton:(UIButton *)button WithIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)EvalutaionTypeContentTableViewCellEvaluationClickedWithIndexPath:(NSIndexPath *)indexPath
{

}


@end
