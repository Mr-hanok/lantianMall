//
//  GoodsScrollerTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsDetialModel;
@interface GoodsScrollerTableViewCell : UITableViewCell
/** 商品详情 */
@property (weak, nonatomic) IBOutlet UILabel *productInfoLabel;
/** 商品编号 */
@property (weak, nonatomic) IBOutlet UILabel *productNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *productnumber;
/** 商品重量 */
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weight;
/** 商品商标 */
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *brand;
/** 商品体积 */
@property (weak, nonatomic) IBOutlet UILabel *productDimensionsLabel;

@property (weak, nonatomic) IBOutlet UILabel *productDimens;

-(void)loadScrollerViewWithmodel:(GoodsDetialModel*)model;

@end
