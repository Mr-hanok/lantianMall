//
//  SerachStoreTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SerachStoreTableViewCell.h"
#import "SearchCollectionViewCell.h"
#import "SearchModel.h"

static NSString * ItemIdentfier = @"SearchCollectionViewCell";

@interface SerachStoreTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) NSArray * dataArray;
@end

@implementation SerachStoreTableViewCell

- (void)awakeFromNib
{
    [self.goodsCollectionView registerNib:[UINib nibWithNibName:ItemIdentfier bundle:nil] forCellWithReuseIdentifier:ItemIdentfier];
    self.comeInButton.layer.masksToBounds = YES;
    self.comeInButton.layer.cornerRadius = 3;
    self.comeInButton.layer.borderColor = kNavigationCGColor;
    self.comeInButton.layer.borderWidth = 1;
    self.goodsCollectionView.delegate = self;
    self.goodsCollectionView.dataSource =self;
     int m = (KScreenBoundWidth-10)/3;
    self.collectionViewWidth.constant =3*m;
//    SearchShopCellLayout *layout =[SearchShopCellLayout new];
//    self.goodsCollectionView.
//    self.goodsCollectionView.collectionViewLayout = layout;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)comeButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(SerachStoreTableViewCellComeToStore:)]) {
        [self.delegate SerachStoreTableViewCellComeToStore:self.indexPath.section];
    }
}

-(void)loadData:(id)model WithArray:(NSArray *)array andIndex:(NSIndexPath *)index
{
    SearchModel * models = model;
    self.storeName.text = models.storename;
    NSString * string = LaguageControl(@"关注");
    self.FocusonNumberLabel.text = [NSString stringWithFormat:@"%@%@",models.favorite_count,string];
    self.dataArray = array;
    [self.stroeImageView sd_setImageWithURL:[NSURL URLWithString:models.store_logo] placeholderImage:[UIImage imageNamed:@"defaultImgbanner"]];
    self.indexPath = index;
    [self.goodsCollectionView reloadData];
    [self.comeInButton setTitle:LaguageControl(@"进店") forState:UIControlStateNormal];
}
#pragma mark --UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = self.dataArray[indexPath.row];

    SearchCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentfier forIndexPath:indexPath];
    [cell.collectionImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"goods_photo"]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    NSString *price = [NSString stringWithFormat:@"%@", dic[@"goods_price"]];
    cell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥ %@", [price caculateFloatValue]];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.dataArray[indexPath.row];
    if([_delegate respondsToSelector:@selector(serachStoreTableVIewCell:goods_id:)])
    {
        [_delegate serachStoreTableVIewCell:self goods_id:[dic[@"goods_id"] stringValue]];
    }
}
#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width)/3, collectionView.frame.size.width/3 - 2);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
 
    return 0;
}

@end


