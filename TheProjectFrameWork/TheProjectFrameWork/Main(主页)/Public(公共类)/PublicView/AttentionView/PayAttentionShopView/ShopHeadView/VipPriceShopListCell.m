//
//  VipPriceShopListCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/23.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "VipPriceShopListCell.h"

@implementation VipPriceShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moneylabel.textColor = self.yanglabel.textColor = [UIColor colorWithString:@"#e6e721"];
}

@end
