//
//  PopShopCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopShopCollectionViewCell.h"

@implementation PopShopCollectionViewCell

- (void)awakeFromNib {
    self.selectedIamgeView.layer.borderColor =[UIColor blackColor].CGColor;
    self.contentLabel.textColor = [UIColor blackColor];
    self.selectedIamgeView.layer.cornerRadius = 5;
    self.selectedIamgeView.layer.masksToBounds = YES;
    self.selectedIamgeView.layer.borderWidth = 1;
    // Initialization code
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        //选中时
        self.selectedIamgeView.layer.borderColor =kNavigationCGColor;
        self.contentLabel.textColor = kNavigationColor;
    }else{
        self.selectedIamgeView.layer.borderColor =[UIColor blackColor].CGColor;
        self.contentLabel.textColor = [UIColor blackColor];
        //非选中
    }
    
    // Configure the view for the selected state
}

@end
