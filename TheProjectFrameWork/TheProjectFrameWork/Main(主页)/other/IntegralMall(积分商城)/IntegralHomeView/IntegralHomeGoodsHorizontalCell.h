//
//  IntegralHomeGoodsHorizontalCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

@class IntegralHomeGoodsHorizontalCell,IntegralHomeModel;
@protocol IntegralHomeGoodsHorizontalCellDelegate <NSObject>

- (void)integralHomeHorizontalCell:(IntegralHomeGoodsHorizontalCell *)cell;

@end


#import <UIKit/UIKit.h>
/**积分商城商品cell 横排*/
@interface IntegralHomeGoodsHorizontalCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *goodsIntegralLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;

@property (nonatomic, weak) id<IntegralHomeGoodsHorizontalCellDelegate> delegate;

- (void)configGoodsCellWithGoodsModel:(IntegralHomeModel *)model;
@end
