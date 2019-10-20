//
//  ReferrerListCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/12.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "ReferrerListCell.h"

@implementation ReferrerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIV.layer.cornerRadius = 20.f;
    self.headIV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
