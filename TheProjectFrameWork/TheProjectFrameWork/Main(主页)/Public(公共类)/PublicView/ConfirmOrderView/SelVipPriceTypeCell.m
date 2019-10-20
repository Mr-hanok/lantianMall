//
//  SelVipPriceTypeCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/25.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "SelVipPriceTypeCell.h"

@implementation SelVipPriceTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lingquLabel.layer.borderWidth = 1;
    self.lingquLabel.layer.borderColor = kNavigationCGColor;
    self.lingquLabel.textColor = kNavigationColor;
    self.lingquLabel.layer.cornerRadius = 5;
    self.lingquLabel.layer.masksToBounds = YES;
}

@end
