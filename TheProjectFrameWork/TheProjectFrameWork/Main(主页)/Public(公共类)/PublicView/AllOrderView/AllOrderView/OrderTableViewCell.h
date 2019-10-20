//
//  OrderTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderTableViewCellDelegate <NSObject>

-(void)OrderTableViewCellApplyforRefundButton:(UIButton*)button withIndex:(NSIndexPath*)index;

@end

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentBackView;
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UIButton *applyforRefundButton;
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel;
@property(weak,nonatomic) id <OrderTableViewCellDelegate>  delegate;
@property(strong,nonatomic) NSIndexPath * indexPath;
@property (weak, nonatomic) IBOutlet UILabel *goodsnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;

-(void)loadData:(id)model andindex:(NSIndexPath*)index withSellerTypes:(SellerOrderTypes)types;
/** <#注释#> */
-(void)loadData:(id)model andindex:(NSIndexPath*)index;
/** 订单 */
-(void)loadOrderData:(id)model andindex:(NSIndexPath*)index;
/** 购物车中商品 */
-(void)loadCartData:(id)model andindex:(NSIndexPath*)index;


@end
