//
//  PopShopTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopShopTableViewCell.h"
#import "PopShopCollectionViewCell.h"
#import "ParameterDetialModel.h"
#import "UICollectionViewLeftAlignedLayout.h"
static NSString * itemIdentifier = @"PopShopCollectionViewCell";

@interface PopShopTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateLeftAlignedLayout>
@property (nonatomic, copy) NSString *type;
@end

@implementation PopShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.popShoptableViewCell.delegate = self;
    self.popShoptableViewCell.dataSource = self;
    self.dataArray = [NSMutableArray array];

    [self.popShoptableViewCell registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    UICollectionViewLeftAlignedLayout *layout = [UICollectionViewLeftAlignedLayout new];
    [layout setSectionInset:UIEdgeInsetsMake(5, 10, 5, 10)];
    [self.popShoptableViewCell setCollectionViewLayout:layout animated:NO completion:^(BOOL finished) {
        
    }];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadCollectionViewWith:(NSArray*)array WithSection:(NSInteger)section type:(NSString *)type
{
    self.section = section;
    self.type = type;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self.popShoptableViewCell reloadData];
}

#pragma mark --UICollectionViewDataSource && UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PopShopCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    ParameterDetialModel * model = self.dataArray[indexPath.row];
    cell.selected =model.ISSelecteD;
    if ([self.type isEqualToString:@"img"]) {
        cell.contentLabel.hidden =YES;
        [cell.selectedIamgeView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:kDefaultGoodsDetail]];
        
    }else{
        cell.contentLabel.text = model.parameterDetialValues;
        cell.contentLabel.hidden =NO;
    }
    if (KScreenBoundWidth>320)
    {
        cell.contentLabel.font = KSystemFont(12);
    }
    else
    {
        cell.contentLabel.font = KSystemFont(11);
    }
    
    return cell;
}
#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
       ParameterDetialModel * model = self.dataArray[indexPath.row];
    if ([self.type isEqualToString:@"img"]) {
        return CGSizeMake(35, 35);

    }else{
        CGSize m  = [NSString sizeWithString:model.parameterDetialValues font:[UIFont systemFontOfSize:kAppAsiaFontSize(13)] maxHeight:30 maxWeight:collectionView.frame.size.width];
        if (m.width>collectionView.frame.size.width/2)
        {
            return CGSizeMake(m.width, 30);
        }
        else
        {
            if (m.width>collectionView.frame.size.width/4)
            {
                return CGSizeMake(m.width+10, 30);
            }
            return CGSizeMake(m.width+30, 30);
        }
    }
    
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 10, 5, 10);
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectedwith:PopShopTableViewCell:)])
    {
        [self.delegate didSelectedwith:[NSIndexPath indexPathForRow:indexPath.row inSection:self.section] PopShopTableViewCell:self];
    }
}

@end
