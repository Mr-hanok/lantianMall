//
//  GoodsImageTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsImageTableViewCell.h"
//#import "ImageViewDetialCollectionViewCell.h"
//static NSString * ItemIdentifier = @"ImageViewDetialCollectionViewCell";
@interface GoodsImageTableViewCell ()
//<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation GoodsImageTableViewCell

- (void)awakeFromNib {
//    self.goodsImageCollectionView.dataSource = self;
//    self.goodsImageCollectionView.delegate = self;
//    [self.goodsImageCollectionView registerNib:[UINib nibWithNibName:ItemIdentifier bundle:nil] forCellWithReuseIdentifier:ItemIdentifier];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
#pragma mark --UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewDetialCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, 200);
}
*/

@end
