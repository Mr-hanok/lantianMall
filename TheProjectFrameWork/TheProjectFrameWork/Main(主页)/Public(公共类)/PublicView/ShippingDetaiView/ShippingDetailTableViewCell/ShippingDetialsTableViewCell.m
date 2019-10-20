//
//  ShippingDetialsTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShippingDetialsTableViewCell.h"
#import "ShippingCollectionViewCell.h"
#import "StoreOrderModel.h"

static NSString * ItemIdentifier = @"ShippingCollectionViewCell";
@interface ShippingDetialsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation ShippingDetialsTableViewCell

- (void)awakeFromNib
{
    self.ShippingCollectionView.delegate = self;
    self.ShippingCollectionView.dataSource = self;
    self.ShippingCollectionView.showsHorizontalScrollIndicator = FALSE;
    [self.ShippingCollectionView registerNib:[UINib nibWithNibName:ItemIdentifier bundle:nil] forCellWithReuseIdentifier:ItemIdentifier];
    self.dataArray = [NSMutableArray array];
    self.backImageView.backgroundColor = [UIColor lightGrayColor];
    NSString * string = [LaguageControl languageWithString:@"运费"];
    self.ShippingdetailsLabel.text = [NSString stringWithFormat:@"%@:%@",string,@"6:00"];
    // Initialization code
}
-(void)LoadDataWith:(id)model
{
    
    StoreOrderModel * themodel = model;
    self.shopNameLabel.text = themodel.storeName;
    if (themodel.sendtime.length)
    {
        self.ShippingdetailsLabel.text =[NSString stringWithFormat:@"%@(￥):%@",LaguageControl(@"运费"),[themodel.zoomPrice caculateFloatValue]];
    }
    else
    {
        self.ShippingdetailsLabel.text =[NSString stringWithFormat:@"%@(￥):%@",LaguageControl(@"运费"),[themodel.storeShipPrice caculateFloatValue]];

    }
    if (KScreenBoundWidth>320) {
        
    }
    else{
        self.ShippingdetailsLabel.font = KSystemFont(11);
    }
    if (themodel.goodsCarts.count)
    {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:themodel.goodsCarts];
    }
    [self.ShippingCollectionView reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsOrderModel * model = self.dataArray[indexPath.row];
    ShippingCollectionViewCell * cell= [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsUrl] placeholderImage:[UIImage imageNamed:@"defaultImgbanner"]];
    NSString * string =@"￥";
    cell.TaxdetailsLabel.text  = LaguageControlAppendStrings(string,[model.goodstaxes caculateFloatValue]);
     cell.TaxdetailsLabel.text  = @"";
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/3, collectionView.frame.size.height);
}


#pragma mark -- UICollectionViewDelegateFlowLayout

@end
