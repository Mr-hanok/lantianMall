//
//  ConstTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ConstTableViewCell.h"
#import "OrderDetialModel.h"

@implementation ConstTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.payPriceLabel.textColor = kNavigationColor;
    self.CommoditypriceLabel.text = LaguageControlAppend(@"商品总价");
    self.ThefreightLabel.text = LaguageControlAppend(@"运费");

//    self.TaxesandfeesLabel.text = LaguageControl(@"税费");
    self.RealpaymentLabel.text = LaguageControlAppend(@"实付款");
    self.MembershipgradeLabel.text = LaguageControlAppend(@"会员等级");
    self.MembershipdetailsLabel.text = LaguageControlAppend(@"普通会员");
    
    if (!kIsHaveCoupon) {
        self.mallViewHeight.constant = self.shopViewHeight.constant = self.manJianViewHeight.constant = 0;
        self.TaxesandfeesLabel.hidden = self.taxesPriceLabel.hidden = self.mallVipLabel.hidden = self.mallVipPriceLabel.hidden = self.shopVipLabel.hidden = self.shopVipPriceLabel.hidden = YES;
    }else{
        
    }
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.CommoditypriceLabel.font = KSystemFont(11);
        self.ThefreightLabel.font = KSystemFont(11);
        self.TaxesandfeesLabel.font = KSystemFont(11);
        self.RealpaymentLabel.font = KSystemFont(11);
        self.MembershipgradeLabel.font = KSystemFont(11);
        self.MembershipdetailsLabel.font = KSystemFont(11);
        self.MembershipdetailsLabel.font = KSystemFont(11);
        self.totalPriceLabel.font = KSystemFont(11);
        self.shipPriceLabel.font = KSystemFont(11);
        self.taxesPriceLabel.font = KSystemFont(11);
        self.payPriceLabel.font = KSystemFont(11);
    }

    // Initialization code
}
-(void)LoadDataWith:(id)model andisSeller:(BOOL)seller
{
    OrderDetialModel * models = model;
    if (kIsHaveCoupon) {
        if ([models.fullcutPrice floatValue]== 0) {
            self.taxesPriceLabel.text  = [NSString stringWithFormat:@"￥%@", [models.fullcutPrice caculateFloatValue]];

        }else{
            self.taxesPriceLabel.text  = [NSString stringWithFormat:@"- ￥%@", [models.fullcutPrice caculateFloatValue]];

        }
        if ([models.mall_coupon_amount floatValue] == 0) {
            self.mallVipPriceLabel.text  = [NSString stringWithFormat:@"￥%@", [models.mall_coupon_amount caculateFloatValue]];

        }else{
            self.mallVipPriceLabel.text  = [NSString stringWithFormat:@"- ￥%@", [models.mall_coupon_amount caculateFloatValue]];

        }
        if ([models.store_coupon_amount floatValue]== 0) {
            self.shopVipPriceLabel.text  = [NSString stringWithFormat:@"￥%@", [models.store_coupon_amount caculateFloatValue]];

        }else{
            self.shopVipPriceLabel.text  = [NSString stringWithFormat:@"- ￥%@", [models.store_coupon_amount caculateFloatValue]];
 
        }

    }
   
    if ([models.userGrade isEqualToString:@"1"])
    {
        self.MembershipdetailsLabel.text = LaguageControl(@"游客");
    }
    else if ([models.userGrade isEqualToString:@"2"])
    {
        self.MembershipdetailsLabel.text = LaguageControl(@"普通会员");
    }
    else if ([models.userGrade isEqualToString:@"3"])
    {
        self.MembershipdetailsLabel.text = LaguageControl(@"VIP members");
    }else if ([models.userGrade isEqualToString:@"4"])
    {
        self.MembershipdetailsLabel.text = LaguageControl(@"O2O User");
    }
    else
    {
        self.MembershipdetailsLabel.text = LaguageControl(@"游客");
    }
    self.totalPriceLabel.text =[NSString stringWithFormat:@"￥ %@", [models.totalPrice caculateFloatValue]];
    self.shipPriceLabel.text = [NSString stringWithFormat:@"￥ %@",[models.actual_Shipment caculateFloatValue]];
//    self.taxesPriceLabel.text = [NSString stringWithFormat:@"￥ %@", [models.taxes caculateFloatValue]];
    self.payPriceLabel.text = [NSString stringWithFormat:@"￥ %@", [models.disbursements caculateFloatValue]];
    if (seller) {
        self.VipHeight.constant = 0;
    }
    else{
        self.VipHeight.constant = 0;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
