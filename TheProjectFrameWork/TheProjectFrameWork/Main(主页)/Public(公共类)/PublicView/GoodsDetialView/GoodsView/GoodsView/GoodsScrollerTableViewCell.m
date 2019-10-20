//
//  GoodsScrollerTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsScrollerTableViewCell.h"
#import "GoodsDetialModel.h"

@interface GoodsScrollerTableViewCell ()<UIScrollViewDelegate>


@end



@implementation GoodsScrollerTableViewCell

- (void)awakeFromNib
{
    if (KScreenBoundWidth>320)
    {
        self.productInfoLabel.font = KSystemFont(13);
        self.productNumberLabel.font = KSystemFont(11);
        self.productnumber.font = KSystemFont(11);
        self.productDimensionsLabel.font = KSystemFont(11);
        self.productDimens.font = KSystemFont(11);
        self.weightLabel.font = KSystemFont(11);
        self.weight.font = KSystemFont(11);
        self.brandLabel.font = KSystemFont(11);
        self.brand.font = KSystemFont(11);
    }
    else
    {
        self.productInfoLabel.font = KSystemFont(11);
        self.productNumberLabel.font = KSystemFont(9);
        self.productnumber.font = KSystemFont(9);
        self.productDimensionsLabel.font = KSystemFont(9);
        self.productDimens.font = KSystemFont(9);
        self.weightLabel.font = KSystemFont(9);
        self.weight.font = KSystemFont(9);
        self.brandLabel.font = KSystemFont(9);
        self.brand.font = KSystemFont(9);
    }
    
    self.productNumberLabel.text =LaguageControl(@"商品编号");
    self.brandLabel.text =LaguageControl(@"品牌");
    self.weightLabel.text =LaguageControl(@"重量");
    self.productDimensionsLabel.text =LaguageControl(@"体积");



    // Initialization code
}
-(void)loadScrollerViewWithmodel:(GoodsDetialModel*)model
{
    self.productnumber.text = model.goods_serial?:@"";
    self.brand.text =model.goods_brand_name?:@"";
    NSString * weight = [NSString stringWithFormat:@"%@kg",model.goods_weight?:@""];
    
    self.weight.text =weight;
    NSString *product =[NSString stringWithFormat:@"%@cm*%@cm*%@cm",model.goods_length?:@"",model.goods_width?:@"",model.goods_height?:@""];
    self.productDimens.text =product;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
