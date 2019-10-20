//
//  VipPriceListCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/23.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "VipPriceListCell.h"
#import "NSString+Time.h"

@implementation VipPriceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)confitCellWithModel:(VipPriceModel *)model{

    if ([model.coupon_type isEqualToString:@"1"]) {
        self.vippriceTypeLabel.text = @"店铺";
        self.vipPriceDeslabel.text = model.store_name?:@"";
        self.topImageView.image = [UIImage imageNamed:@"shopvippriceImage"];
    }else{
        self.vippriceTypeLabel.text = @"通用";
        self.vipPriceDeslabel.text = @"平台通用";
        self.topImageView.image = [UIImage imageNamed:@"tongyongImage"];
    }
    
    self.vipPriceNameLabel.text = model.coupon_name;
    NSString *tempacmout = [NSString stringWithFormat:@"%.2f",[model.coupon_amount floatValue]];
    self.moneyLabel.text = tempacmout;
    if (tempacmout.length>6) {
        self.moneyLabel.font = [UIFont systemFontOfSize:40];
    }else{
        self.moneyLabel.font = [UIFont systemFontOfSize:48];
    }
    NSString *temporderacmout = [NSString stringWithFormat:@"%.2f",[model.coupon_order_amount floatValue]];

    if ([temporderacmout isEqualToString:@"0.00"]) {
        self.mandeslabel.text = @"代金券";

    }else{
        self.mandeslabel.text = [NSString stringWithFormat:@"满%@减%@",temporderacmout,tempacmout];

    }
    if ([model.overdue isEqualToString:@"0"]) {
        /**未过期 */
        self.yangLabel.textColor = self.moneyLabel.textColor = kNavigationColor;
        if ([model.status isEqualToString:@"0"]) {
            self.yangLabel.textColor = self.moneyLabel.textColor = kNavigationColor;
            self.userLabel.text = @"立即使用";
        }else {
            self.yangLabel.textColor = self.moneyLabel.textColor= kTextDeepDarkColor;
            self.userLabel.text = @"已使用";
            self.topImageView.image = [UIImage imageNamed:@"outtimeImage"];
        }
    }else{
        /**已过期*/
        self.yangLabel.textColor = self.moneyLabel.textColor= kTextDeepDarkColor;
        self.topImageView.image = [UIImage imageNamed:@"outtimeImage"];
        if ([model.status isEqualToString:@"1"]) {
            self.userLabel.text = @"已使用";
        }else{
            self.userLabel.text = @"已过期";
        }
    }
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"有效期:%@ - %@", [NSString YYYYMMDDTOYYYYMMDD:model.coupon_begin_time],[NSString YYYYMMDDTOYYYYMMDD:model.coupon_end_time]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
