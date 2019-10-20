//
//  EvaluationFootView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvaluationFootView.h"
#import "ImageCollectionViewCell.h"

static NSString * ItemIdentifier =@"ImageCollectionViewCell";

@interface EvaluationFootView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end


@implementation EvaluationFootView
-(void)loadCollectionView
{
    [self.footCollectionView registerNib:[UINib nibWithNibName:ItemIdentifier bundle:nil] forCellWithReuseIdentifier:ItemIdentifier];
    self.footCollectionView.delegate = self;
    self.footCollectionView.dataSource = self;
    self.dataArray = [NSMutableArray array];
}

-(void)LoadDataWithArray:(NSArray*)array
{
    [self.dataArray addObjectsFromArray:array];
}
#pragma mark --UICollectionViewDelegate && UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
    cell.evaluationImageView.layer.masksToBounds = YES;
    cell.evaluationImageView.layer.cornerRadius =1;
    cell.evaluationImageView.layer.borderWidth = 0.5;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/4, collectionView.frame.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
