//
//  HomeCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricesLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPreferentialPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *preferentialPriceLabelHegiht;

@end
