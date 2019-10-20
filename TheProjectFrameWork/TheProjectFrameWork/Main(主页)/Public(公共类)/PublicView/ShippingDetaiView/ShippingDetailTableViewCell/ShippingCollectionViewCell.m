//
//  ShippingCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShippingCollectionViewCell.h"

@implementation ShippingCollectionViewCell

- (void)awakeFromNib {
    self.goodImageView.layer.masksToBounds =YES;
    self.goodImageView.layer.cornerRadius = 3;
    self.goodImageView.layer.borderWidth = 0.5;
    self.goodImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // Initialization code
}

@end
