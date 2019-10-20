//
//  ShoppingCartTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
#import <UIKit/UIKit.h>
@class ShoppingButtonView;
@protocol ShoppingCartTableViewCellDelegate <NSObject>

-(void)goodsNumberChangeedWith:(id)goodsmodel withIndexPath:(NSIndexPath*)indexPath;

-(void)goodsButtonSelected:(UIButton*)button withIndexPath:(NSIndexPath*)indexPath;

@end
/**购物车商品cell*/
@interface ShoppingCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
/** 货物图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsDetialImageView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/** 商品下架 */
@property (weak, nonatomic) IBOutlet UILabel *isonlineLabel;

/** 物品名称 */
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
/** 物品描述 */
@property (weak, nonatomic) IBOutlet UILabel *goodsDescribtionLabel;
/** 物品数量View */
@property (weak, nonatomic) IBOutlet UIView *goodsView;
/** 选择按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seletedButton;
/** 获取某个cell */
@property (strong,nonatomic)  NSIndexPath *indexPath;
/** 代理回调 */
@property(assign,nonatomic)   id<ShoppingCartTableViewCellDelegate> delegate;
/**
 *  cell 加载
 *
 *  @param Model
 *  @param indexPath 
 */
-(void)goodsLoadShoppingCartWithModel:(id)model andIndexPath:(NSIndexPath*)indexPath   ISselect:(BOOL)selected;

@end
