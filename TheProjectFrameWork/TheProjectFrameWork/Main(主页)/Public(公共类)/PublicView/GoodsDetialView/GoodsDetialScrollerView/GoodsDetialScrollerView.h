//
//  GoodsDetialScrollerView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
#import "GoodsDetialModel.h"

@interface GoodsDetialScrollerView : BaseView
/** 商品描述 */
@property (weak, nonatomic) IBOutlet UIButton *goodsDescriptionButton;
/** 规格参数 */
@property (weak, nonatomic) IBOutlet UIButton *specificationButton;
/** 包装参数 */
@property (weak, nonatomic) IBOutlet UIButton *PackingparametersButton;
/** 展示WebView */
@property (weak, nonatomic) IBOutlet UIWebView *detialWebView;

@property(strong,nonatomic) GoodsDetialModel * model;

/**
 *  <#Description#>
 */
-(void)SetWebViewLoadUrl:(GoodsDetialModel*)model;
@end
