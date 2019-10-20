//
//  BuyAndSendCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyAndSendCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *buyGoodsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferentialLabel;
@property (weak, nonatomic) IBOutlet UIView *shareThumpView;
@property (weak, nonatomic) IBOutlet UIImageView *dividerImageView;
@property (weak, nonatomic) IBOutlet UILabel *sendGoodsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendGoodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sendImageView;
@property (weak, nonatomic) IBOutlet UIButton *buynowButton;

@end
