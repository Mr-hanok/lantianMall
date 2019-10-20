//
//  HomeGoodsCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/18.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *goodIV;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@end
