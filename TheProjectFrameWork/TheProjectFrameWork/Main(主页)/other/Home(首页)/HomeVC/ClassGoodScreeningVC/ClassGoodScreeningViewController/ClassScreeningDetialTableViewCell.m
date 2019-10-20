//
//  ClassScreeningDetialTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassScreeningDetialTableViewCell.h"

@implementation ClassScreeningDetialTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)LoadDatawith:(id)model and:(BOOL)isselected
{
    if (isselected) {
        self.selectImageView.alpha = 1;
    }
    else{
        self.selectImageView.alpha = 0;
    }
}
@end
