//
//  HomeTableOtherHeadSectionView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeTableOtherHeadSectionView.h"

#import "HomeHeadSectionViewCollectionViewCell.h"
#import "HomeFloorModel.h"
#import "HomeGoodsDetial.h"
#import "HomeModel.h"
#import "NSString+Calculate.h"
static NSString * itemIdentifier =@"HomeHeadSectionViewCollectionViewCell";


@interface HomeTableOtherHeadSectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HomeTableOtherHeadSectionView


-(void)loadViewWith:(id)model WithSection:(NSInteger)section
{
    HomeModel * models  = model;
    self.nameLabel.hidden = YES;
//    self.nameLabel.text = models.gf_name;
//    [self.titleBtn setTitle:models.gf_name?:@"" forState:UIControlStateNormal];
//    [self.titleBtn setBackgroundColor:kNavigationColor];
    self.section = section;
    if (!self.dataArray)
    {
        self.dataArray =[NSMutableArray array];
    }
    [self.homeTableOtherHeadSectionView registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    self.homeTableOtherHeadSectionView.delegate = self;
    self.homeTableOtherHeadSectionView.dataSource = self;
    if (models.childs.count) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:models.childs];
    
    [self.homeTableOtherHeadSectionView reloadData];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.homeTableOtherHeadSectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectsection inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

}

#pragma mark --UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeHeadSectionViewCollectionViewCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    HomeFloorModel * model = self.dataArray[indexPath.row];
    item.nameLabel.text = model.gf_name;
    
    item.nameLabel2.textColor = [UIColor clearColor];
    item.nameLabel2.text = model.gf_name;

    if (self.selectsection==indexPath.row)
    {
        item.nameLabel.textColor = kNavigationColor;
       

        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:model.gf_name];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:titleRange];
        [title addAttribute:NSUnderlineColorAttributeName value:kNavigationColor range:titleRange];

        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
//        item.nameLabel.attributedText = title;
        item.nameLabel2.attributedText = title;
        
    }
    else
    {
        item.nameLabel.textColor = kTextDeepDarkColor;
    }
    
    return item;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (KScreenBoundWidth>320) {
//        HomeFloorModel * model = self.dataArray[indexPath.row];
//
//        [NSString sizeWithString:model.gf_name font:[UIFont systemFontOfSize:13] maxHeight:15 maxWeight:300];
//        return CGSizeMake(collectionView.frame.size.width/5, collectionView.frame.size.height);
//    }
//    else{
//        return CGSizeMake(collectionView.frame.size.width/4, collectionView.frame.size.height);
//    }
    HomeFloorModel * model = self.dataArray[indexPath.row];
    float width = [NSString sizeWithString:model.gf_name font:[UIFont systemFontOfSize:13] maxHeight:15 maxWeight:300].width;
    return CGSizeMake(width+20, collectionView.frame.size.height);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(HomeTableViewHeadSectionViewDidSelectedWith:)]) {
        [self.delegate HomeTableViewHeadSectionViewDidSelectedWith:[NSIndexPath indexPathForRow:indexPath.row inSection:self.section]];
    }

}
- (IBAction)moreButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MorebuttonClicked:withSection:)]) {
        [self.delegate MorebuttonClicked:sender withSection:self.section];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
