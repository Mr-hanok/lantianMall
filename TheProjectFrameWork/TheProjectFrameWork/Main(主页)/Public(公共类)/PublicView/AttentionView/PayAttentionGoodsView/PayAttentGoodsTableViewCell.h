//
//  PayAttentGoodsTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionDelegate.h"
@class StarView;
@interface PayAttentGoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *addShopCartButton;
@property (weak, nonatomic) IBOutlet UIButton *delegateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *StarView;
@property(strong,nonatomic) NSIndexPath * indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsPricesLabel;
@property (weak, nonatomic) IBOutlet UILabel *storePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescriptionLabel;

@property(weak,nonatomic) id <AttentionDelegate> deleagate;

-(void)loadDateWith:(id)model andindex:(NSIndexPath*)indexPath;

@end
