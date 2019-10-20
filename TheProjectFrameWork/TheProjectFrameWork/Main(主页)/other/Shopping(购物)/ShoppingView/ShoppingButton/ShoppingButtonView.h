//
//  ShoppingButtonView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@protocol ShoppingButtonViewDelegate <NSObject>

-(void)shoppingNumberChangeedvalue:(NSInteger)number;
@end
/**购物车商品加减按钮*/
@interface ShoppingButtonView : BaseView


/** 减 */
@property (weak, nonatomic) IBOutlet UIButton *subtractButton;
/** 购物数量 */
@property (weak, nonatomic) IBOutlet UILabel *shoppingNumber;
/** 加 */
@property (weak, nonatomic) IBOutlet UIButton *addButton;
/** 货物数量 */
@property(assign,nonatomic) NSInteger  goodsNumber;
/** 库存数量 */
@property(assign,nonatomic) NSInteger  goodsCollectionNumber;

@property(weak,nonatomic) id<ShoppingButtonViewDelegate> delegate;

+(ShoppingButtonView*)loadShoppingButtonViewWithShoppingNumber:(NSInteger )number frame:(CGRect)frame;
/** 设置库存 */
-(void)SetCollectionNumber:(NSInteger)number;
/** 设置起始数 */
-(void)SetTheGoodsNumber:(NSInteger)number;

/** 设置商品详情其实数量 */
-(void)SetGoodsDetialNumber:(NSInteger)number andCollection:(NSInteger )collectionnumber;

@end
