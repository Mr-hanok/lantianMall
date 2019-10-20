//
//  ImageCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "ShowImagesView.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhoto)];
    [self.evaluationImageView addGestureRecognizer:tap];
    self.evaluationImageView.userInteractionEnabled = YES;
}
- (void)clickPhoto
{
        ShowImagesView * showImage = [[ShowImagesView alloc] init];
        showImage.currentIndex = _indexRow;
        showImage.imagesPath = _dataArray;
        showImage.selectView = self.evaluationImageView;
        [showImage present];
}
@end
