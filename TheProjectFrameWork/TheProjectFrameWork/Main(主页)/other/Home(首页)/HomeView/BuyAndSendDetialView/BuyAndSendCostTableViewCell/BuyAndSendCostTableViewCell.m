//
//  BuyAndSendCostTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyAndSendCostTableViewCell.h"

@implementation BuyAndSendCostTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (!kIsHaveCoupon) {
        self.bottomline.hidden = self.bottomLine2.hidden = self.bottomline3.hidden = self.manjianLabel.hidden = self.manJianMoneyLabel.hidden = self.viplabel.hidden = self.vipPriceMoneyLabel.hidden = self.selvippricebtn.hidden = self.selvippriceLabel.hidden = YES;
        self.selvipbtnHeight.constant = self.manjianLabelHeigth.constant = self.viplabelHeight.constant = 0;
    }
    
    self.companyBtn.layer.cornerRadius = 5.f;
    self.companyBtn.layer.masksToBounds = YES;
    self.companyBtn.layer.borderWidth = .8f;
    self.companyBtn.layer.borderColor = kTextDeepDarkColor.CGColor;
    self.personBtn.layer.cornerRadius = 5.f;
    self.personBtn.layer.masksToBounds = YES;
    self.personBtn.layer.borderWidth = .8f;
    self.personBtn.layer.borderColor = kTextDeepDarkColor.CGColor;
    [self.companyBtn setTitleColor:kNavigationColor forState:UIControlStateSelected];
    [self.personBtn setTitleColor:kNavigationColor forState:UIControlStateSelected];
    self.kaifapiaoLabel.text = @"";
    
    self.fapiaotypeLabel.alpha = self.companyBtn.alpha = self.personBtn.alpha = self.taxnumView.alpha = 0;
    self.fapiaoviewheight.constant = 44;
    self.fapiaotypeLabelHeight.constant = 0;
    self.taxnumviewheight.constant = 0;

    
    
    self.totalLabel.textColor = self.shipLabel.textColor = self.manJianMoneyLabel.textColor = self.vipPriceMoneyLabel.textColor = self.selvippriceLabel.textColor = kNavigationColor;
    [self.selvippricebtn setTitleColor:kNavigationColor forState:UIControlStateNormal];
    self.amountgoodsLabel.text = @"商品金额";
    self.salestaxLabel.text = [LaguageControl languageWithString:@"销售税"];
    NSString * string =@"运费";
    self.freightLabel.text = string;
    CGSize saleSize =  [NSString sizeWithString:LaguageControl(@"销售税") font:[UIFont systemFontOfSize:15] maxHeight:20 maxWeight:KScreenBoundWidth];
    CGSize freightSize =  [NSString sizeWithString:string font:[UIFont systemFontOfSize:15] maxHeight:20 maxWeight:KScreenBoundWidth];
    self.salesstaxLabelWidth.constant = saleSize.width+10;
    self.freightLabelWidth.constant = freightSize.width+10;
}


- (IBAction)selvipPriceAction:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(buyAndSendCostTableViewCell:btn:)]) {
        [_delegate buyAndSendCostTableViewCell:self btn:self.selvippricebtn];
    }
}
- (IBAction)isKaiFaPiaoClick:(UIButton *)sender {
    /**是否开发票*/
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.fapiaotypeLabel.alpha = self.companyBtn.alpha = self.personBtn.alpha = self.taxnumView.alpha = 1;
        self.fapiaoviewheight.constant = 44*4;
        self.fapiaotypeLabelHeight.constant = 44;
        self.taxnumviewheight.constant = 44*2;
    }else{
        self.fapiaotypeLabel.alpha = self.companyBtn.alpha = self.personBtn.alpha = self.taxnumView.alpha = 0;
        self.fapiaoviewheight.constant = 44;
        self.fapiaotypeLabelHeight.constant = 0;
        self.taxnumviewheight.constant = 0;

    }
    if (self.selKaiFaPiaoBlock) {
        self.selKaiFaPiaoBlock(sender.selected);
    }
}
- (IBAction)danweiOrPersonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    sender.layer.borderColor = sender.selected ? kNavigationCGColor:kTextDeepDarkColor.CGColor;
    /**单位个人*/
    if (sender.tag == 101) {
        /**单位*/
        self.personBtn.selected = NO;
        self.personBtn.layer.borderColor = kTextDeepDarkColor.CGColor;
        if (sender.selected) {
            self.kaifapiaoLabel.text = @"单位";
            self.fapiaoviewheight.constant = 88*2;
            self.taxnumView.alpha = 1;
            self.taxnumviewheight.constant = 88;
            if (self.selKaiFaPiaoTypeBlocy) {
                self.selKaiFaPiaoTypeBlocy(@"1");
            }
        }else{
             self.kaifapiaoLabel.text = @"";
            self.fapiaoviewheight.constant = 88;
            self.taxnumView.alpha = 0;
            self.taxnumviewheight.constant = 0;
            if (self.selKaiFaPiaoTypeBlocy) {
                self.selKaiFaPiaoTypeBlocy(@"2");
            }
        }
        
    }else{
        self.companyBtn.selected = NO;
        self.companyBtn.layer.borderColor = kTextDeepDarkColor.CGColor;

        if (sender.selected) {
            self.kaifapiaoLabel.text = @"个人";
            self.fapiaoviewheight.constant = 88;
            self.taxnumView.alpha = 0;
            self.taxnumviewheight.constant = 0;
            if (self.selKaiFaPiaoTypeBlocy) {
                self.selKaiFaPiaoTypeBlocy(@"0");
            }
        }else{
            self.kaifapiaoLabel.text = @"";
            if (self.selKaiFaPiaoTypeBlocy) {
                self.selKaiFaPiaoTypeBlocy(@"2");
            }
        }

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)CostDetailButtonClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(BuyAndSendCostTableShowCostButtonClicked:)])
    {
        if (sender==self.costDetialButton)
        {
            [self.delegate BuyAndSendCostTableShowCostButtonClicked:TaxTypesFreight];
        }
        else
        {
            [self.delegate BuyAndSendCostTableShowCostButtonClicked:TaxTypesSales];
        }
    }
}

@end
