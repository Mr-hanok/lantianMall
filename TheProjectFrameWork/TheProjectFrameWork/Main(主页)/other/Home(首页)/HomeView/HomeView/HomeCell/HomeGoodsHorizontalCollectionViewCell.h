//
//  HomeGoodsHorizontalCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/19.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeGoodsHorizontalCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsIV;
@property (weak, nonatomic) IBOutlet UIView *priceView;

@end
