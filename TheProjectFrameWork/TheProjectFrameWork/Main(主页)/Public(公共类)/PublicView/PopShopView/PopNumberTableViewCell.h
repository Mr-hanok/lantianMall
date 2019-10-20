//
//  PopNumberTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingButtonView.h"

@protocol PopNumberTableViewCellDelegate <NSObject>

-(void)numberOfgoods:(NSInteger)number;

@end

@interface PopNumberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UIView *goodsNumberView;
@property(weak,nonatomic) id<PopNumberTableViewCellDelegate>delegate;
@property(assign,nonatomic) ShoppingButtonView * shoppingButtonView;

-(void)loadData:(id)model;
/** 加载商品详情 */
-(void)loadDataGoodsNumber:(NSInteger)number andCollectionNumber:(NSInteger)collectionnumber;

@end
