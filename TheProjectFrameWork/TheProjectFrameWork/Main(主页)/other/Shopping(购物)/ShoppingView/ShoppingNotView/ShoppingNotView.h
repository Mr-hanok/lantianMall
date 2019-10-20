//
//  ShoppingNotView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/9/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
/**购物车没有商品view*/
@interface ShoppingNotView : BaseView
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 列表 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**
 *  是否展示网络请求
 *
 *  @param isShow <#isShow description#>
 */
-(void)LoadNetWorkError:(BOOL)isShow;

@end
