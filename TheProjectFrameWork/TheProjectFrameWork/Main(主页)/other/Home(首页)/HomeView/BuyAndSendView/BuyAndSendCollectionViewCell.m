//
//  BuyAndSendCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyAndSendCollectionViewCell.h"

@implementation BuyAndSendCollectionViewCell

- (void)awakeFromNib {
    self.buynowButton.layer.masksToBounds =YES;
    self.buynowButton.layer.cornerRadius = 3;
    // Initialization code
}

@end
