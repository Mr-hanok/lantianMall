//
//  OrderTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderGoodsModel.h"
#import "DetialOrderGoodsModel.h"
#import "GoodsOrderModel.h"

@implementation OrderTableViewCell

- (void)awakeFromNib
{    
//    self.contentBackView.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1];
    self.numberLabel.textColor = self.sellPriceLabel.textColor= kNavigationColor;
    [self.applyforRefundButton setTitle:LaguageControl(@"买家申请退款") forState:UIControlStateNormal];
    CGSize size = [NSString sizeWithString:LaguageControl(@"买家申请退款") font:KSystemFont(15) maxHeight:30 maxWeight:KScreenBoundWidth];
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.goodsnameLabel.font = KSystemFont(11);
        self.numberLabel.font = KSystemFont(11);
        self.specInfoLabel.font = KSystemFont(11);
        self.applyforRefundButton.titleLabel.font =KSystemFont(13);
    }
    self.buttonWidth.constant = size.width+10;
}


-(void)loadData:(id)model andindex:(NSIndexPath*)index withSellerTypes:(SellerOrderTypes)types
{
    
    self.indexPath =index;
    if (types==SellerOrderTypesSuccess)
    {
          self.applyforRefundButton.alpha = 1;
    }

}
-(void)loadCartData:(id)model andindex:(NSIndexPath*)index
{
      GoodsOrderModel * models = model;
    self.indexPath = index;
    self.goodsnameLabel.text = models.goods_name;
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:models.goodsUrl] placeholderImage:[UIImage imageNamed:@"defaultImgbanner"]];
    self.sellPriceLabel.text =[NSString stringWithFormat:@"￥ %.2f",[models.price floatValue]];
    self.numberLabel.text =[NSString stringWithFormat:@"x %@",models.count];
    self.specInfoLabel.text = models.spec_info;
}
-(void)loadOrderData:(id)model andindex:(NSIndexPath*)index
{
    
    DetialOrderGoodsModel * models = model;
    self.indexPath = index;
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.goodsnameLabel.font = KSystemFont(11);
        self.numberLabel.font = KSystemFont(11);
        self.specInfoLabel.font = KSystemFont(11);
    }
    self.goodsnameLabel.text = models.goods_name;
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:models.goodsUrl] placeholderImage:[UIImage imageNamed:@"defaultImgbanner"]];
    self.sellPriceLabel.text =[NSString stringWithFormat:@"￥ %.2f",[models.price floatValue]];
    self.numberLabel.text =[NSString stringWithFormat:@"x %@",models.count];
    self.specInfoLabel.text = models.spec_info;}

-(void)loadData:(id)model andindex:(NSIndexPath*)index
{
    OrderGoodsModel * models = model;
    self.indexPath = index;
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.goodsnameLabel.font = KSystemFont(11);
        self.numberLabel.font = KSystemFont(11);
        self.specInfoLabel.font = KSystemFont(11);
    }
    self.goodsnameLabel.text = models.goodsName;
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:models.goodsMainPhotos] placeholderImage:[UIImage imageNamed:@"defaultImgbanner"]];
    self.sellPriceLabel.text = [NSString stringWithFormat:@"￥ %.2f", [models.gcPrice floatValue]] ;
    self.numberLabel.text = [NSString stringWithFormat:@"x %@",models.count];
    self.specInfoLabel.text = models.specInfo;
    
}
- (IBAction)applyForButtonClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(OrderTableViewCellApplyforRefundButton:withIndex:)]) {
        [self.delegate OrderTableViewCellApplyforRefundButton:sender withIndex:self.indexPath];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
