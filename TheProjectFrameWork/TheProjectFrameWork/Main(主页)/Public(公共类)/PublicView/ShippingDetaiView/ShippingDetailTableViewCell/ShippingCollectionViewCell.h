//
//  ShippingCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShippingCollectionViewCell : UICollectionViewCell

/** 货物图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
/** 税费 */
@property (weak, nonatomic) IBOutlet UILabel *TaxdetailsLabel;

@end
