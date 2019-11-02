//
//  ClassficationLeftTableViewCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2019/5/1.
//  Copyright © 2019 MapleDongSen. All rights reserved.
//

#import "ClassficationLeftTableViewCell.h"
#import "ClassficationDetailCollectionViewCell.h"
#import "ClassficationHeadCollectionReusableView.h"
#import "ClassGoodsViewController.h"
#import "GoodsDetialViewController.h"

/** DefaultItem */
static NSString * itemIndetifier = @"ClassficationDetailCollectionViewCell";
/** HeadView */
static NSString * headViewIndentifier = @"ClassficationHeadCollectionReusableView";
@interface ClassficationLeftTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ClassficationHeadCollectionReusableViewDelegate>


@end

@implementation ClassficationLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionview.backgroundView.backgroundColor  = [UIColor whiteColor];
    self.collectionview.layer.cornerRadius = 5.f;
    self.collectionview.layer.masksToBounds = YES;
    //注册collectionViewCell
    [self.collectionview registerNib:[UINib nibWithNibName:itemIndetifier bundle:nil] forCellWithReuseIdentifier:itemIndetifier];
    //注册collectionViewCellHeadView
    [self.collectionview registerNib:[UINib nibWithNibName:headViewIndentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIndentifier];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
}
- (void)configCellWithModel:(HomeClassModel *)model{
    _tableSelModel = model;
    [_collectionview reloadData];
}
#pragma mark--UICollectionViewDataSource&&UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.tableSelModel.childrens.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    HomeClassModel *model = self.tableSelModel.childrens[section];
    return model.childrens.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassficationDetailCollectionViewCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIndetifier forIndexPath:indexPath];
    HomeClassModel *sectionmodel = self.tableSelModel.childrens[indexPath.section];
    HomeClassModel *rowmodel = sectionmodel.childrens[indexPath.row];
//    NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
    [item.detialImageView sd_setImageWithURL:[NSURL URLWithString:rowmodel.icon_img] placeholderImage:[UIImage imageNamed:kDefaultLifeImgV11]];
    item.detialContentLabel.text = rowmodel.goodsName ?: @"";
    if (KScreenBoundWidth <=320) {
        item.detialContentLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return item;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeClassModel *sectionmodel = self.tableSelModel.childrens[indexPath.section];
    HomeClassModel *rowmodel = sectionmodel.childrens[indexPath.row];
    
    ClassGoodsViewController * goods = [[ClassGoodsViewController alloc] init];
    goods.goodName = rowmodel.goodsName;
    goods.title = rowmodel.goodsName;
    goods.goodID = rowmodel.goodsID;
    goods.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:goods animated:YES];
    
}
#pragma mark--UICollectionViewDelegateFlowLayout

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"])
    {
        ClassficationHeadCollectionReusableView * headerView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headViewIndentifier forIndexPath:indexPath];
        HomeClassModel *sectionmodel = self.tableSelModel.childrens[indexPath.section];
        headerView.detailContentlabel.text = sectionmodel.goodsName;
        
        [headerView loadClassficationHeadViewWithSection:indexPath.section];
        headerView.delegate = self;
        return headerView;
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (KSCREEN_WIDTH==320) {
        return CGSizeMake((KSCREEN_WIDTH-120*320/375.0-20-40)/3.0, (KSCREEN_WIDTH-120*320/375.0-20-40)/3.0+60);
    }
    return CGSizeMake((KSCREEN_WIDTH-120-20-40)/3.0, (KSCREEN_WIDTH-120-20-40)/3.0+45);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
   
    return CGSizeMake(self.collectionview.frame.size.width, 40);
    
}

#pragma mark --ClassficationHeadCollectionReusableViewDelegate
-(void)ClassficationHeadCollectionReusableViewDeatialistClickWithseciton:(NSInteger)section{
    
    HomeClassModel * model = self.tableSelModel.childrens[section];
    
    
}
#pragma mark -ClassfiactionHeadTypeImageCollectionReusableViewDelegate
-(void)ClassfiactionHeadTypeImageCollectionReusableViewClickedWithindexPath:(NSIndexPath *)index
{
    GoodsDetialViewController *detialVC = [[GoodsDetialViewController alloc] init];
    detialVC.hidesBottomBarWhenPushed= YES;
    [self.vc.navigationController pushViewController:detialVC animated:YES];
    
}


-(void)ClassfiactionHeadClassBtnClickWithIndexpath:(NSIndexPath *)index{
    
}



@end
