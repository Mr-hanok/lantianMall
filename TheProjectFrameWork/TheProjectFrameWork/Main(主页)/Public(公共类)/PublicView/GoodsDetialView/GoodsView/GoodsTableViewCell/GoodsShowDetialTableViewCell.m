//
//  GoodsShowDetialTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsShowDetialTableViewCell.h"

@implementation GoodsShowDetialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.specificationLabel.text = LaguageControl(@"请选择一个规格");
    if (KScreenBoundWidth>320)
    {
    }
    else
    {
        self.specificationLabel.font = KSystemFont(11);
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
