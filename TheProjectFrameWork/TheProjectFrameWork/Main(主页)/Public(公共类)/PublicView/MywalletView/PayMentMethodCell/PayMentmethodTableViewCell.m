//
//  PayMentmethodTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PayMentmethodTableViewCell.h"

#import "ImageViewDetialCollectionViewCell.h"

static NSString * itemIdentifier = @"ImageViewDetialCollectionViewCell";
@interface PayMentmethodTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation PayMentmethodTableViewCell

- (void)awakeFromNib {
    self.goodsDetialCollectionView.dataSource = self;
    self.goodsDetialCollectionView.delegate = self;
    [self.goodsDetialCollectionView registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark --
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewDetialCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    cell.goodsImageView.layer.masksToBounds = YES;
    cell.goodsImageView.layer.cornerRadius = 5;
    cell.goodsImageView.layer.borderWidth =1;
    cell.goodsImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.goodsImageView.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/4, collectionView.frame.size.height);
}
@end
