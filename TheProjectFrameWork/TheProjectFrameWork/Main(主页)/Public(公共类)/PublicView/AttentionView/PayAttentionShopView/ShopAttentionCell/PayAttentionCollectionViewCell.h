//
//  PayAttentionCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayAttentionCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
/** 商品名称 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@end
