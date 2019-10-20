//
//  ShoppingCartTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "ShoppingButtonView.h"
#import "CartGoodsModel.h"

@interface ShoppingCartTableViewCell ()<ShoppingButtonViewDelegate>

@end

@implementation ShoppingCartTableViewCell

{
    ShoppingButtonView * shopview;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.goodsDetialImageView.layer.masksToBounds = YES;
    self.goodsDetialImageView.layer.cornerRadius =3;
    self.goodsDetialImageView.layer.borderWidth = 1;
    self.goodsDetialImageView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    self.isonlineLabel.text = LaguageControl(@"商品下架");
    self.priceLabel.textColor = kNavigationColor;
}


-(void)goodsLoadShoppingCartWithModel:(id)model andIndexPath:(NSIndexPath*)indexPath   ISselect:(BOOL)selected
{
    self.isonlineLabel.alpha = 0;

    CartGoodsModel * models = model;
    if ([models.goods_status isEqualToString:@"0"])
    {
        self.isonlineLabel.alpha = 0;
    }
    else
    {
        self.isonlineLabel.text = LaguageControl(@"商品下架");
        self.isonlineLabel.alpha = 1;
    }
    if ([models.goods_inventory integerValue]<1)
    {
        self.isonlineLabel.alpha = 1;
        self.isonlineLabel.text = LaguageControl(@"商品库存不足");
    }
    [self.goodsDetialImageView sd_setImageWithURL:[NSURL URLWithString:models.goodsUrl] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    self.indexPath = indexPath;
    self.seletedButton.selected = selected;
    self.goodsDescribtionLabel.text = models.goods_name;
    self.colorLabel.text = models.spec_info;
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@", [models.price caculateFloatValue]];
    shopview =[ShoppingButtonView loadShoppingButtonViewWithShoppingNumber:[models.count integerValue] frame:self.goodsView.bounds];
    //TODO: 商品库存数量
    [shopview SetCollectionNumber:[models.goods_inventory integerValue]];
    shopview.delegate = self;
    [self.goodsView addSubview:shopview];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)shoppingNumberChangeedvalue:(NSInteger )number{
    if ([self.delegate respondsToSelector:@selector(goodsNumberChangeedWith:withIndexPath:)]) {
        [self.delegate goodsNumberChangeedWith:[NSString stringWithFormat:@"%ld",(long)number] withIndexPath:self.indexPath];
    }
}
- (IBAction)goodsselected:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(goodsButtonSelected:withIndexPath:)]) {
        [self.delegate goodsButtonSelected:sender withIndexPath:self.indexPath];
    }
}

@end
