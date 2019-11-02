//
//  IntegralHomeGoodsCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
@class IntegralHomeGoodsCell,IntegralHomeModel;
@protocol IntegralHomeGoodsCellDelegate <NSObject>

- (void)integralHomeCell:(IntegralHomeGoodsCell *)cell;

@end
#import <UIKit/UIKit.h>
/**积分商品cell 竖排*/
@interface IntegralHomeGoodsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsIntegralLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;

@property (nonatomic, weak) id <IntegralHomeGoodsCellDelegate> delegate;

- (void)configGoodsCellWithGoodsModel:(IntegralHomeModel *)model;
@end
