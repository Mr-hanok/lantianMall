//
//  IntegralHomeGoodsCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "IntegralHomeGoodsCell.h"
#import "IntegralHomeModel.h"
#import "NSDate+Conversion.h"

@implementation IntegralHomeGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.masksToBounds =YES;
    self.backView.layer.cornerRadius = 5;
    [self.backView.layer setBorderWidth:1];
    self.backView.layer.borderColor = KSepLineColor.CGColor;
    
    self.convertBtn.layer.cornerRadius = 5.f;
    self.convertBtn.layer.borderWidth = 1.f;
    self.convertBtn.layer.borderColor = kNavigationCGColor;
    self.convertBtn.layer.masksToBounds =YES;
    
    self.goodsIntegralLabel.textColor = kNavigationColor;
    
}
- (void)configGoodsCellWithGoodsModel:(IntegralHomeModel *)model{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:kDefaultGoodsImgV]];

    self.goodsPriceLabel.text = [NSString stringWithFormat:@"市场价:￥%@",model.ig_goods_price];
    self.goodsIntegralLabel.text = [NSString stringWithFormat:@"%@%@",LaguageControlAppend(@"积分"),model.ig_goods_integral];
    self.goodsNamelabel.text = model.ig_goods_name;
    [self.convertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.convertBtn setTitle:LaguageControl(@"我要兑换") forState:UIControlStateNormal];
    
    if ([model.ig_goods_count isEqualToString:@"0"] || [model.ig_goods_count isEqualToString:@""] || model.ig_goods_count == nil || ![NSDate conversionToDate:model.ig_end_time limitType:model.ig_time_type]) {
        [self.convertBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.convertBtn.enabled = NO;
        self.convertBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;

    }else{
        [self.convertBtn setBackgroundColor:kNavigationColor];
        self.convertBtn.enabled = YES;
        self.convertBtn.layer.borderColor = kNavigationCGColor;
        
    }

}

- (IBAction)convertBtnClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(integralHomeCell:)]) {
        [_delegate integralHomeCell:self];
    }
}
@end
