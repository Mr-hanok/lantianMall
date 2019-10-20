//
//  HomeHeadViewCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeHeadViewCollectionViewCell.h"

@implementation HomeHeadViewCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.labelWidth.constant = KScreenBoundWidth/5-4;
    self.imageViewWidth.constant = KScreenBoundWidth/5-30;
    // Initialization code
}
- (void)setImagePath:(NSString *)imagePath
{
    _imagePath = imagePath;
}
@end
