//
//  GoodsBriefInfoView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComplaintGoods,OrderGoodsModel;
@class GoodsBriefInfoView;
@protocol GoodsBriefInfoViewDelegate <NSObject>

/**
 *  点击商品
 */
- (void)goodsBriefInfoClick:(GoodsBriefInfoView *)view good_id:(NSString *)goodid;

@end
/**
 *  简要的商品信息
 */
@interface GoodsBriefInfoView : UIView
@property (nonatomic , strong) OrderGoodsModel * model;
@property (nonatomic , strong) ComplaintGoods * complaint;
@property (nonatomic , weak) id <GoodsBriefInfoViewDelegate> delegate;
@property (nonatomic , copy) NSString * contentString;
@property (nonatomic , assign) BOOL edit;
@end
