//
//  HomeTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeCollectionViewCell.h"
#import "HomeGoodsDetial.h"
#import "HomeGoodsCollectionViewCell.h"
#import "HomeGoodsHorizontalCollectionViewCell.h"

static NSString * itemIdentifier = @"HomeGoodsCollectionViewCell";
static NSString * itemHorizontalIdentifier = @"HomeGoodsHorizontalCollectionViewCell";

@interface HomeTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) NSMutableArray * dataarray;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end


@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.dataarray = [NSMutableArray array];
    [self.detialCollectionView registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    [self.detialCollectionView registerNib:[UINib nibWithNibName:itemHorizontalIdentifier bundle:nil] forCellWithReuseIdentifier:itemHorizontalIdentifier];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 2, 1, 2);
    self.flowLayout = flowLayout;
    self.detialCollectionView.delegate = self;
    self.detialCollectionView.dataSource = self;
}

-(void)loadCollectionViewWith:(NSArray*)array withSection:(NSInteger)section{
    self.section = section;
    [self.dataarray removeAllObjects];
    [self.dataarray addObjectsFromArray:array];
    // 设置UICollectionView为横向滚动
    self.flowLayout.scrollDirection = section == 0 ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
    self.detialCollectionView.scrollEnabled = section == 0 ? YES : NO;
    self.detialCollectionView.collectionViewLayout = self.flowLayout;
    
    [self.detialCollectionView reloadData];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark --UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 8;
    return MIN(8, self.dataarray.count);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    HomeGoodsDetial * model = self.dataarray[indexPath.row];
//    HomeCollectionViewCell  * item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
//    item.preferentialPriceLabelHegiht.constant = 20;
//
//    NSString * theprice = [NSString stringWithFormat:@"%.2f",[model.goodsPrice floatValue]];
//    NSString * string = [NSString stringWithFormat:@"￥ %@", theprice];
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
//    [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
//                          value:[NSNumber  numberWithInteger:1]
//                          range:NSMakeRange(0,AttributedStr.length)];
//    item.goodsPreferentialPriceLabel.attributedText = AttributedStr;
//    item.goodsNameLabel.text = model.goodsName;
//    NSString * price = model.storePrice;
//
//    item.pricesLabel.text =[NSString stringWithFormat:@"￥ %@", [NSString stringWithFormat:@"%.2f",[price floatValue]]];
//    if ([model.goodsPrice floatValue]==[model.storePrice floatValue])
//    {
//        item.goodsPreferentialPriceLabel.alpha =0;
//    }
//    else{
//        item.goodsPreferentialPriceLabel.alpha =1;
//    }
//
//    [item.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    
    if (self.section == 0) {
        HomeGoodsHorizontalCollectionViewCell  * item = [collectionView dequeueReusableCellWithReuseIdentifier:itemHorizontalIdentifier forIndexPath:indexPath];
        NSString * theprice = [NSString stringWithFormat:@"%.2f",[model.goodsPrice floatValue]];
        NSString * string = [NSString stringWithFormat:@"￥%@", theprice];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
                              value:[NSNumber  numberWithInteger:1]
                              range:NSMakeRange(0,AttributedStr.length)];
        item.oldPriceLabel.attributedText = AttributedStr;
        
        NSString * price = model.storePrice;
        item.currentPriceLabel.text =[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%.2f",[price floatValue]]];
        if ([model.goodsPrice floatValue]==[model.storePrice floatValue])
        {
            item.oldPriceLabel.hidden = YES;
        }
        else{
            item.oldPriceLabel.hidden = NO;
        }
        [item.goodsIV sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
        return item;
    }else{
        HomeGoodsCollectionViewCell  * item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
        
        
        NSString * theprice = [NSString stringWithFormat:@"%.2f",[model.goodsPrice floatValue]];
        if ([model.goodsPrice floatValue]>10000) {
            theprice = [NSString stringWithFormat:@"%.2f万",[model.goodsPrice floatValue]/10000];

        }
        NSString * string = [NSString stringWithFormat:@"￥%@", theprice];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
                              value:[NSNumber  numberWithInteger:1]
                              range:NSMakeRange(0,AttributedStr.length)];
        item.oldPriceLabel.attributedText = AttributedStr;
        item.goodsNameLabel.text = model.goodsName;
        
        NSString * price = model.storePrice;
        if ([model.storePrice floatValue]>10000) {
            price = [NSString stringWithFormat:@"%.2f万",[price floatValue]/10000];
            item.currentPriceLabel.text =[NSString stringWithFormat:@"%@", price];

        }else{
            item.currentPriceLabel.text =[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%.2f", [price floatValue]]];

        }
        
        if ([model.goodsPrice floatValue]==[model.storePrice floatValue])
        {
            item.oldPriceLabel.hidden = YES;
        }
        else{
            item.oldPriceLabel.hidden = NO;
        }
        if (model.activity_tag && ![model.activity_tag isEqualToString:@""]) {
            item.activityLabel.text = model.activity_tag;
            item.activityLabel.hidden = NO;
        }else{
            item.activityLabel.hidden = YES;
        }
        [item.goodIV sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
        return item;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.section == 0) {
        return CGSizeMake((KScreenBoundWidth-4)/3.0f+20, (KScreenBoundWidth-4)/3.0f+20);
    }
    return CGSizeMake((KScreenBoundWidth-4)/2.0f, (KScreenBoundWidth-4)/2.0f+70);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(HomeTableViewCellDidSelected:withmodel:)])
    {
        
        if (indexPath.row<self.dataarray.count)
        {
            [self.delegate HomeTableViewCellDidSelected:[NSIndexPath indexPathForRow:indexPath.row inSection:self.section] withmodel:self.dataarray[indexPath.row]];
        }
    }
}

@end
